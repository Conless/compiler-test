package middleend;

import ast.*;
import ast.expr.*;
import ast.stmt.*;
import ir.*;
import ir.inst.*;
import ir.module.IRGlobalVarDef;
import ir.module.IRFuncDef;
import ir.module.IRStringLiteralDef;
import ir.module.IRStructDef;
import ir.util.*;
import ir.util.entity.*;
import util.scope.*;
import ast.type.*;

import java.util.ArrayList;

public class IRBuilder implements ASTVisitor {

  IRProgram irProgram = null;
  IRBlock currentBlock = null;
  IRScope currentScope = null;
  GlobalScope globalScope = null;
  ExprVar lastExpr = null;
  int loopDepth = 0;

  public IRBuilder(IRProgram irProgram, GlobalScope globalScope) {
    this.irProgram = irProgram;
    this.globalScope = globalScope;
  }

  private int getSize(String type) {
    if (type.equals("int")) return 4;
    if (type.equals("ptr")) return 4;
    if (type.equals("bool")) return 4;
    var tmp = globalScope.getClassDecl(type);
    if (tmp == null) throw new RuntimeException("IRBuilder: unknown type");
    return tmp.getSize();
  }

  private IRType transType(ExprType type) {
    if (type.isFunc) throw new RuntimeException("IREntity: function type");
    if (type.isVoid) return new IRType("void");
    else if (type.dim > 0 || type.isNull || type.isClass || type.isString) return new IRType("ptr");
    else if (type.isInt) return new IRType("i32");
    else if (type.isBool) return new IRType("i1");
    else throw new RuntimeException("IREntity: unknown type");
  }

  public void visit(ProgramNode node) {
    for (var def : node.decls) {
      def.accept(this);
    }
    var tmp = irProgram.functions.get("__init");
    if (tmp != null) {
      currentBlock = tmp.body.get(tmp.body.size() - 1);
      currentBlock.addInst(new IRRetInst(currentBlock, null));
      currentBlock = irProgram.functions.get("main").body.get(0);
      currentBlock.addInst(0, new IRCallInst(currentBlock, null, "__init"));
    }
  }

