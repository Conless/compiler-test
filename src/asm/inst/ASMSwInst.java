package asm.inst;

import asm.operand.MemAddr;
import asm.operand.Register;
import asm.operand.VirtualRegister;
import asm.section.ASMBlock;

import java.util.HashSet;

public class ASMSwInst extends ASMInst {
  Register rs = null;
  MemAddr addr = null;

  public ASMSwInst(ASMBlock parent, Register rs, MemAddr addr) {
    super(parent);
    this.rs = rs;
    this.addr = addr;
  }

  @Override
  public String toString() {
    return String.format("%-8s", "sw") + rs + ", " + addr;
  }
  @Override
  public void initUseDef(HashSet<VirtualRegister> use, HashSet<VirtualRegister> def) {
    if (rs instanceof VirtualRegister && !def.contains(rs))
      use.add((VirtualRegister) rs);
  }
}
