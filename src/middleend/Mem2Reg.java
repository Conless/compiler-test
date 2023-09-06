package middleend;

import ir.*;
import ir.inst.*;
import ir.module.IRFuncDef;
import ir.util.IRType;
import ir.util.entity.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Stack;

public class Mem2Reg {
  IRProgram program;
  HashMap<String, IRType> allocaVars = null;
  HashMap<String, HashSet<IRBlock>> defBlocks = null;
  HashMap<String, Stack<Integer>> numStack = null;
  HashMap<String, Stack<IREntity>> valueStack = null;

  public Mem2Reg(IRProgram program) {
    this.program = program;
  }
  public void work() {
    new DomTreeBuilder(program).work();
    program.functions.forEach((key, func) -> workOnFunc(func));
  }
  public void workOnFunc(IRFuncDef func) {
    allocaVars = new HashMap<>();
    defBlocks = new HashMap<>();
    numStack = new HashMap<>();
    valueStack = new HashMap<>();

    func.body.forEach(this::collectNamesDefs);
    allocaVars.forEach(this::InsertPhi);
    rename(func.body.get(0));
  }

  private void rename(IRBlock block) {
    var valueSave = valueStack;
    var numSave = numStack;

    block.phiInsts.forEach((key, value) -> {
      if (allocaVars.containsKey(key)) {
        int num = 0;
        if (!numStack.get(key).isEmpty()) num = numStack.get(key).peek() + 1;
        var result = new LocalVar(allocaVars.get(key), key + "." + num);
        value.result = result;
        valueStack.get(key).push(result);
        numStack.get(key).push(num);
      }
    });

    ArrayList<IRInst> removeInsts = new ArrayList<>();
    for (int i = 0; i < block.instructions.size(); ++i) {
      var inst = block.instructions.get(i);
      if (inst instanceof IRAllocaInst) {
        removeInsts.add(inst);
      } else if (inst instanceof IRStoreInst) {
        var pos = ((IRStoreInst) inst).dest;
        if (pos instanceof LocalVar && allocaVars.containsKey(((LocalVar) pos).getName())) {
          valueStack.get(((LocalVar) pos).getName()).push(((IRStoreInst) inst).src);
          removeInsts.add(inst);
        }
      } else if (inst instanceof IRLoadInst) {
        var pos = ((IRLoadInst) inst).ptr;
        if (pos instanceof LocalVar && allocaVars.containsKey(((LocalVar) pos).getName())) {
          var stack = valueStack.get(((LocalVar) pos).getName());
          if (stack.isEmpty()) { // ! 没有store过就load：只可能是无用的load
            removeInsts.add(inst);
          } else if (stack.peek() instanceof LocalVar) {
            ((IRLoadInst) inst).result.name = ((LocalVar) stack.peek()).name;
            ((IRLoadInst) inst).result.type = ((LocalVar) stack.peek()).type;
            removeInsts.add(inst);
          } else if (stack.peek() instanceof IRLiteral) {
            IRLiteral tmp0 = new IRLiteral("0", ((IRLoadInst) inst).result.type);
            if (((IRLoadInst) inst).result.type.isPtr) tmp0 = new IRLiteral("null", ((IRLoadInst) inst).result.type);
            block.instructions.set(i, new IRBinaryInst(block, ((IRLoadInst) inst).result, "+", stack.peek(), tmp0));
          } else {
            throw new RuntimeException("Mem2Reg: rename: valueStack.peek() is not LocalVar or IRLiteral");
          }
        }
      }
    }
    for (var inst : removeInsts) {
      block.instructions.remove(inst);
    }

    for (var succ : block.succs) {
      succ.phiInsts.forEach((key, value) -> {
        if (allocaVars.containsKey(key)) {
          // ! valueStack.isEmpty: 可能出现如在for循环体内的局部变量，在循环体内store，但在for.cond中会出现phi指令，此时按0处理
          if (valueStack.get(key).isEmpty()) {
            var tmp = new IRLiteral("0", allocaVars.get(key));
            if (allocaVars.get(key).isPtr) tmp = new IRLiteral("null", allocaVars.get(key));
            value.changeBranch(tmp, block);
          } else {
            value.changeBranch(valueStack.get(key).peek(), block);
          }
        }
      });
    }

    for (var child : block.domChildren) {
      rename(child);
    }

    valueStack = valueSave;
    numStack = numSave;
  }

  private void InsertPhi(String name, IRType type) {
    ArrayList<IRBlock> workList = new ArrayList<>(defBlocks.get(name));
    for (int i = 0; i < workList.size(); ++i) {
      var block = workList.get(i);
      for (var df : block.domFrontier) {
        if (!df.phiInsts.containsKey(name)) {
          var phi = new IRPhiInst(df, new LocalVar(type, name), type);
          for (var pred : df.preds) {
            phi.addBranch(new LocalVar(type, name), pred);
          }
          df.phiInsts.put(name, phi);
          if (!workList.contains(df)) workList.add(df);
        }
      }
    }
  }

  private void collectNamesDefs(IRBlock block) {
    for (var inst : block.instructions) {
      if (inst instanceof IRAllocaInst) {
        String name = ((IRAllocaInst) inst).result.getName();
        allocaVars.put(name, ((IRAllocaInst) inst).type);
        defBlocks.put(name, new HashSet<>());
        numStack.put(name, new Stack<>());
        valueStack.put(name, new Stack<>());
      } else if (inst instanceof IRStoreInst) {
        IRVariable pos = ((IRStoreInst) inst).dest;
        if (pos instanceof LocalVar && allocaVars.containsKey(((LocalVar) pos).getName())) {
          defBlocks.get(((LocalVar) pos).getName()).add(block);
        }
      }
    }
  }
}