  public void visit(FuncDefNode node) {
    currentScope = new IRScope(currentScope);
    String tmp_name = node.name;
    if (currentScope.className != null)
      tmp_name = currentScope.className + ".." + tmp_name;
    var func = new IRFuncDef(transType(new ExprType(node.retType)), tmp_name);
    irProgram.functions.put(tmp_name, func);
    currentBlock = func.body.get(0);

    node.paraList.accept(this);
    for (var stmt : node.stmt_List) {
      stmt.accept(this);
    }

    currentScope = currentScope.parent;
    currentBlock = null;
  }
  public void visit(ClassDefNode node) {
    ArrayList<IRType> memberTypes = new ArrayList<>();
    ArrayList<String> names = new ArrayList<>();

    int size = 0;
    for (var member : node.varDef_list) {
      int num = member.varList.size();
      for (int i = 0; i < num; ++i) {
        memberTypes.add(transType(new ExprType(member.type)));
        names.add(member.varList.get(i).first);
      }
      if (member.type.dim > 0 || member.type.isString || member.type.isClass) size += 8 * num;
      else if (member.type.isBool) size += num;
      else size += 4 * num;
    }
    globalScope.getClassDecl(node.name).setSize(size);
    irProgram.structs.put(node.name, new IRStructDef(node.name, memberTypes, names));
    currentScope = new IRScope(currentScope, node.name);

    if (node.classBuild != null) node.classBuild.accept(this);
    for (var func : node.funcDef_list) {
      func.accept(this);
    }

    currentScope = null;
  }
  public void visit(VarDefNode node) {
    IRType varType = transType(new ExprType(node.type));
    if (currentScope == null) { // in global scope
      // global variables don't need to rename
      for (var pair : node.varList) {
        GlobalPtr ptr = new GlobalPtr(pair.first);

        if (pair.second == null) { // no initial value
          irProgram.globals.put(pair.first, new IRGlobalVarDef(ptr, null, varType));
          continue;
        }
        if (pair.second instanceof AtomExprNode tmp && (tmp.isIntConst || tmp.isTrue || tmp.isFalse || tmp.isNull)) {
          if (tmp.isTrue)
            irProgram.globals.put(pair.first, new IRGlobalVarDef(ptr, "1", varType));
          else if (tmp.isFalse)
            irProgram.globals.put(pair.first, new IRGlobalVarDef(ptr, "0", varType));
          else
            irProgram.globals.put(pair.first, new IRGlobalVarDef(ptr, ((AtomExprNode) pair.second).identifier, varType));
          continue;
        }
        irProgram.globals.put(pair.first, new IRGlobalVarDef(ptr, null, varType));

        // do initialization
        if (!irProgram.functions.containsKey("__init")) irProgram.functions.put("__init", new IRFuncDef(new IRType("void"), "__init"));
        var tmp = irProgram.functions.get("__init");
        currentBlock = tmp.body.get(tmp.body.size() - 1);
        pair.second.accept(this);
        currentBlock.addInst(new IRStoreInst(currentBlock, lastExpr.value, ptr));
      }
    } else { // in local scope
      for (var pair : node.varList) {
        int no = currentBlock.parent.idCnt.getOrDefault(pair.first, 0);
        currentBlock.parent.idCnt.put(pair.first, ++no);
        currentScope.addVar(pair.first, no);
        LocalVar ptr = new LocalVar(new IRType("ptr"), pair.first + "." + no);
        currentBlock.addInst(new IRAllocaInst(currentBlock, ptr, varType));
        if (pair.second != null) { // initial value
          pair.second.accept(this);
          currentBlock.addInst(new IRStoreInst(currentBlock, lastExpr.value, ptr));
        }
      }
    }
  }
  public void visit(ParaListNode node) {
    // already in entry block(currentBlock)
    // already in a funcScope
    var tmp = currentBlock.parent;
    if (currentScope.className != null) // if in class, add a "this" parameter
      tmp.paras.add(new LocalVar(new IRType("ptr"), "this"));
    for (var para : node.paras) {
      // i32 %a
      tmp.paras.add(new LocalVar(transType(new ExprType(para.first)), para.second));
    }

    for (var para : tmp.paras) {
      int no = currentBlock.parent.idCnt.getOrDefault(para.getName(), 0);
      currentBlock.parent.idCnt.put(para.getName(), ++no);
      currentScope.addVar(para.getName(), no);
      var ptr = new LocalVar(new IRType("ptr"), para.getName() + "." + no);
      // add: %a.1 = alloca i32
      currentBlock.addInst(new IRAllocaInst(currentBlock, ptr, para.getType()));
      // add: store i32 %a, ptr %a.1
      currentBlock.addInst(new IRStoreInst(currentBlock, para, ptr));
    }
  }
  public void visit(ClassBuildNode node) {
    // already in a classScope
    var func = new IRFuncDef(new IRType("void"), currentScope.className + ".." + node.name);
    func.paras.add(new LocalVar(new IRType("ptr"), "this"));
    irProgram.functions.put(currentScope.className + ".." + node.name, func);
    currentScope = new IRScope(currentScope);
    currentBlock = func.body.get(0);

    currentScope.addVar("this", 1);
    func.idCnt.put("this", 1);
    var ptr = new LocalVar(new IRType("ptr"), "this.1");
    currentBlock.addInst(new IRAllocaInst(currentBlock, ptr, new IRType("ptr")));
    currentBlock.addInst(new IRStoreInst(currentBlock, new LocalVar(new IRType("ptr"), "this"), ptr));

    for (var stmt : node.stmt_List) {
      stmt.accept(this);
    }

    currentScope = currentScope.parent;
    currentBlock = null;
  }

