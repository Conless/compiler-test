      .section text
      .globl qpow
qpow:
      addi    sp, sp, -48
      sw      s11, 44(sp)
      sw      s10, 40(sp)
      sw      s9, 36(sp)
      sw      s8, 32(sp)
      sw      s7, 28(sp)
      sw      s6, 24(sp)
      sw      s5, 20(sp)
      sw      s4, 16(sp)
      sw      s3, 12(sp)
      sw      s2, 8(sp)
      sw      s1, 4(sp)
      sw      s0, 0(sp)
      mv      s2, a0
      mv      s3, a1
      mv      s4, a2
qpow_entry:
      # br label %while.cond.0
      li      a0, 1
      j       qpow_while.cond.0
qpow_while.cond.0:
      # %_2 = icmp sgt i32 %_p.1.0, 0
      li      t0, 0
      sub     t0, s3, t0
      sgtz    t0, t0
      # br i1 %_2, label %while.body.0, label %while.end.0
      beqz     t0, qpow_while.end.0
qpow_while.body.0:
      # %_4 = and i32 %_p.1.0, 1
      li      t0, 1
      and     t0, s3, t0
      # %_5 = icmp eq i32 %_4, 1
      li      t1, 1
      sub     t0, t0, t1
      seqz    t0, t0
      # br i1 %_5, label %if.then.0, label %blank.0
      beqz     t0, qpow_blank.0
qpow_if.then.0:
      # %_9 = mul i32 %_t.1.0, %_y.1.0
      mul     t0, a0, s2
      # %_11 = srem i32 %_9, %_mod
      rem     a0, t0, s4
      # br label %if.end.0
      j       qpow_if.end.0
qpow_blank.0:
      # br label %if.end.0
      j       qpow_if.end.0
qpow_if.end.0:
      # %_15 = mul i32 %_y.1.0, %_y.1.0
      mul     t0, s2, s2
      # %_17 = srem i32 %_15, %_mod
      rem     s2, t0, s4
      # %_20 = sdiv i32 %_p.1.0, 2
      li      t0, 2
      div     s3, s3, t0
      # br label %while.cond.0
      j       qpow_while.cond.0
qpow_while.end.0:
      # ret i32 %_t.1.0
      lw      s11, 44(sp)
      lw      s10, 40(sp)
      lw      s9, 36(sp)
      lw      s8, 32(sp)
      lw      s7, 28(sp)
      lw      s6, 24(sp)
      lw      s5, 20(sp)
      lw      s4, 16(sp)
      lw      s3, 12(sp)
      lw      s2, 8(sp)
      lw      s1, 4(sp)
      lw      s0, 0(sp)
      addi    sp, sp, 48
      ret     
      .section text
      .globl main
main:
      addi    sp, sp, -240
      sw      s11, 236(sp)
      sw      s10, 232(sp)
      sw      s9, 228(sp)
      sw      s8, 224(sp)
      sw      s7, 220(sp)
      sw      s6, 216(sp)
      sw      s5, 212(sp)
      sw      s4, 208(sp)
      sw      s3, 204(sp)
      sw      s2, 200(sp)
      sw      s1, 196(sp)
      sw      s0, 192(sp)
main_entry:
      # %_1 = call i32 @qpow(i32 2, i32 10, i32 10000)
      sw      ra, 0(sp)
      sw      t0, 4(sp)
      sw      t1, 8(sp)
      sw      t2, 12(sp)
      sw      t3, 16(sp)
      sw      t4, 20(sp)
      sw      t5, 24(sp)
      sw      t6, 28(sp)
      sw      a0, 32(sp)
      sw      a1, 36(sp)
      sw      a2, 40(sp)
      sw      a3, 44(sp)
      sw      a4, 48(sp)
      sw      a5, 52(sp)
      sw      a6, 56(sp)
      sw      a7, 60(sp)
      li      a0, 2
      li      a1, 10
      li      a2, 10000
      call    qpow
      mv      s0, a0
      lw      ra, 0(sp)
      lw      t0, 4(sp)
      lw      t1, 8(sp)
      lw      t2, 12(sp)
      lw      t3, 16(sp)
      lw      t4, 20(sp)
      lw      t5, 24(sp)
      lw      t6, 28(sp)
      lw      a0, 32(sp)
      lw      a1, 36(sp)
      lw      a2, 40(sp)
      lw      a3, 44(sp)
      lw      a4, 48(sp)
      lw      a5, 52(sp)
      lw      a6, 56(sp)
      lw      a7, 60(sp)
      # %_0 = call ptr @toString(i32 %_1)
      sw      ra, 64(sp)
      sw      t0, 68(sp)
      sw      t1, 72(sp)
      sw      t2, 76(sp)
      sw      t3, 80(sp)
      sw      t4, 84(sp)
      sw      t5, 88(sp)
      sw      t6, 92(sp)
      sw      a0, 96(sp)
      sw      a1, 100(sp)
      sw      a2, 104(sp)
      sw      a3, 108(sp)
      sw      a4, 112(sp)
      sw      a5, 116(sp)
      sw      a6, 120(sp)
      sw      a7, 124(sp)
      mv      a0, s0
      call    toString
      mv      s0, a0
      lw      ra, 64(sp)
      lw      t0, 68(sp)
      lw      t1, 72(sp)
      lw      t2, 76(sp)
      lw      t3, 80(sp)
      lw      t4, 84(sp)
      lw      t5, 88(sp)
      lw      t6, 92(sp)
      lw      a0, 96(sp)
      lw      a1, 100(sp)
      lw      a2, 104(sp)
      lw      a3, 108(sp)
      lw      a4, 112(sp)
      lw      a5, 116(sp)
      lw      a6, 120(sp)
      lw      a7, 124(sp)
      # call void @println(ptr %_0)
      sw      ra, 128(sp)
      sw      t0, 132(sp)
      sw      t1, 136(sp)
      sw      t2, 140(sp)
      sw      t3, 144(sp)
      sw      t4, 148(sp)
      sw      t5, 152(sp)
      sw      t6, 156(sp)
      sw      a0, 160(sp)
      sw      a1, 164(sp)
      sw      a2, 168(sp)
      sw      a3, 172(sp)
      sw      a4, 176(sp)
      sw      a5, 180(sp)
      sw      a6, 184(sp)
      sw      a7, 188(sp)
      mv      a0, s0
      call    println
      lw      ra, 128(sp)
      lw      t0, 132(sp)
      lw      t1, 136(sp)
      lw      t2, 140(sp)
      lw      t3, 144(sp)
      lw      t4, 148(sp)
      lw      t5, 152(sp)
      lw      t6, 156(sp)
      lw      a0, 160(sp)
      lw      a1, 164(sp)
      lw      a2, 168(sp)
      lw      a3, 172(sp)
      lw      a4, 176(sp)
      lw      a5, 180(sp)
      lw      a6, 184(sp)
      lw      a7, 188(sp)
      # ret i32 0
      li      a0, 0
      lw      s11, 236(sp)
      lw      s10, 232(sp)
      lw      s9, 228(sp)
      lw      s8, 224(sp)
      lw      s7, 220(sp)
      lw      s6, 216(sp)
      lw      s5, 212(sp)
      lw      s4, 208(sp)
      lw      s3, 204(sp)
      lw      s2, 200(sp)
      lw      s1, 196(sp)
      lw      s0, 192(sp)
      addi    sp, sp, 240
      ret     
