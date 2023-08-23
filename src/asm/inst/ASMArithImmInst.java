package asm.inst;

import asm.operand.Immediate;
import asm.operand.Register;
import asm.section.ASMBlock;

public class ASMArithImmInst extends ASMInst {
  Register rd = null, rs1 = null;
  Immediate imm = null;
  String op = null;

  public ASMArithImmInst(ASMBlock parent, String op, Register rd, Register rs1, Immediate imm) {
    super(parent);
    this.op = op;
    this.rd = rd;
    this.rs1 = rs1;
    this.imm = imm;
  }

  @Override
  public String toString() {
    String tmp = switch (op) {
      case "+" -> "addi";
      case "^" -> "xori";
      case "|" -> "ori";
      case "&" -> "andi";
      case "<<" -> "slli";
      case ">>" -> "srai";
      default -> throw new RuntimeException("ArithImm: invalid op");
    };
    return String.format("%-8s", tmp) + rd + ", " + rs1 + ", " + imm;
  }

}