  public void visit(BlockStmtNode node) {
    currentScope = new IRScope(currentScope);
    for (var stmt : node.stmts) {
      stmt.accept(this);
    }
    currentScope = currentScope.parent;
  }
  public void visit(IfStmtNode node) {
    node.cond.accept(this);

    int no = currentBlock.parent.ifCnt++;
    IRBlock then = new IRBlock("if.then." + no, currentBlock.parent, loopDepth);
    IRBlock else_ = new IRBlock("if.else." + no, currentBlock.parent, loopDepth);
    IRBlock end = new IRBlock("if.end." + no, currentBlock.parent, loopDepth);

    if (node.elseStmt != null) {
      if (lastExpr.value instanceof IRLiteral literal) {
        if (literal.getIntValue() == 0)
          currentBlock.addInst(new IRJumpInst(currentBlock, else_));
        else
          currentBlock.addInst(new IRJumpInst(currentBlock, then));
      } else {
        currentBlock.addInst(new IRBrInst(currentBlock, (LocalVar) lastExpr.value, then, else_));
      }
    } else {
      if (lastExpr.value instanceof IRLiteral literal) {
        if (literal.getIntValue() == 0)
          currentBlock.addInst(new IRJumpInst(currentBlock, end));
        else
          currentBlock.addInst(new IRJumpInst(currentBlock, then));
      } else {
        currentBlock.addInst(new IRBrInst(currentBlock, (LocalVar) lastExpr.value, then, end));
      }
    }

    currentBlock = currentBlock.parent.addBlock(then);
    currentScope = new IRScope(currentScope);
    node.thenStmt.accept(this);
    currentBlock.addInst(new IRJumpInst(currentBlock, end));
    currentScope = currentScope.parent;

    if (node.elseStmt != null) {
      currentBlock = currentBlock.parent.addBlock(else_);
      currentScope = new IRScope(currentScope);
      node.elseStmt.accept(this);
      currentBlock.addInst(new IRJumpInst(currentBlock, end));
      currentScope = currentScope.parent;
    }

    currentBlock = currentBlock.parent.addBlock(end);
  }
  public void visit(WhileStmtNode node) {
    int no = currentBlock.parent.whileCnt++;
    loopDepth++;
    IRBlock cond = new IRBlock("while.cond." + no, currentBlock.parent, loopDepth);
    IRBlock end = new IRBlock("while.end." + no, currentBlock.parent, loopDepth - 1);
    IRBlock body = new IRBlock("while.body." + no, currentBlock.parent, loopDepth);

    currentBlock.addInst(new IRJumpInst(currentBlock, cond));
    currentBlock = currentBlock.parent.addBlock(cond);
    node.cond.accept(this);
    if (lastExpr.value instanceof IRLiteral literal) {
      if (literal.getIntValue() == 0)
        currentBlock.addInst(new IRJumpInst(currentBlock, end));
      else
        currentBlock.addInst(new IRJumpInst(currentBlock, body));
    } else {
      currentBlock.addInst(new IRBrInst(currentBlock, (LocalVar) lastExpr.value, body, end));
    }

    currentBlock = currentBlock.parent.addBlock(body);
    currentScope = new IRScope(currentScope, end, cond);
    node.body.accept(this);
    currentBlock.addInst(new IRJumpInst(currentBlock, cond));
    currentScope = currentScope.parent;

    currentBlock = currentBlock.parent.addBlock(end);
    loopDepth--;
  }
  public void visit(ForStmtNode node) {
    int no = currentBlock.parent.forCnt++;
    loopDepth++;
    IRBlock end = new IRBlock("for.end." + no, currentBlock.parent, loopDepth - 1);
    IRBlock cond = new IRBlock("for.cond." + no, currentBlock.parent, loopDepth);
    IRBlock body = new IRBlock("for.body." + no, currentBlock.parent, loopDepth);
    IRBlock step = new IRBlock("for.step." + no, currentBlock.parent, loopDepth);
    currentScope = new IRScope(currentScope, end, step);

    if (node.initStmt != null)
      node.initStmt.accept(this);
    currentBlock.addInst(new IRJumpInst(currentBlock, cond));

    currentBlock = currentBlock.parent.addBlock(cond);
    if (node.condExpr != null) {
      node.condExpr.accept(this);
      if (lastExpr.value instanceof IRLiteral literal) {
        if (literal.getIntValue() == 0)
          currentBlock.addInst(new IRJumpInst(currentBlock, end));
        else
          currentBlock.addInst(new IRJumpInst(currentBlock, body));
      } else {
        currentBlock.addInst(new IRBrInst(currentBlock, (LocalVar) lastExpr.value, body, end));
      }
    }
    else {
      currentBlock.addInst(new IRJumpInst(currentBlock, body));
    }

    currentBlock = currentBlock.parent.addBlock(body);
    if (node.body != null)
      node.body.accept(this);
    currentBlock.addInst(new IRJumpInst(currentBlock, step));

    currentBlock = currentBlock.parent.addBlock(step);
    if (node.stepExpr != null)
      node.stepExpr.accept(this);
    currentBlock.addInst(new IRJumpInst(currentBlock, cond));

    currentScope = currentScope.parent;
    currentBlock = currentBlock.parent.addBlock(end);
    loopDepth--;
  }
  public void visit(ContinueStmtNode node) {
    if (currentScope.loopNext == null) throw new RuntimeException("continue not in loop");
    currentBlock.addInst(new IRJumpInst(currentBlock, currentScope.loopNext));
  }
  public void visit(BreakStmtNode node) {
    if (currentScope.loopEnd == null) throw new RuntimeException("break not in loop");
    currentBlock.addInst(new IRJumpInst(currentBlock, currentScope.loopEnd));
  }
  public void visit(ReturnStmtNode node) {
    if (node.retExpr == null) {
      currentBlock.addInst(new IRRetInst(currentBlock, null));
    } else {
      node.retExpr.accept(this);
      currentBlock.addInst(new IRRetInst(currentBlock, lastExpr.value));
    }
  }
  public void visit(ExprStmtNode node) {
    node.expr.accept(this);
  }
  public void visit(VardefStmtNode node) {
    node.varDef.accept(this);
  }

