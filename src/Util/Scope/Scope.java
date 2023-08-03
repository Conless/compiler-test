package Util.Scope;

import java.util.HashMap;

import Util.Position;
import Util.SemanticError;
import Util.Decl.FuncDecl;
import Util.Type.*;

public class Scope {
  public Scope parentScope = null;
  HashMap<String, VarType> varDefs = null;

  public Scope(Scope parent) {
    this.parentScope = parent;
    this.varDefs = new HashMap<>();
  }

  public void addVarSafe(VarType type, String name, Position pos) {
    if (varDefs.containsKey(name))
      throw new SemanticError("variable " + name + " redefined", pos);
    varDefs.put(name, type);
  }

  public boolean existVarName(String name) {
    if (varDefs.containsKey(name))
      return true;
    return false;
  }

  // public Type getVar(String name, Position pos) {
  //   if (varDefs.containsKey(name))
  //     return varDefs.get(name);
  //   if (parentScope != null)
  //     return parentScope.getVar(name, pos);
  //   throw new SemanticError("variable " + name + " not defined", pos);
  // }

  public void returnsType(ReturnType type, Position pos) {
    parentScope.returnsType(type, pos);
  }

  public boolean isInLoop() {
    return parentScope.isInLoop();
  }

  public String isInClass() {
    return parentScope.isInClass();
  }

  public VarType getVarType(String name) {
    if (varDefs.containsKey(name))
      return varDefs.get(name);
    if (parentScope != null)
      return parentScope.getVarType(name);
    return null;
  }

  public FuncDecl getFuncDecl(String name) {
    return parentScope.getFuncDecl(name);
  }
  
}