  public void visit(AtomExprNode node) {
    if (node.type.isFunc) {
      // ! check if it is a member function
      FuncInfo tmp = null;
      if (currentScope != null && currentScope.className != null) {
        var classInfo = globalScope.getClassDecl(currentScope.className);
        if (classInfo.getFunc(node.identifier) != null) {
          var this_tmp = new LocalVar(new IRType("ptr"), String.valueOf(currentBlock.parent.varCnt++));
          currentBlock.addInst(new IRLoadInst(currentBlock, this_tmp, new LocalVar(new IRType("ptr"), "this.1")));
          tmp = new FuncInfo(currentScope.className + ".." + node.identifier, transType(node.type.funcDecl.getRetType()), this_tmp);
        }
      }
      if (tmp == null) tmp = new FuncInfo(node.identifier, transType(node.type.funcDecl.getRetType()), null);
      lastExpr = new ExprVar(null, null, tmp);
      return;
    }
    if (node.isLeftValue) {
      // ! 应该先看局部变量！再看class内的成员变量，最后看全局变量
      IRVariable ptr = null;
      if (currentScope != null && currentScope.getVarNo(node.identifier) > 0) { // Local variable
        ptr = new LocalVar(new IRType("ptr"), node.identifier + "." + currentScope.getVarNo(node.identifier));
      } else if (currentScope != null && currentScope.className != null) {
        // member variable
        ptr = new LocalVar(new IRType("ptr"), String.valueOf(currentBlock.parent.varCnt++));
        var this_tmp = new LocalVar(new IRType("ptr"), String.valueOf(currentBlock.parent.varCnt++));
        currentBlock.addInst(new IRLoadInst(currentBlock, this_tmp, new LocalVar(new IRType("ptr"), "this.1")));
        var inst = new IRGetElementPtrInst(currentBlock, (LocalVar) ptr, "%class." + currentScope.className, this_tmp, new IRLiteral("0", new IRType("i32")));
        inst.indexs.add(new IRLiteral(String.valueOf(irProgram.structs.get(currentScope.className).getIndexOf(node.identifier)), new IRType("i32")));
        currentBlock.addInst(inst);
      } else {
        // global variable
        ptr = new GlobalPtr(node.identifier);
      }

      var value = new LocalVar(transType(node.type), String.valueOf(currentBlock.parent.varCnt++));
      currentBlock.addInst(new IRLoadInst(currentBlock, value, ptr));
      lastExpr = new ExprVar(value, ptr, null);
      return;
    }
    if (node.isStringConst) {
      GlobalPtr ptr = new GlobalPtr("string." + irProgram.stringLiteralCnt++);

      StringBuilder tmp = new StringBuilder();
      for (int i = 0; i < node.identifier.length(); ++i) {
        char c = node.identifier.charAt(i);
        if (c == '\\') {
          ++i;
          switch (node.identifier.charAt(i)) {
            case 'n' -> tmp.append('\n');
            case '\"' -> tmp.append('\"');
            case '\\' -> tmp.append('\\');
            default -> throw new RuntimeException("unknown escape character");
          }
        } else {
          tmp.append(c);
        }
      }
      irProgram.stringLiterals.add(new IRStringLiteralDef(ptr, tmp.toString(), node.identifier));
      lastExpr = new ExprVar(ptr, null, null);
    } else {
      var type = transType(node.type);
      if (node.isTrue)
        lastExpr = new ExprVar(new IRLiteral("1", type), null, null);
      else if (node.isFalse)
        lastExpr = new ExprVar(new IRLiteral("0", type), null, null);
      else
        lastExpr = new ExprVar(new IRLiteral(node.identifier, type), null, null);
    }
  }
  public void visit(BinaryExprNode node) {
    node.lhs.accept(this);
    var lhsVar = lastExpr.value;

    if (node.op.equals("&&") || node.op.equals("||")) {
      if (lastExpr.value instanceof IRLiteral literal) {
        if (literal.getIntValue() == 0) {
          if (node.op.equals("&&"))
            lastExpr = new ExprVar(new IRLiteral("0", new IRType("i32")), null, null);
          else
            node.rhs.accept(this);
        } else {
          if (node.op.equals("||"))
            lastExpr = new ExprVar(new IRLiteral("1", new IRType("i32")), null, null);
          else
            node.rhs.accept(this);
        }
        return;
      }

      int no = currentBlock.parent.ifCnt++;
      IRBlock end = new IRBlock("if.end." + no, currentBlock.parent, loopDepth);
      IRBlock then = new IRBlock("if.then." + no, currentBlock.parent, loopDepth);
      IRBlock else_ = new IRBlock("if.else." + no, currentBlock.parent, loopDepth);

      currentBlock.addInst(new IRBrInst(currentBlock, (LocalVar) lhsVar, then, else_));
      currentBlock = currentBlock.parent.addBlock(then);
      if (node.op.equals("&&")) node.rhs.accept(this);
      currentBlock.addInst(new IRJumpInst(currentBlock, end));
      IRBlock thenBlock = currentBlock;

      currentBlock = currentBlock.parent.addBlock(else_);
      if (!node.op.equals("&&")) node.rhs.accept(this);
      currentBlock.addInst(new IRJumpInst(currentBlock, end));
      IRBlock elseBlock = currentBlock;

      currentBlock = currentBlock.parent.addBlock(end);
      var ret = new LocalVar(new IRType("i1"), String.valueOf(currentBlock.parent.varCnt++));
      var inst = new IRPhiInst(currentBlock, ret, new IRType("i1"));
      inst.addBranch((node.op.equals("&&") ? lastExpr.value : lhsVar), thenBlock);
      inst.addBranch((node.op.equals("&&") ? lhsVar : lastExpr.value), elseBlock);
      currentBlock.phiInsts.put(ret.getName(), inst);
      lastExpr = new ExprVar(ret, null, null);
      return;
    }

    node.rhs.accept(this);
    var rhsVar = lastExpr.value;

    if (node.lhs.type.dim == 0 && node.lhs.type.isString) {
      LocalVar retVar = new LocalVar(transType(node.type), String.valueOf(currentBlock.parent.varCnt++));
      if (node.op.equals("+")) {
        currentBlock.addInst(new IRCallInst(currentBlock, retVar, "_string.concat", lhsVar, rhsVar));
      } else {
        var tmp = new LocalVar(new IRType("i32"), String.valueOf(currentBlock.parent.varCnt++));
        currentBlock.addInst(new IRCallInst(currentBlock, tmp, "_string.compare", lhsVar, rhsVar));
        currentBlock.addInst(new IRIcmpInst(currentBlock, retVar, node.op, tmp, new IRLiteral("0", new IRType("i32"))));
      }
      lastExpr = new ExprVar(retVar, null, null);
      return;
    }

    if (lhsVar instanceof IRLiteral lhs && lhs.getType().isInt && rhsVar instanceof IRLiteral rhs && rhs.getType().isInt) {
      int l = lhs.getIntValue();
      int r = rhs.getIntValue();
      int ans = 0;
      if ((node.op.equals("/") || node.op.equals("%")) && r == 0) {
        lastExpr = new ExprVar(new IRLiteral(String.valueOf(ans), new IRType("i32")), null, null);
        return;
      }
      ans = switch (node.op) {
        case "==" -> l == r ? 1 : 0;
        case "!=" -> l != r ? 1 : 0;
        case ">" -> l > r ? 1 : 0;
        case ">=" -> l >= r ? 1 : 0;
        case "<" -> l < r ? 1 : 0;
        case "<=" -> l <= r ? 1 : 0;
        case "+" -> l + r;
        case "-" -> l - r;
        case "*" -> l * r;
        case "/" -> l / r;
        case "%" -> l % r;
        case "<<" -> l << r;
        case ">>" -> l >> r;
        case "&" -> l & r;
        case "^" -> l ^ r;
        case "|" -> l | r;
        default -> throw new RuntimeException("unknown binary operator");
      };
      lastExpr = new ExprVar(new IRLiteral(String.valueOf(ans), new IRType("i32")), null, null);
      return;
    }

    LocalVar retVar = new LocalVar(transType(node.type), String.valueOf(currentBlock.parent.varCnt++));
    if (node.op.equals("==") || node.op.equals("!=") || node.op.equals(">") || node.op.equals(">=") || node.op.equals("<") || node.op.equals("<=")) {
      currentBlock.addInst(new IRIcmpInst(currentBlock, retVar, node.op, lhsVar, rhsVar));
    } else {
      currentBlock.addInst(new IRBinaryInst(currentBlock, retVar, node.op, lhsVar, rhsVar));
    }
    lastExpr = new ExprVar(retVar, null, null);
  }
  public void visit(UnaryExprNode node) { // all right value
    node.expr.accept(this);

    var tmp = new LocalVar(transType(node.type), String.valueOf(currentBlock.parent.varCnt++));
    switch (node.op) {
      case "!" -> {
        currentBlock.addInst(new IRBinaryInst(currentBlock, tmp, "^", lastExpr.value, new IRLiteral("1", new IRType("i1"))));
        lastExpr = new ExprVar(tmp, null, null);
      }
      case "~" -> {
        currentBlock.addInst(new IRBinaryInst(currentBlock, tmp, "^", lastExpr.value, new IRLiteral("-1", new IRType("i32"))));
        lastExpr = new ExprVar(tmp, null, null);
      }
      case "++", "--" -> {
        currentBlock.addInst(new IRBinaryInst(currentBlock, tmp, node.op.equals("++") ? "+" : "-", lastExpr.value, new IRLiteral("1", new IRType("i32"))));
        currentBlock.addInst(new IRStoreInst(currentBlock, tmp, lastExpr.destptr));
        lastExpr = new ExprVar(lastExpr.value, null, null);
      }
      case "+", "-" -> {
        currentBlock.addInst(new IRBinaryInst(currentBlock, tmp, node.op, new IRLiteral("0", new IRType("i32")), lastExpr.value));
        lastExpr = new ExprVar(tmp, null, null);
      }
      default -> throw new RuntimeException("unknown unary operator");
    }
  }
  public void visit(PreSelfExprNode node) {
    node.expr.accept(this);
    var tmp = new LocalVar(transType(node.type), String.valueOf(currentBlock.parent.varCnt++));
    currentBlock.addInst(new IRBinaryInst(currentBlock, tmp, node.op.equals("++") ? "+" : "-", lastExpr.value, new IRLiteral("1", new IRType("i32"))));
    currentBlock.addInst(new IRStoreInst(currentBlock, tmp, lastExpr.destptr));
    lastExpr = new ExprVar(tmp, lastExpr.destptr, null);
  }
  public void visit(AssignExprNode node) {
    node.lhs.accept(this);
    var dst = lastExpr.destptr;
    if (dst == null) throw new RuntimeException("assign to a right value");
    node.rhs.accept(this);

    if (node.lhs.type.dim == 0 && node.lhs.type.isString) {
      var tmp = new LocalVar(new IRType("ptr"), String.valueOf(currentBlock.parent.varCnt++));
      currentBlock.addInst(new IRCallInst(currentBlock, tmp, "_string.copy", lastExpr.value));
      currentBlock.addInst(new IRStoreInst(currentBlock, tmp, dst));
    } else {
      currentBlock.addInst(new IRStoreInst(currentBlock, lastExpr.value, dst));
    }
    lastExpr = new ExprVar(lastExpr.value, null, null);
  }
  public void visit(CallExprNode node){
    node.func.accept(this);
    if (lastExpr.funcInfo == null) {
      // array.size(): the ret value(i32) is already stored in lastExpr.value
      return;
    }
    IRCallInst ret = null;
    if (lastExpr.funcInfo.retType.isVoid) {
      ret = new IRCallInst(currentBlock, null, lastExpr.funcInfo.name);
    }
    else {
      var result = new LocalVar(lastExpr.funcInfo.retType, String.valueOf(currentBlock.parent.varCnt++));
      ret = new IRCallInst(currentBlock, result, lastExpr.funcInfo.name);
    }

    if (lastExpr.funcInfo.thisptr != null)
      ret.args.add(lastExpr.funcInfo.thisptr);
    for (var arg : node.args) {
      arg.accept(this);
      ret.args.add(lastExpr.value);
    }
    currentBlock.addInst(ret);

    if (ret.result == null)
      lastExpr = null;
    else
      lastExpr = new ExprVar(ret.result, null, null);
  }
  public void visit(ArrayExprNode node) {
    node.array.accept(this);
    var array = (IRVariable) lastExpr.value;
    node.index.accept(this);
    var type = transType(node.type);

    LocalVar retptr = new LocalVar(new IRType("ptr"), String.valueOf(currentBlock.parent.varCnt++));
    currentBlock.addInst(new IRGetElementPtrInst(currentBlock, retptr, type.toString(), array, lastExpr.value));

    LocalVar ret = new LocalVar(type, String.valueOf(currentBlock.parent.varCnt++));
    currentBlock.addInst(new IRLoadInst(currentBlock, ret, retptr));

    lastExpr = new ExprVar(ret, retptr, null);
  }
  public void visit(MemberExprNode node) {
    node.obj.accept(this);
    if (node.obj.type.dim > 0) { // 数组.size
      LocalVar tmp = new LocalVar(new IRType("ptr"), String.valueOf(currentBlock.parent.varCnt++));
      currentBlock.addInst(new IRGetElementPtrInst(currentBlock, tmp, "i32", (IRVariable) lastExpr.value, new IRLiteral("-1", new IRType("i32"))));
      var ret = new LocalVar(new IRType("i32"), String.valueOf(currentBlock.parent.varCnt++));
      currentBlock.addInst(new IRLoadInst(currentBlock, ret, tmp));
      lastExpr = new ExprVar(ret, null, null);
    } else {
      var className = node.obj.type.name;
      var classInfo = globalScope.getClassDecl(className);
      var memFunc = classInfo.getFunc(node.member);
      if (memFunc != null) {
        if (!(lastExpr.value instanceof LocalVar))
          throw new RuntimeException("this is not a pointer");
        lastExpr = new ExprVar(null, null, new FuncInfo((className.equals("string")) ? "_string." + node.member : className + ".." + node.member,
                transType(memFunc.getRetType()), (LocalVar) lastExpr.value));
        return;
      }

      var memVar = classInfo.getVar(node.member);
      if (memVar == null) throw new RuntimeException("no such member");

      var tmp = new LocalVar(new IRType("ptr"), String.valueOf(currentBlock.parent.varCnt++));
      var inst = new IRGetElementPtrInst(currentBlock, tmp, "%class." + className, (IRVariable) lastExpr.value, new IRLiteral("0", new IRType("i32")));
      inst.indexs.add(new IRLiteral(String.valueOf(irProgram.structs.get(className).getIndexOf(node.member)), new IRType("i32")));
      currentBlock.addInst(inst);
      var value = new LocalVar(transType(new ExprType(memVar)), String.valueOf(currentBlock.parent.varCnt++));
      currentBlock.addInst(new IRLoadInst(currentBlock, value, tmp));
      lastExpr = new ExprVar(value, tmp, null);
    }
  }

  private LocalVar NewArray(ArrayList<IREntity> sizes, int layer, BaseType type) {
    if (layer == sizes.size() - 1) {
      var size = sizes.get(layer);
      LocalVar ret = new LocalVar(new IRType("ptr"), String.valueOf(currentBlock.parent.varCnt++));
      String tmp = null;
      if (type == null || type.isString || type.isClass) tmp = "ptr";
      else if (type.isBool) tmp = "bool";
      else if (type.isInt) tmp = "int";
      else throw new RuntimeException("unknown type");
      currentBlock.addInst(new IRCallInst(currentBlock, ret, "_malloc_array", new IRLiteral(String.valueOf(getSize(tmp)), new IRType("i32")), size));
      return ret;
    }

    var size = sizes.get(layer);
    LocalVar ret = new LocalVar(new IRType("ptr"), String.valueOf(currentBlock.parent.varCnt++));
    currentBlock.addInst(new IRCallInst(currentBlock, ret, "_malloc_array", new IRLiteral(String.valueOf(getSize("ptr")), new IRType("i32")), size));

    // for.init: int i = 0
    int no = currentBlock.parent.forCnt++;
    loopDepth++;
    IRBlock cond = new IRBlock("for.cond." + no, currentBlock.parent, loopDepth);
    IRBlock end = new IRBlock("for.end." + no, currentBlock.parent, loopDepth - 1);
    IRBlock body = new IRBlock("for.body." + no, currentBlock.parent, loopDepth);
    IRBlock step = new IRBlock("for.step." + no, currentBlock.parent, loopDepth);

    var cnt = new LocalVar(new IRType("ptr"), String.valueOf(currentBlock.parent.varCnt++)); // store i
    currentBlock.addInst(new IRAllocaInst(currentBlock, cnt, new IRType("i32")));
    currentBlock.addInst(new IRStoreInst(currentBlock, new IRLiteral("0", new IRType("i32")), cnt));
    currentBlock.addInst(new IRJumpInst(currentBlock, cond));

    // for.cond: i < size
    currentBlock = currentBlock.parent.addBlock(cond);
    var cntValue = new LocalVar(new IRType("i32"), String.valueOf(currentBlock.parent.varCnt++)); // load i
    currentBlock.addInst(new IRLoadInst(currentBlock, cntValue, cnt));
    var cmp = new LocalVar(new IRType("i1"), String.valueOf(currentBlock.parent.varCnt++));
    currentBlock.addInst(new IRIcmpInst(currentBlock, cmp, "<", cntValue, size));
    currentBlock.addInst(new IRBrInst(currentBlock, cmp, body, end));

    // for.body: ret[i] = NewArray(nextSize, elementSize)
    currentBlock = currentBlock.parent.addBlock(body);
    if (!type.isString) {
      var nextptr = new LocalVar(new IRType("ptr"), String.valueOf(currentBlock.parent.varCnt++));
      currentBlock.addInst(new IRGetElementPtrInst(currentBlock, nextptr, "ptr", ret, cntValue));
      // recursive call
      var nxtValue = NewArray(sizes,layer + 1, type); // nxtvalue must be ptr
      currentBlock.addInst(new IRStoreInst(currentBlock, nxtValue, nextptr));
    }
    currentBlock.addInst(new IRJumpInst(currentBlock, step));

    // for.step: i++
    currentBlock = currentBlock.parent.addBlock(step);
    var inc = new LocalVar(new IRType("i32"), String.valueOf(currentBlock.parent.varCnt++));
    currentBlock.addInst(new IRBinaryInst(currentBlock, inc, "+", cntValue, new IRLiteral("1", new IRType("i32"))));
    currentBlock.addInst(new IRStoreInst(currentBlock, inc, cnt));
    currentBlock.addInst(new IRJumpInst(currentBlock, cond));

    // for.end
    currentBlock = currentBlock.parent.addBlock(end);
    loopDepth--;
    return ret;
  }

  public void visit(NewExprNode node) {
    if (node.type.dim == 0) {
      // single class-type variable
      // ! alloca is stack memory, malloc is heap memory
      var tmp = new LocalVar(new IRType("ptr"), String.valueOf(currentBlock.parent.varCnt++));
      currentBlock.addInst(new IRCallInst(currentBlock, tmp, "_malloc", new IRLiteral(String.valueOf(getSize(node.type.name)), new IRType("i32"))));
//      currentBlock.addInst(new Alloca(tmp, node.type.name));
      if (globalScope.getClassDecl(node.type.name).hasBuildFunc())
        currentBlock.addInst(new IRCallInst(currentBlock, null, node.type.name + ".." + node.type.name, tmp));
      lastExpr = new ExprVar(tmp, null, null);
      return;
    }
    var sizes = new ArrayList<IREntity>();
    for (var size : node.exprList) {
      size.accept(this);
      sizes.add(lastExpr.value);
    }
    if (node.varType.dim == sizes.size())
      lastExpr = new ExprVar(NewArray(sizes, 0, node.varType), null, null);
    else if (node.varType.dim > sizes.size())
      lastExpr = new ExprVar(NewArray(sizes, 0, null), null, null);
    else throw new RuntimeException("array dimension error");
  }
  public void visit(ConditionalExprNode node) {
    node.cond.accept(this);
    if (lastExpr.value instanceof IRLiteral literal) {
      if (literal.getIntValue() == 0) {
        node.elseExpr.accept(this);
      } else {
        node.thenExpr.accept(this);
      }
      return;
    }

    int no = currentBlock.parent.condCnt++;
    IRBlock then = new IRBlock("cond.then." + no, currentBlock.parent, loopDepth);
    IRBlock end = new IRBlock("cond.end." + no, currentBlock.parent, loopDepth);
    IRBlock else_ = new IRBlock("cond.else." + no, currentBlock.parent, loopDepth);
    currentBlock.addInst(new IRBrInst(currentBlock, (LocalVar) lastExpr.value, then, else_));

    currentBlock = currentBlock.parent.addBlock(then);
    node.thenExpr.accept(this);
    var thenValue = (!node.type.isVoid) ? lastExpr.value : null;
    currentBlock.addInst(new IRJumpInst(currentBlock, end));
    IRBlock thenBlock = currentBlock;

    currentBlock = currentBlock.parent.addBlock(else_);
    node.elseExpr.accept(this);
    var elseValue = (!node.type.isVoid) ? lastExpr.value : null;
    currentBlock.addInst(new IRJumpInst(currentBlock, end));
    IRBlock elseBlock = currentBlock;

    currentBlock = currentBlock.parent.addBlock(end);
    if (!node.type.isVoid) {
      var ret = new LocalVar(transType(node.type), String.valueOf(currentBlock.parent.varCnt++));
      var inst = new IRPhiInst(currentBlock, ret, transType(node.type));
      inst.addBranch(thenValue, thenBlock);
      inst.addBranch(elseValue, elseBlock);
      currentBlock.phiInsts.put(ret.getName(), inst);
      lastExpr = new ExprVar(ret, null, null);
    } else {
      lastExpr = null;
    }
  }
}
