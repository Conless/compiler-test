      .section text
      .globl findLargest
findLargest:
      addi    sp, sp, -112
      sw      s11, 108(sp)
      sw      s10, 104(sp)
      sw      s9, 100(sp)
      sw      s8, 96(sp)
      sw      s7, 92(sp)
      sw      s6, 88(sp)
      sw      s5, 84(sp)
      sw      s4, 80(sp)
      sw      s3, 76(sp)
      sw      s2, 72(sp)
      sw      s1, 68(sp)
      sw      s0, 64(sp)
      mv      s2, a0
findLargest_entry:
      # %_1 = getelementptr %class.Node, ptr %_cur, i32 0, i32 1
      li      s1, 1
      li      s0, 4
      mul     s0, s1, s0
      add     s0, s2, s0
      # %_2 = load ptr, ptr %_1
      lw      s3, 0(s0)
      # %_3 = getelementptr ptr, ptr %_2, i32 1
      li      s0, 1
      li      s1, 4
      mul     s0, s0, s1
      add     s0, s3, s0
      # %_4 = load ptr, ptr %_3
      lw      s0, 0(s0)
      # %_5 = icmp eq ptr %_4, null
      li      s1, 0
      sub     s0, s0, s1
      seqz    s0, s0
      # br i1 %_5, label %if.then.0, label %if.end.0
      beqz     s0, findLargest_if.end.0
findLargest_if.then.0:
      # ret ptr %_cur
      mv      a0, s2
      lw      s11, 108(sp)
      lw      s10, 104(sp)
      lw      s9, 100(sp)
      lw      s8, 96(sp)
      lw      s7, 92(sp)
      lw      s6, 88(sp)
      lw      s5, 84(sp)
      lw      s4, 80(sp)
      lw      s3, 76(sp)
      lw      s2, 72(sp)
      lw      s1, 68(sp)
      lw      s0, 64(sp)
      addi    sp, sp, 112
      ret     
findLargest_if.end.0:
      # %_9 = getelementptr %class.Node, ptr %_cur, i32 0, i32 1
      li      s1, 1
      li      s0, 4
      mul     s0, s1, s0
      add     s0, s2, s0
      # %_10 = load ptr, ptr %_9
      lw      s1, 0(s0)
      # %_11 = getelementptr ptr, ptr %_10, i32 1
      li      s2, 1
      li      s0, 4
      mul     s0, s2, s0
      add     s0, s1, s0
      # %_12 = load ptr, ptr %_11
      lw      s0, 0(s0)
      # %_7 = call ptr @findLargest(ptr %_12)
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
      mv      a0, s0
      call    findLargest
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
      # ret ptr %_7
      mv      a0, s0
      lw      s11, 108(sp)
      lw      s10, 104(sp)
      lw      s9, 100(sp)
      lw      s8, 96(sp)
      lw      s7, 92(sp)
      lw      s6, 88(sp)
      lw      s5, 84(sp)
      lw      s4, 80(sp)
      lw      s3, 76(sp)
      lw      s2, 72(sp)
      lw      s1, 68(sp)
      lw      s0, 64(sp)
      addi    sp, sp, 112
      ret     
      .section text
      .globl erase
erase:
      addi    sp, sp, -112
      sw      s11, 108(sp)
      sw      s10, 104(sp)
      sw      s9, 100(sp)
      sw      s8, 96(sp)
      sw      s7, 92(sp)
      sw      s6, 88(sp)
      sw      s5, 84(sp)
      sw      s4, 80(sp)
      sw      s3, 76(sp)
      sw      s2, 72(sp)
      sw      s1, 68(sp)
      sw      s0, 64(sp)
      mv      s2, a0
erase_entry:
      # %_0 = load ptr, ptr @root
      la      s0, root
      lw      s0, 0(s0)
      # %_1 = icmp eq ptr %_0, null
      li      s1, 0
      sub     s0, s0, s1
      seqz    s0, s0
      # br i1 %_1, label %if.then.0, label %if.end.0
      beqz     s0, erase_if.end.0
erase_if.then.0:
      # ret i32 0
      li      a0, 0
      lw      s11, 108(sp)
      lw      s10, 104(sp)
      lw      s9, 100(sp)
      lw      s8, 96(sp)
      lw      s7, 92(sp)
      lw      s6, 88(sp)
      lw      s5, 84(sp)
      lw      s4, 80(sp)
      lw      s3, 76(sp)
      lw      s2, 72(sp)
      lw      s1, 68(sp)
      lw      s0, 64(sp)
      addi    sp, sp, 112
      ret     
erase_if.end.0:
      # %_3 = load ptr, ptr @root
      la      s0, root
      lw      s1, 0(s0)
      # %_4 = sub i32 0, 1
      li      s0, 0
      li      s3, 1
      sub     s0, s0, s3
      # %_2 = call i32 @eraseImpl(ptr %_3, ptr null, i32 %_4, i32 %_key)
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
      mv      a0, s1
      li      a1, 0
      mv      a2, s0
      mv      a3, s2
      call    eraseImpl
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
      # ret i32 %_2
      mv      a0, s0
      lw      s11, 108(sp)
      lw      s10, 104(sp)
      lw      s9, 100(sp)
      lw      s8, 96(sp)
      lw      s7, 92(sp)
      lw      s6, 88(sp)
      lw      s5, 84(sp)
      lw      s4, 80(sp)
      lw      s3, 76(sp)
      lw      s2, 72(sp)
      lw      s1, 68(sp)
      lw      s0, 64(sp)
      addi    sp, sp, 112
      ret     
      .section text
      .globl constructNode
constructNode:
      addi    sp, sp, -176
      sw      s11, 172(sp)
      sw      s10, 168(sp)
      sw      s9, 164(sp)
      sw      s8, 160(sp)
      sw      s7, 156(sp)
      sw      s6, 152(sp)
      sw      s5, 148(sp)
      sw      s4, 144(sp)
      sw      s3, 140(sp)
      sw      s2, 136(sp)
      sw      s1, 132(sp)
      sw      s0, 128(sp)
      mv      s2, a0
      mv      s3, a1
      mv      s4, a2
      mv      s5, a3
constructNode_entry:
      # %_0 = call ptr @_malloc(i32 24)
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
      li      a0, 24
      call    _malloc
      mv      s1, a0
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
      # %_2 = getelementptr %class.Node, ptr %_0, i32 0, i32 1
      li      s6, 1
      li      s0, 4
      mul     s0, s6, s0
      add     s0, s1, s0
      # %_3 = load ptr, ptr %_2
      lw      s6, 0(s0)
      # %_4 = call ptr @_malloc_array(i32 4, i32 2)
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
      li      a0, 4
      li      a1, 2
      call    _malloc_array
      mv      s6, a0
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
      # store ptr %_4, ptr %_2
      sw      s6, 0(s0)
      # %_6 = getelementptr %class.Node, ptr %_0, i32 0, i32 2
      li      t0, 2
      li      t1, 4
      mul     t0, t0, t1
      add     t0, s1, t0
      # %_7 = load i32, ptr %_6
      lw      t1, 0(t0)
      # store i32 %_key, ptr %_6
      sw      s2, 0(t0)
      # %_10 = getelementptr %class.Node, ptr %_0, i32 0, i32 3
      li      t0, 3
      li      t1, 4
      mul     t0, t0, t1
      add     t0, s1, t0
      # %_11 = load i32, ptr %_10
      lw      t1, 0(t0)
      # store i32 1, ptr %_10
      li      t1, 1
      sw      t1, 0(t0)
      # %_13 = getelementptr %class.Node, ptr %_0, i32 0, i32 0
      li      t1, 0
      li      t0, 4
      mul     t0, t1, t0
      add     t0, s1, t0
      # %_14 = load ptr, ptr %_13
      lw      t1, 0(t0)
      # store ptr %_pnt, ptr %_13
      sw      s3, 0(t0)
      # %_17 = getelementptr %class.Node, ptr %_0, i32 0, i32 1
      li      t0, 1
      li      t1, 4
      mul     t0, t0, t1
      add     t0, s1, t0
      # %_18 = load ptr, ptr %_17
      lw      t2, 0(t0)
      # %_19 = getelementptr ptr, ptr %_18, i32 0
      li      t1, 0
      li      t0, 4
      mul     t0, t1, t0
      add     t0, t2, t0
      # %_20 = load ptr, ptr %_19
      lw      t1, 0(t0)
      # store ptr %_lchild, ptr %_19
      sw      s4, 0(t0)
      # %_23 = getelementptr %class.Node, ptr %_0, i32 0, i32 1
      li      t0, 1
      li      t1, 4
      mul     t0, t0, t1
      add     t0, s1, t0
      # %_24 = load ptr, ptr %_23
      lw      t0, 0(t0)
      # %_25 = getelementptr ptr, ptr %_24, i32 1
      li      t2, 1
      li      t1, 4
      mul     t1, t2, t1
      add     t0, t0, t1
      # %_26 = load ptr, ptr %_25
      lw      t1, 0(t0)
      # store ptr %_rchild, ptr %_25
      sw      s5, 0(t0)
      # ret ptr %_0
      mv      a0, s1
      lw      s11, 172(sp)
      lw      s10, 168(sp)
      lw      s9, 164(sp)
      lw      s8, 160(sp)
      lw      s7, 156(sp)
      lw      s6, 152(sp)
      lw      s5, 148(sp)
      lw      s4, 144(sp)
      lw      s3, 140(sp)
      lw      s2, 136(sp)
      lw      s1, 132(sp)
      lw      s0, 128(sp)
      addi    sp, sp, 176
      ret     
      .section text
      .globl randOp
randOp:
      addi    sp, sp, -112
      sw      s11, 108(sp)
      sw      s10, 104(sp)
      sw      s9, 100(sp)
      sw      s8, 96(sp)
      sw      s7, 92(sp)
      sw      s6, 88(sp)
      sw      s5, 84(sp)
      sw      s4, 80(sp)
      sw      s3, 76(sp)
      sw      s2, 72(sp)
      sw      s1, 68(sp)
      sw      s0, 64(sp)
      mv      s2, a0
randOp_entry:
      # %_0 = call i32 @randInt31()
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
      call    randInt31
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
      # %_2 = icmp slt i32 %_0, %_n
      sub     t0, s0, s2
      sltz    t0, t0
      # br i1 %_2, label %if.then.0, label %if.end.0
      beqz     t0, randOp_if.end.0
randOp_if.then.0:
      # ret i32 1
      li      a0, 1
      lw      s11, 108(sp)
      lw      s10, 104(sp)
      lw      s9, 100(sp)
      lw      s8, 96(sp)
      lw      s7, 92(sp)
      lw      s6, 88(sp)
      lw      s5, 84(sp)
      lw      s4, 80(sp)
      lw      s3, 76(sp)
      lw      s2, 72(sp)
      lw      s1, 68(sp)
      lw      s0, 64(sp)
      addi    sp, sp, 112
      ret     
randOp_if.end.0:
      # ret i32 2
      li      a0, 2
      lw      s11, 108(sp)
      lw      s10, 104(sp)
      lw      s9, 100(sp)
      lw      s8, 96(sp)
      lw      s7, 92(sp)
      lw      s6, 88(sp)
      lw      s5, 84(sp)
      lw      s4, 80(sp)
      lw      s3, 76(sp)
      lw      s2, 72(sp)
      lw      s1, 68(sp)
      lw      s0, 64(sp)
      addi    sp, sp, 112
      ret     
      .section text
      .globl eraseImpl
eraseImpl:
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
      mv      s2, a0
      mv      s3, a1
      mv      s4, a2
      mv      s5, a3
eraseImpl_entry:
      # %_1 = icmp eq ptr %_cur, null
      li      s0, 0
      sub     s0, s2, s0
      seqz    s0, s0
      # br i1 %_1, label %if.then.0, label %if.end.0
      beqz     s0, eraseImpl_if.end.0
eraseImpl_if.then.0:
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
eraseImpl_if.end.0:
      # %_3 = getelementptr %class.Node, ptr %_cur, i32 0, i32 2
      li      s1, 2
      li      s0, 4
      mul     s0, s1, s0
      add     s0, s2, s0
      # %_4 = load i32, ptr %_3
      lw      s0, 0(s0)
      # %_6 = icmp sgt i32 %_4, %_key
      sub     s0, s0, s5
      sgtz    s0, s0
      # br i1 %_6, label %if.then.1, label %if.end.1
      beqz     s0, eraseImpl_if.end.1
eraseImpl_if.then.1:
      # %_9 = getelementptr %class.Node, ptr %_cur, i32 0, i32 1
      li      s1, 1
      li      s0, 4
      mul     s0, s1, s0
      add     s0, s2, s0
      # %_10 = load ptr, ptr %_9
      lw      s1, 0(s0)
      # %_11 = getelementptr ptr, ptr %_10, i32 0
      li      s3, 0
      li      s0, 4
      mul     s0, s3, s0
      add     s0, s1, s0
      # %_12 = load ptr, ptr %_11
      lw      s0, 0(s0)
      # %_7 = call i32 @eraseImpl(ptr %_12, ptr %_cur, i32 0, i32 %_key)
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
      mv      a0, s0
      mv      a1, s2
      li      a2, 0
      mv      a3, s5
      call    eraseImpl
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
      # ret i32 %_7
      mv      a0, s0
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
eraseImpl_if.end.1:
      # %_16 = getelementptr %class.Node, ptr %_cur, i32 0, i32 2
      li      s0, 2
      li      s1, 4
      mul     s0, s0, s1
      add     s0, s2, s0
      # %_17 = load i32, ptr %_16
      lw      s0, 0(s0)
      # %_19 = icmp slt i32 %_17, %_key
      sub     s0, s0, s5
      sltz    s0, s0
      # br i1 %_19, label %if.then.2, label %if.end.2
      beqz     s0, eraseImpl_if.end.2
eraseImpl_if.then.2:
      # %_22 = getelementptr %class.Node, ptr %_cur, i32 0, i32 1
      li      s0, 1
      li      s1, 4
      mul     s0, s0, s1
      add     s0, s2, s0
      # %_23 = load ptr, ptr %_22
      lw      s0, 0(s0)
      # %_24 = getelementptr ptr, ptr %_23, i32 1
      li      s1, 1
      li      s3, 4
      mul     s1, s1, s3
      add     s0, s0, s1
      # %_25 = load ptr, ptr %_24
      lw      s0, 0(s0)
      # %_20 = call i32 @eraseImpl(ptr %_25, ptr %_cur, i32 1, i32 %_key)
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
      mv      a1, s2
      li      a2, 1
      mv      a3, s5
      call    eraseImpl
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
      # ret i32 %_20
      mv      a0, s0
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
eraseImpl_if.end.2:
      # %_29 = getelementptr %class.Node, ptr %_cur, i32 0, i32 3
      li      s0, 3
      li      s1, 4
      mul     s0, s0, s1
      add     s0, s2, s0
      # %_30 = load i32, ptr %_29
      lw      s6, 0(s0)
      # %_31 = sub i32 %_30, 1
      li      s1, 1
      sub     s1, s6, s1
      # store i32 %_31, ptr %_29
      sw      s1, 0(s0)
      # %_33 = getelementptr %class.Node, ptr %_cur, i32 0, i32 3
      li      s0, 3
      li      s1, 4
      mul     s0, s0, s1
      add     s0, s2, s0
      # %_34 = load i32, ptr %_33
      lw      s0, 0(s0)
      # %_35 = icmp sgt i32 %_34, 0
      li      s1, 0
      sub     s0, s0, s1
      sgtz    s0, s0
      # br i1 %_35, label %if.then.3, label %if.end.3
      beqz     s0, eraseImpl_if.end.3
eraseImpl_if.then.3:
      # ret i32 1
      li      a0, 1
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
eraseImpl_if.end.3:
      # %_37 = getelementptr %class.Node, ptr %_cur, i32 0, i32 1
      li      s0, 1
      li      s1, 4
      mul     s0, s0, s1
      add     s0, s2, s0
      # %_38 = load ptr, ptr %_37
      lw      s6, 0(s0)
      # %_39 = getelementptr ptr, ptr %_38, i32 0
      li      s0, 0
      li      s1, 4
      mul     s0, s0, s1
      add     s0, s6, s0
      # %_40 = load ptr, ptr %_39
      lw      s0, 0(s0)
      # %_41 = icmp eq ptr %_40, null
      li      s1, 0
      sub     s0, s0, s1
      seqz    s0, s0
      # br i1 %_41, label %if.then.4, label %if.end.4
      beqz     s0, eraseImpl_if.end.4
eraseImpl_if.then.4:
      # %_43 = icmp ne ptr %_pnt, null
      li      t0, 0
      sub     t0, s3, t0
      snez    t0, t0
      # br i1 %_43, label %if.then.5, label %if.end.5
      beqz     t0, eraseImpl_if.end.5
eraseImpl_if.then.5:
      # %_45 = getelementptr %class.Node, ptr %_pnt, i32 0, i32 1
      li      t1, 1
      li      t0, 4
      mul     t0, t1, t0
      add     t0, s3, t0
      # %_46 = load ptr, ptr %_45
      lw      t1, 0(t0)
      # %_48 = getelementptr ptr, ptr %_46, i32 %_childId
      li      t0, 4
      mul     t0, s4, t0
      add     t1, t1, t0
      # %_49 = load ptr, ptr %_48
      lw      t0, 0(t1)
      # %_51 = getelementptr %class.Node, ptr %_cur, i32 0, i32 1
      li      t2, 1
      li      t0, 4
      mul     t0, t2, t0
      add     t0, s2, t0
      # %_52 = load ptr, ptr %_51
      lw      t2, 0(t0)
      # %_53 = getelementptr ptr, ptr %_52, i32 1
      li      t0, 1
      li      s0, 4
      mul     t0, t0, s0
      add     t0, t2, t0
      # %_54 = load ptr, ptr %_53
      lw      t0, 0(t0)
      # store ptr %_54, ptr %_48
      sw      t0, 0(t1)
      # br label %if.end.5
      j       eraseImpl_if.end.5
eraseImpl_if.end.5:
      # %_56 = getelementptr %class.Node, ptr %_cur, i32 0, i32 1
      li      t1, 1
      li      t0, 4
      mul     t0, t1, t0
      add     t0, s2, t0
      # %_57 = load ptr, ptr %_56
      lw      t0, 0(t0)
      # %_58 = getelementptr ptr, ptr %_57, i32 1
      li      t2, 1
      li      t1, 4
      mul     t1, t2, t1
      add     t0, t0, t1
      # %_59 = load ptr, ptr %_58
      lw      t0, 0(t0)
      # %_60 = icmp ne ptr %_59, null
      li      t1, 0
      sub     t0, t0, t1
      snez    t0, t0
      # br i1 %_60, label %if.then.6, label %if.end.6
      beqz     t0, eraseImpl_if.end.6
eraseImpl_if.then.6:
      # %_62 = getelementptr %class.Node, ptr %_cur, i32 0, i32 1
      li      t1, 1
      li      t0, 4
      mul     t0, t1, t0
      add     t0, s2, t0
      # %_63 = load ptr, ptr %_62
      lw      t1, 0(t0)
      # %_64 = getelementptr ptr, ptr %_63, i32 1
      li      t0, 1
      li      t2, 4
      mul     t0, t0, t2
      add     t0, t1, t0
      # %_65 = load ptr, ptr %_64
      lw      t2, 0(t0)
      # %_66 = getelementptr %class.Node, ptr %_65, i32 0, i32 0
      li      t1, 0
      li      t0, 4
      mul     t0, t1, t0
      add     t0, t2, t0
      # %_67 = load ptr, ptr %_66
      lw      t1, 0(t0)
      # store ptr %_pnt, ptr %_66
      sw      s3, 0(t0)
      # br label %if.end.6
      j       eraseImpl_if.end.6
eraseImpl_if.end.6:
      # %_70 = load ptr, ptr @root
      la      t0, root
      lw      t2, 0(t0)
      # %_71 = getelementptr %class.Node, ptr %_70, i32 0, i32 2
      li      t1, 2
      li      t0, 4
      mul     t0, t1, t0
      add     t0, t2, t0
      # %_72 = load i32, ptr %_71
      lw      t0, 0(t0)
      # %_73 = icmp eq i32 %_key, %_72
      sub     t0, s5, t0
      seqz    t0, t0
      # br i1 %_73, label %if.then.7, label %if.end.7
      beqz     t0, eraseImpl_if.end.7
eraseImpl_if.then.7:
      # %_74 = load ptr, ptr @root
      la      t0, root
      lw      t0, 0(t0)
      # %_76 = getelementptr %class.Node, ptr %_cur, i32 0, i32 1
      li      t0, 1
      li      t1, 4
      mul     t0, t0, t1
      add     t0, s2, t0
      # %_77 = load ptr, ptr %_76
      lw      t0, 0(t0)
      # %_78 = getelementptr ptr, ptr %_77, i32 1
      li      t2, 1
      li      t1, 4
      mul     t1, t2, t1
      add     t0, t0, t1
      # %_79 = load ptr, ptr %_78
      lw      t1, 0(t0)
      # store ptr %_79, ptr @root
      la      t0, root
      sw      t1, 0(t0)
      # br label %if.end.7
      j       eraseImpl_if.end.7
eraseImpl_if.end.7:
      # ret i32 1
      li      a0, 1
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
eraseImpl_if.end.4:
      # %_82 = getelementptr %class.Node, ptr %_cur, i32 0, i32 1
      li      s1, 1
      li      s0, 4
      mul     s0, s1, s0
      add     s0, s2, s0
      # %_83 = load ptr, ptr %_82
      lw      s6, 0(s0)
      # %_84 = getelementptr ptr, ptr %_83, i32 0
      li      s1, 0
      li      s0, 4
      mul     s0, s1, s0
      add     s0, s6, s0
      # %_85 = load ptr, ptr %_84
      lw      s0, 0(s0)
      # %_80 = call ptr @findLargest(ptr %_85)
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
      call    findLargest
      mv      s0, a0
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
      # %_87 = load ptr, ptr @root
      la      t0, root
      lw      t2, 0(t0)
      # %_88 = getelementptr %class.Node, ptr %_87, i32 0, i32 2
      li      t0, 2
      li      t1, 4
      mul     t0, t0, t1
      add     t0, t2, t0
      # %_89 = load i32, ptr %_88
      lw      t0, 0(t0)
      # %_90 = icmp eq i32 %_key, %_89
      sub     t0, s5, t0
      seqz    t0, t0
      # br i1 %_90, label %if.then.8, label %if.end.8
      beqz     t0, eraseImpl_if.end.8
eraseImpl_if.then.8:
      # %_91 = load ptr, ptr @root
      la      t0, root
      lw      t0, 0(t0)
      # store ptr %_80, ptr @root
      la      t0, root
      sw      s0, 0(t0)
      # br label %if.end.8
      j       eraseImpl_if.end.8
eraseImpl_if.end.8:
      # %_94 = getelementptr %class.Node, ptr %_80, i32 0, i32 2
      li      t0, 2
      li      t1, 4
      mul     t0, t0, t1
      add     t0, s0, t0
      # %_95 = load i32, ptr %_94
      lw      t2, 0(t0)
      # %_97 = getelementptr %class.Node, ptr %_cur, i32 0, i32 1
      li      t0, 1
      li      t1, 4
      mul     t0, t0, t1
      add     t0, s2, t0
      # %_98 = load ptr, ptr %_97
      lw      t1, 0(t0)
      # %_99 = getelementptr ptr, ptr %_98, i32 0
      li      t0, 0
      li      s1, 4
      mul     t0, t0, s1
      add     t0, t1, t0
      # %_100 = load ptr, ptr %_99
      lw      t1, 0(t0)
      # %_101 = getelementptr %class.Node, ptr %_100, i32 0, i32 2
      li      s1, 2
      li      t0, 4
      mul     t0, s1, t0
      add     t0, t1, t0
      # %_102 = load i32, ptr %_101
      lw      t0, 0(t0)
      # %_103 = icmp ne i32 %_95, %_102
      sub     t0, t2, t0
      snez    t0, t0
      # br i1 %_103, label %if.then.9, label %if.end.9
      beqz     t0, eraseImpl_if.end.9
eraseImpl_if.then.9:
      # %_105 = getelementptr %class.Node, ptr %_80, i32 0, i32 0
      li      t0, 0
      li      t1, 4
      mul     t0, t0, t1
      add     t0, s0, t0
      # %_106 = load ptr, ptr %_105
      lw      t1, 0(t0)
      # %_107 = getelementptr %class.Node, ptr %_106, i32 0, i32 1
      li      t2, 1
      li      t0, 4
      mul     t0, t2, t0
      add     t0, t1, t0
      # %_108 = load ptr, ptr %_107
      lw      t2, 0(t0)
      # %_109 = getelementptr ptr, ptr %_108, i32 1
      li      t1, 1
      li      t0, 4
      mul     t0, t1, t0
      add     t1, t2, t0
      # %_110 = load ptr, ptr %_109
      lw      t0, 0(t1)
      # %_112 = getelementptr %class.Node, ptr %_80, i32 0, i32 1
      li      t2, 1
      li      t0, 4
      mul     t0, t2, t0
      add     t0, s0, t0
      # %_113 = load ptr, ptr %_112
      lw      t0, 0(t0)
      # %_114 = getelementptr ptr, ptr %_113, i32 0
      li      t2, 0
      li      s1, 4
      mul     t2, t2, s1
      add     t0, t0, t2
      # %_115 = load ptr, ptr %_114
      lw      t0, 0(t0)
      # store ptr %_115, ptr %_109
      sw      t0, 0(t1)
      # %_117 = getelementptr %class.Node, ptr %_80, i32 0, i32 1
      li      t0, 1
      li      t1, 4
      mul     t0, t0, t1
      add     t0, s0, t0
      # %_118 = load ptr, ptr %_117
      lw      t2, 0(t0)
      # %_119 = getelementptr ptr, ptr %_118, i32 0
      li      t1, 0
      li      t0, 4
      mul     t0, t1, t0
      add     t0, t2, t0
      # %_120 = load ptr, ptr %_119
      lw      t1, 0(t0)
      # %_121 = icmp ne ptr %_120, null
      li      t0, 0
      sub     t0, t1, t0
      snez    t0, t0
      # br i1 %_121, label %if.then.10, label %blank.0
      beqz     t0, eraseImpl_blank.0
eraseImpl_if.then.10:
      # %_123 = getelementptr %class.Node, ptr %_80, i32 0, i32 1
      li      t0, 1
      li      t1, 4
      mul     t0, t0, t1
      add     t0, s0, t0
      # %_124 = load ptr, ptr %_123
      lw      t1, 0(t0)
      # %_125 = getelementptr ptr, ptr %_124, i32 0
      li      t0, 0
      li      t2, 4
      mul     t0, t0, t2
      add     t0, t1, t0
      # %_126 = load ptr, ptr %_125
      lw      t1, 0(t0)
      # %_127 = getelementptr %class.Node, ptr %_126, i32 0, i32 0
      li      t0, 0
      li      t2, 4
      mul     t0, t0, t2
      add     t1, t1, t0
      # %_128 = load ptr, ptr %_127
      lw      t0, 0(t1)
      # %_130 = getelementptr %class.Node, ptr %_80, i32 0, i32 0
      li      t2, 0
      li      t0, 4
      mul     t0, t2, t0
      add     t0, s0, t0
      # %_131 = load ptr, ptr %_130
      lw      t0, 0(t0)
      # store ptr %_131, ptr %_127
      sw      t0, 0(t1)
      # br label %if.end.10
      j       eraseImpl_if.end.10
eraseImpl_blank.0:
      # br label %if.end.10
      j       eraseImpl_if.end.10
eraseImpl_if.end.10:
      # br label %if.end.9
      j       eraseImpl_if.end.9
eraseImpl_if.end.9:
      # %_133 = icmp ne ptr %_pnt, null
      li      t0, 0
      sub     t0, s3, t0
      snez    t0, t0
      # br i1 %_133, label %if.then.11, label %blank.1
      beqz     t0, eraseImpl_blank.1
eraseImpl_if.then.11:
      # %_135 = getelementptr %class.Node, ptr %_pnt, i32 0, i32 1
      li      t1, 1
      li      t0, 4
      mul     t0, t1, t0
      add     t0, s3, t0
      # %_136 = load ptr, ptr %_135
      lw      t0, 0(t0)
      # %_138 = getelementptr ptr, ptr %_136, i32 %_childId
      li      t1, 4
      mul     t1, s4, t1
      add     t0, t0, t1
      # %_139 = load ptr, ptr %_138
      lw      t1, 0(t0)
      # store ptr %_80, ptr %_138
      sw      s0, 0(t0)
      # br label %if.end.11
      j       eraseImpl_if.end.11
eraseImpl_blank.1:
      # br label %if.end.11
      j       eraseImpl_if.end.11
eraseImpl_if.end.11:
      # %_142 = getelementptr %class.Node, ptr %_80, i32 0, i32 0
      li      t0, 0
      li      t1, 4
      mul     t0, t0, t1
      add     t0, s0, t0
      # %_143 = load ptr, ptr %_142
      lw      t1, 0(t0)
      # store ptr %_pnt, ptr %_142
      sw      s3, 0(t0)
      # %_146 = getelementptr %class.Node, ptr %_80, i32 0, i32 1
      li      t1, 1
      li      t0, 4
      mul     t0, t1, t0
      add     t0, s0, t0
      # %_147 = load ptr, ptr %_146
      lw      t2, 0(t0)
      # %_148 = getelementptr ptr, ptr %_147, i32 1
      li      t0, 1
      li      t1, 4
      mul     t0, t0, t1
      add     t1, t2, t0
      # %_149 = load ptr, ptr %_148
      lw      t0, 0(t1)
      # %_151 = getelementptr %class.Node, ptr %_cur, i32 0, i32 1
      li      t2, 1
      li      t0, 4
      mul     t0, t2, t0
      add     t0, s2, t0
      # %_152 = load ptr, ptr %_151
      lw      t2, 0(t0)
      # %_153 = getelementptr ptr, ptr %_152, i32 1
      li      t0, 1
      li      s1, 4
      mul     t0, t0, s1
      add     t0, t2, t0
      # %_154 = load ptr, ptr %_153
      lw      t0, 0(t0)
      # store ptr %_154, ptr %_148
      sw      t0, 0(t1)
      # %_156 = getelementptr %class.Node, ptr %_cur, i32 0, i32 1
      li      t1, 1
      li      t0, 4
      mul     t0, t1, t0
      add     t0, s2, t0
      # %_157 = load ptr, ptr %_156
      lw      t2, 0(t0)
      # %_158 = getelementptr ptr, ptr %_157, i32 1
      li      t1, 1
      li      t0, 4
      mul     t0, t1, t0
      add     t0, t2, t0
      # %_159 = load ptr, ptr %_158
      lw      t1, 0(t0)
      # %_160 = icmp ne ptr %_159, null
      li      t0, 0
      sub     t0, t1, t0
      snez    t0, t0
      # br i1 %_160, label %if.then.12, label %blank.2
      beqz     t0, eraseImpl_blank.2
eraseImpl_if.then.12:
      # %_162 = getelementptr %class.Node, ptr %_cur, i32 0, i32 1
      li      t0, 1
      li      t1, 4
      mul     t0, t0, t1
      add     t0, s2, t0
      # %_163 = load ptr, ptr %_162
      lw      t2, 0(t0)
      # %_164 = getelementptr ptr, ptr %_163, i32 1
      li      t0, 1
      li      t1, 4
      mul     t0, t0, t1
      add     t0, t2, t0
      # %_165 = load ptr, ptr %_164
      lw      t2, 0(t0)
      # %_166 = getelementptr %class.Node, ptr %_165, i32 0, i32 0
      li      t0, 0
      li      t1, 4
      mul     t0, t0, t1
      add     t0, t2, t0
      # %_167 = load ptr, ptr %_166
      lw      t1, 0(t0)
      # store ptr %_80, ptr %_166
      sw      s0, 0(t0)
      # br label %if.end.12
      j       eraseImpl_if.end.12
eraseImpl_blank.2:
      # br label %if.end.12
      j       eraseImpl_if.end.12
eraseImpl_if.end.12:
      # %_170 = getelementptr %class.Node, ptr %_80, i32 0, i32 2
      li      t0, 2
      li      t1, 4
      mul     t0, t0, t1
      add     t0, s0, t0
      # %_171 = load i32, ptr %_170
      lw      s1, 0(t0)
      # %_173 = getelementptr %class.Node, ptr %_cur, i32 0, i32 1
      li      t1, 1
      li      t0, 4
      mul     t0, t1, t0
      add     t0, s2, t0
      # %_174 = load ptr, ptr %_173
      lw      t1, 0(t0)
      # %_175 = getelementptr ptr, ptr %_174, i32 0
      li      t0, 0
      li      t2, 4
      mul     t0, t0, t2
      add     t0, t1, t0
      # %_176 = load ptr, ptr %_175
      lw      t0, 0(t0)
      # %_177 = getelementptr %class.Node, ptr %_176, i32 0, i32 2
      li      t2, 2
      li      t1, 4
      mul     t1, t2, t1
      add     t0, t0, t1
      # %_178 = load i32, ptr %_177
      lw      t0, 0(t0)
      # %_179 = icmp ne i32 %_171, %_178
      sub     t0, s1, t0
      snez    t0, t0
      # br i1 %_179, label %if.then.13, label %blank.3
      beqz     t0, eraseImpl_blank.3
eraseImpl_if.then.13:
      # %_181 = getelementptr %class.Node, ptr %_80, i32 0, i32 1
      li      t1, 1
      li      t0, 4
      mul     t0, t1, t0
      add     t0, s0, t0
      # %_182 = load ptr, ptr %_181
      lw      t1, 0(t0)
      # %_183 = getelementptr ptr, ptr %_182, i32 0
      li      t2, 0
      li      t0, 4
      mul     t0, t2, t0
      add     t1, t1, t0
      # %_184 = load ptr, ptr %_183
      lw      t0, 0(t1)
      # %_186 = getelementptr %class.Node, ptr %_cur, i32 0, i32 1
      li      t2, 1
      li      t0, 4
      mul     t0, t2, t0
      add     t0, s2, t0
      # %_187 = load ptr, ptr %_186
      lw      s1, 0(t0)
      # %_188 = getelementptr ptr, ptr %_187, i32 0
      li      t0, 0
      li      t2, 4
      mul     t0, t0, t2
      add     t0, s1, t0
      # %_189 = load ptr, ptr %_188
      lw      t0, 0(t0)
      # store ptr %_189, ptr %_183
      sw      t0, 0(t1)
      # %_191 = getelementptr %class.Node, ptr %_cur, i32 0, i32 1
      li      t1, 1
      li      t0, 4
      mul     t0, t1, t0
      add     t0, s2, t0
      # %_192 = load ptr, ptr %_191
      lw      t0, 0(t0)
      # %_193 = getelementptr ptr, ptr %_192, i32 0
      li      t1, 0
      li      t2, 4
      mul     t1, t1, t2
      add     t0, t0, t1
      # %_194 = load ptr, ptr %_193
      lw      t2, 0(t0)
      # %_195 = getelementptr %class.Node, ptr %_194, i32 0, i32 0
      li      t1, 0
      li      t0, 4
      mul     t0, t1, t0
      add     t0, t2, t0
      # %_196 = load ptr, ptr %_195
      lw      t1, 0(t0)
      # store ptr %_80, ptr %_195
      sw      s0, 0(t0)
      # br label %if.end.13
      j       eraseImpl_if.end.13
eraseImpl_blank.3:
      # br label %if.end.13
      j       eraseImpl_if.end.13
eraseImpl_if.end.13:
      # ret i32 1
      li      a0, 1
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
      .section text
      .globl insertImpl
insertImpl:
      addi    sp, sp, -176
      sw      s11, 172(sp)
      sw      s10, 168(sp)
      sw      s9, 164(sp)
      sw      s8, 160(sp)
      sw      s7, 156(sp)
      sw      s6, 152(sp)
      sw      s5, 148(sp)
      sw      s4, 144(sp)
      sw      s3, 140(sp)
      sw      s2, 136(sp)
      sw      s1, 132(sp)
      sw      s0, 128(sp)
      mv      s2, a0
      mv      s3, a1
      mv      s4, a2
      mv      s5, a3
insertImpl_entry:
      # %_1 = icmp eq ptr %_cur, null
      li      s0, 0
      sub     s0, s2, s0
      seqz    s0, s0
      # br i1 %_1, label %if.then.0, label %if.end.0
      beqz     s0, insertImpl_if.end.0
insertImpl_if.then.0:
      # %_3 = call ptr @constructNode(i32 %_key, ptr %_pnt, ptr null, ptr null)
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
      mv      a0, s5
      mv      a1, s3
      li      a2, 0
      li      a3, 0
      call    constructNode
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
      # %_7 = getelementptr %class.Node, ptr %_pnt, i32 0, i32 1
      li      t0, 1
      li      t1, 4
      mul     t0, t0, t1
      add     t0, s3, t0
      # %_8 = load ptr, ptr %_7
      lw      t1, 0(t0)
      # %_10 = getelementptr ptr, ptr %_8, i32 %_childId
      li      t0, 4
      mul     t0, s4, t0
      add     t0, t1, t0
      # %_11 = load ptr, ptr %_10
      lw      t1, 0(t0)
      # store ptr %_3, ptr %_10
      sw      s0, 0(t0)
      # ret i32 0
      li      a0, 0
      lw      s11, 172(sp)
      lw      s10, 168(sp)
      lw      s9, 164(sp)
      lw      s8, 160(sp)
      lw      s7, 156(sp)
      lw      s6, 152(sp)
      lw      s5, 148(sp)
      lw      s4, 144(sp)
      lw      s3, 140(sp)
      lw      s2, 136(sp)
      lw      s1, 132(sp)
      lw      s0, 128(sp)
      addi    sp, sp, 176
      ret     
insertImpl_if.end.0:
      # %_14 = getelementptr %class.Node, ptr %_cur, i32 0, i32 2
      li      s1, 2
      li      s0, 4
      mul     s0, s1, s0
      add     s0, s2, s0
      # %_15 = load i32, ptr %_14
      lw      s0, 0(s0)
      # %_17 = icmp eq i32 %_15, %_key
      sub     s0, s0, s5
      seqz    s0, s0
      # br i1 %_17, label %if.then.1, label %if.end.1
      beqz     s0, insertImpl_if.end.1
insertImpl_if.then.1:
      # %_19 = getelementptr %class.Node, ptr %_cur, i32 0, i32 3
      li      t1, 3
      li      t0, 4
      mul     t0, t1, t0
      add     t0, s2, t0
      # %_20 = load i32, ptr %_19
      lw      t2, 0(t0)
      # %_21 = add i32 %_20, 1
      li      t1, 1
      add     t1, t2, t1
      # store i32 %_21, ptr %_19
      sw      t1, 0(t0)
      # ret i32 1
      li      a0, 1
      lw      s11, 172(sp)
      lw      s10, 168(sp)
      lw      s9, 164(sp)
      lw      s8, 160(sp)
      lw      s7, 156(sp)
      lw      s6, 152(sp)
      lw      s5, 148(sp)
      lw      s4, 144(sp)
      lw      s3, 140(sp)
      lw      s2, 136(sp)
      lw      s1, 132(sp)
      lw      s0, 128(sp)
      addi    sp, sp, 176
      ret     
insertImpl_if.end.1:
      # %_23 = getelementptr %class.Node, ptr %_cur, i32 0, i32 2
      li      s1, 2
      li      s0, 4
      mul     s0, s1, s0
      add     s0, s2, s0
      # %_24 = load i32, ptr %_23
      lw      s0, 0(s0)
      # %_26 = icmp slt i32 %_24, %_key
      sub     s0, s0, s5
      sltz    s0, s0
      # br i1 %_26, label %if.then.2, label %blank.0
      beqz     s0, insertImpl_blank.0
insertImpl_if.then.2:
      # %_27 = add i32 0, 0
      li      s1, 0
      li      s0, 0
      add     s0, s1, s0
      # br label %if.end.2
      li      s0, 1
      mv      s1, s0
      j       insertImpl_if.end.2
insertImpl_blank.0:
      # br label %if.end.2
      li      s0, 0
      mv      s1, s0
      j       insertImpl_if.end.2
insertImpl_if.end.2:
      # %_30 = getelementptr %class.Node, ptr %_cur, i32 0, i32 1
      li      s0, 1
      li      s3, 4
      mul     s0, s0, s3
      add     s0, s2, s0
      # %_31 = load ptr, ptr %_30
      lw      s3, 0(s0)
      # %_33 = getelementptr ptr, ptr %_31, i32 %_id.1.0
      li      s0, 4
      mul     s0, s1, s0
      add     s0, s3, s0
      # %_34 = load ptr, ptr %_33
      lw      s0, 0(s0)
      # %_28 = call i32 @insertImpl(ptr %_34, ptr %_cur, i32 %_id.1.0, i32 %_key)
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
      mv      a1, s2
      mv      a2, s1
      mv      a3, s5
      call    insertImpl
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
      # ret i32 %_28
      mv      a0, s0
      lw      s11, 172(sp)
      lw      s10, 168(sp)
      lw      s9, 164(sp)
      lw      s8, 160(sp)
      lw      s7, 156(sp)
      lw      s6, 152(sp)
      lw      s5, 148(sp)
      lw      s4, 144(sp)
      lw      s3, 140(sp)
      lw      s2, 136(sp)
      lw      s1, 132(sp)
      lw      s0, 128(sp)
      addi    sp, sp, 176
      ret     
      .section text
      .globl __init
__init:
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
__init_entry:
      # %_0 = xor i32 -2147483648, -1
      li      t0, -2147483648
      li      t1, -1
      xor     t0, t0, t1
      # store i32 %_0, ptr @MaxRandInt
      la      t1, MaxRandInt
      sw      t0, 0(t1)
      # ret void
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
      .globl generateOperations
generateOperations:
      addi    sp, sp, -304
      sw      s11, 300(sp)
      sw      s10, 296(sp)
      sw      s9, 292(sp)
      sw      s8, 288(sp)
      sw      s7, 284(sp)
      sw      s6, 280(sp)
      sw      s5, 276(sp)
      sw      s4, 272(sp)
      sw      s3, 268(sp)
      sw      s2, 264(sp)
      sw      s1, 260(sp)
      sw      s0, 256(sp)
      mv      s2, a0
      mv      s3, a1
generateOperations_entry:
      # br label %for.cond.0
      li      s0, 0
      mv      s4, s0
      li      s0, 0
      j       generateOperations_for.cond.0
generateOperations_for.cond.0:
      # %_3 = icmp slt i32 %_i.1.0, %_t
      sub     s0, s4, s3
      sltz    s0, s0
      # br i1 %_3, label %for.body.0, label %for.end.0
      beqz     s0, generateOperations_for.end.0
generateOperations_for.body.0:
      # %_4 = call i32 @randInt31()
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
      call    randInt31
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
      # %_5 = load i32, ptr @MAX
      la      s1, MAX
      lw      s1, 0(s1)
      # %_6 = srem i32 %_4, %_5
      rem     s1, s0, s1
      # %_7 = call i32 @randOp(i32 %_n)
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
      mv      a0, s2
      call    randOp
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
      # %_9 = icmp eq i32 %_7, 1
      li      s5, 1
      sub     s0, s0, s5
      seqz    s0, s0
      # br i1 %_9, label %if.then.0, label %if.else.0
      beqz     s0, generateOperations_if.else.0
generateOperations_if.then.0:
      # %_10 = call i32 @insert(i32 %_6)
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
      mv      a0, s1
      call    insert
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
      # br label %if.end.0
      j       generateOperations_if.end.0
generateOperations_if.else.0:
      # %_12 = call i32 @erase(i32 %_6)
      sw      ra, 192(sp)
      sw      t0, 196(sp)
      sw      t1, 200(sp)
      sw      t2, 204(sp)
      sw      t3, 208(sp)
      sw      t4, 212(sp)
      sw      t5, 216(sp)
      sw      t6, 220(sp)
      sw      a0, 224(sp)
      sw      a1, 228(sp)
      sw      a2, 232(sp)
      sw      a3, 236(sp)
      sw      a4, 240(sp)
      sw      a5, 244(sp)
      sw      a6, 248(sp)
      sw      a7, 252(sp)
      mv      a0, s1
      call    erase
      lw      ra, 192(sp)
      lw      t0, 196(sp)
      lw      t1, 200(sp)
      lw      t2, 204(sp)
      lw      t3, 208(sp)
      lw      t4, 212(sp)
      lw      t5, 216(sp)
      lw      t6, 220(sp)
      lw      a0, 224(sp)
      lw      a1, 228(sp)
      lw      a2, 232(sp)
      lw      a3, 236(sp)
      lw      a4, 240(sp)
      lw      a5, 244(sp)
      lw      a6, 248(sp)
      lw      a7, 252(sp)
      # br label %if.end.0
      j       generateOperations_if.end.0
generateOperations_if.end.0:
      # br label %for.step.0
      j       generateOperations_for.step.0
generateOperations_for.step.0:
      # %_15 = add i32 %_i.1.0, 1
      li      s0, 1
      add     s0, s4, s0
      # br label %for.cond.0
      mv      s4, s0
      mv      s0, s1
      j       generateOperations_for.cond.0
generateOperations_for.end.0:
      # ret void
      lw      s11, 300(sp)
      lw      s10, 296(sp)
      lw      s9, 292(sp)
      lw      s8, 288(sp)
      lw      s7, 284(sp)
      lw      s6, 280(sp)
      lw      s5, 276(sp)
      lw      s4, 272(sp)
      lw      s3, 268(sp)
      lw      s2, 264(sp)
      lw      s1, 260(sp)
      lw      s0, 256(sp)
      addi    sp, sp, 304
      ret     
      .section text
      .globl insert
insert:
      addi    sp, sp, -176
      sw      s11, 172(sp)
      sw      s10, 168(sp)
      sw      s9, 164(sp)
      sw      s8, 160(sp)
      sw      s7, 156(sp)
      sw      s6, 152(sp)
      sw      s5, 148(sp)
      sw      s4, 144(sp)
      sw      s3, 140(sp)
      sw      s2, 136(sp)
      sw      s1, 132(sp)
      sw      s0, 128(sp)
      mv      s2, a0
insert_entry:
      # %_0 = load ptr, ptr @root
      la      s0, root
      lw      s1, 0(s0)
      # %_1 = icmp ne ptr %_0, null
      li      s0, 0
      sub     s0, s1, s0
      snez    s0, s0
      # br i1 %_1, label %if.then.0, label %if.end.0
      beqz     s0, insert_if.end.0
insert_if.then.0:
      # %_3 = load ptr, ptr @root
      la      s0, root
      lw      s0, 0(s0)
      # %_2 = call i32 @insertImpl(ptr %_3, ptr null, i32 -1, i32 %_key)
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
      mv      a0, s0
      li      a1, 0
      li      a2, -1
      mv      a3, s2
      call    insertImpl
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
      # ret i32 %_2
      mv      a0, s0
      lw      s11, 172(sp)
      lw      s10, 168(sp)
      lw      s9, 164(sp)
      lw      s8, 160(sp)
      lw      s7, 156(sp)
      lw      s6, 152(sp)
      lw      s5, 148(sp)
      lw      s4, 144(sp)
      lw      s3, 140(sp)
      lw      s2, 136(sp)
      lw      s1, 132(sp)
      lw      s0, 128(sp)
      addi    sp, sp, 176
      ret     
insert_if.end.0:
      # %_5 = load ptr, ptr @root
      la      s0, root
      lw      s0, 0(s0)
      # %_6 = call ptr @constructNode(i32 %_key, ptr null, ptr null, ptr null)
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
      mv      a0, s2
      li      a1, 0
      li      a2, 0
      li      a3, 0
      call    constructNode
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
      # store ptr %_6, ptr @root
      la      t0, root
      sw      s0, 0(t0)
      # ret i32 0
      li      a0, 0
      lw      s11, 172(sp)
      lw      s10, 168(sp)
      lw      s9, 164(sp)
      lw      s8, 160(sp)
      lw      s7, 156(sp)
      lw      s6, 152(sp)
      lw      s5, 148(sp)
      lw      s4, 144(sp)
      lw      s3, 140(sp)
      lw      s2, 136(sp)
      lw      s1, 132(sp)
      lw      s0, 128(sp)
      addi    sp, sp, 176
      ret     
      .section text
      .globl main
main:
      addi    sp, sp, -432
      sw      s11, 428(sp)
      sw      s10, 424(sp)
      sw      s9, 420(sp)
      sw      s8, 416(sp)
      sw      s7, 412(sp)
      sw      s6, 408(sp)
      sw      s5, 404(sp)
      sw      s4, 400(sp)
      sw      s3, 396(sp)
      sw      s2, 392(sp)
      sw      s1, 388(sp)
      sw      s0, 384(sp)
main_entry:
      # call void @__init()
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
      call    __init
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
      # %_0 = load i32, ptr @seed
      la      s0, seed
      lw      s0, 0(s0)
      # %_1 = call i32 @getInt()
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
      call    getInt
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
      # store i32 %_1, ptr @seed
      la      s1, seed
      sw      s0, 0(s1)
      # %_2 = load i32, ptr @MaxRandInt
      la      s0, MaxRandInt
      lw      s1, 0(s0)
      # %_3 = sdiv i32 %_2, 10
      li      s0, 10
      div     s1, s1, s0
      # %_4 = mul i32 8, %_3
      li      s0, 8
      mul     s1, s0, s1
      # %_5 = add i32 50000, 0
      li      s0, 50000
      li      s2, 0
      add     s0, s0, s2
      # call void @generateOperations(i32 %_4, i32 %_5)
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
      mv      a0, s1
      mv      a1, s0
      call    generateOperations
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
      # %_6 = load i32, ptr @MaxRandInt
      la      s0, MaxRandInt
      lw      s1, 0(s0)
      # %_7 = sdiv i32 %_6, 10
      li      s0, 10
      div     s1, s1, s0
      # %_8 = mul i32 2, %_7
      li      s0, 2
      mul     s1, s0, s1
      # %_9 = add i32 50000, 0
      li      s2, 50000
      li      s0, 0
      add     s0, s2, s0
      # %_10 = mul i32 2, %_9
      li      s2, 2
      mul     s0, s2, s0
      # call void @generateOperations(i32 %_8, i32 %_10)
      sw      ra, 192(sp)
      sw      t0, 196(sp)
      sw      t1, 200(sp)
      sw      t2, 204(sp)
      sw      t3, 208(sp)
      sw      t4, 212(sp)
      sw      t5, 216(sp)
      sw      t6, 220(sp)
      sw      a0, 224(sp)
      sw      a1, 228(sp)
      sw      a2, 232(sp)
      sw      a3, 236(sp)
      sw      a4, 240(sp)
      sw      a5, 244(sp)
      sw      a6, 248(sp)
      sw      a7, 252(sp)
      mv      a0, s1
      mv      a1, s0
      call    generateOperations
      lw      ra, 192(sp)
      lw      t0, 196(sp)
      lw      t1, 200(sp)
      lw      t2, 204(sp)
      lw      t3, 208(sp)
      lw      t4, 212(sp)
      lw      t5, 216(sp)
      lw      t6, 220(sp)
      lw      a0, 224(sp)
      lw      a1, 228(sp)
      lw      a2, 232(sp)
      lw      a3, 236(sp)
      lw      a4, 240(sp)
      lw      a5, 244(sp)
      lw      a6, 248(sp)
      lw      a7, 252(sp)
      # %_11 = load i32, ptr @MaxRandInt
      la      s0, MaxRandInt
      lw      s0, 0(s0)
      # %_12 = sdiv i32 %_11, 10
      li      s1, 10
      div     s0, s0, s1
      # %_13 = mul i32 4, %_12
      li      s1, 4
      mul     s1, s1, s0
      # %_14 = add i32 50000, 0
      li      s2, 50000
      li      s0, 0
      add     s0, s2, s0
      # call void @generateOperations(i32 %_13, i32 %_14)
      sw      ra, 256(sp)
      sw      t0, 260(sp)
      sw      t1, 264(sp)
      sw      t2, 268(sp)
      sw      t3, 272(sp)
      sw      t4, 276(sp)
      sw      t5, 280(sp)
      sw      t6, 284(sp)
      sw      a0, 288(sp)
      sw      a1, 292(sp)
      sw      a2, 296(sp)
      sw      a3, 300(sp)
      sw      a4, 304(sp)
      sw      a5, 308(sp)
      sw      a6, 312(sp)
      sw      a7, 316(sp)
      mv      a0, s1
      mv      a1, s0
      call    generateOperations
      lw      ra, 256(sp)
      lw      t0, 260(sp)
      lw      t1, 264(sp)
      lw      t2, 268(sp)
      lw      t3, 272(sp)
      lw      t4, 276(sp)
      lw      t5, 280(sp)
      lw      t6, 284(sp)
      lw      a0, 288(sp)
      lw      a1, 292(sp)
      lw      a2, 296(sp)
      lw      a3, 300(sp)
      lw      a4, 304(sp)
      lw      a5, 308(sp)
      lw      a6, 312(sp)
      lw      a7, 316(sp)
      # %_15 = load ptr, ptr @root
      la      s0, root
      lw      s0, 0(s0)
      # call void @printTree(ptr %_15)
      sw      ra, 320(sp)
      sw      t0, 324(sp)
      sw      t1, 328(sp)
      sw      t2, 332(sp)
      sw      t3, 336(sp)
      sw      t4, 340(sp)
      sw      t5, 344(sp)
      sw      t6, 348(sp)
      sw      a0, 352(sp)
      sw      a1, 356(sp)
      sw      a2, 360(sp)
      sw      a3, 364(sp)
      sw      a4, 368(sp)
      sw      a5, 372(sp)
      sw      a6, 376(sp)
      sw      a7, 380(sp)
      mv      a0, s0
      call    printTree
      lw      ra, 320(sp)
      lw      t0, 324(sp)
      lw      t1, 328(sp)
      lw      t2, 332(sp)
      lw      t3, 336(sp)
      lw      t4, 340(sp)
      lw      t5, 344(sp)
      lw      t6, 348(sp)
      lw      a0, 352(sp)
      lw      a1, 356(sp)
      lw      a2, 360(sp)
      lw      a3, 364(sp)
      lw      a4, 368(sp)
      lw      a5, 372(sp)
      lw      a6, 376(sp)
      lw      a7, 380(sp)
      # ret i32 0
      li      a0, 0
      lw      s11, 428(sp)
      lw      s10, 424(sp)
      lw      s9, 420(sp)
      lw      s8, 416(sp)
      lw      s7, 412(sp)
      lw      s6, 408(sp)
      lw      s5, 404(sp)
      lw      s4, 400(sp)
      lw      s3, 396(sp)
      lw      s2, 392(sp)
      lw      s1, 388(sp)
      lw      s0, 384(sp)
      addi    sp, sp, 432
      ret     
      .section text
      .globl randInt31
randInt31:
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
randInt31_entry:
      # %_0 = load i32, ptr @seed
      la      t0, seed
      lw      t1, 0(t0)
      # %_4 = shl i32 %_0, 13
      li      t0, 13
      sll     t0, t1, t0
      # %_5 = xor i32 %_0, %_4
      xor     t1, t1, t0
      # %_8 = xor i32 -2147483648, -1
      li      t0, -2147483648
      li      t2, -1
      xor     t0, t0, t2
      # %_9 = and i32 %_5, %_8
      and     t0, t1, t0
      # %_13 = ashr i32 %_9, 17
      li      t1, 17
      sra     t1, t0, t1
      # %_14 = xor i32 %_9, %_13
      xor     t0, t0, t1
      # %_18 = shl i32 %_14, 5
      li      t1, 5
      sll     t1, t0, t1
      # %_19 = xor i32 %_14, %_18
      xor     t2, t0, t1
      # %_22 = xor i32 -2147483648, -1
      li      t1, -2147483648
      li      t0, -1
      xor     t0, t1, t0
      # %_23 = and i32 %_19, %_22
      and     a0, t2, t0
      # %_24 = load i32, ptr @seed
      la      t0, seed
      lw      t0, 0(t0)
      # store i32 %_23, ptr @seed
      la      t0, seed
      sw      a0, 0(t0)
      # ret i32 %_23
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
      .globl printTree
printTree:
      addi    sp, sp, -496
      sw      s11, 492(sp)
      sw      s10, 488(sp)
      sw      s9, 484(sp)
      sw      s8, 480(sp)
      sw      s7, 476(sp)
      sw      s6, 472(sp)
      sw      s5, 468(sp)
      sw      s4, 464(sp)
      sw      s3, 460(sp)
      sw      s2, 456(sp)
      sw      s1, 452(sp)
      sw      s0, 448(sp)
      mv      s2, a0
printTree_entry:
      # %_1 = icmp eq ptr %_cur, null
      li      s0, 0
      sub     s0, s2, s0
      seqz    s0, s0
      # br i1 %_1, label %if.then.0, label %if.end.0
      beqz     s0, printTree_if.end.0
printTree_if.then.0:
      # ret void
      lw      s11, 492(sp)
      lw      s10, 488(sp)
      lw      s9, 484(sp)
      lw      s8, 480(sp)
      lw      s7, 476(sp)
      lw      s6, 472(sp)
      lw      s5, 468(sp)
      lw      s4, 464(sp)
      lw      s3, 460(sp)
      lw      s2, 456(sp)
      lw      s1, 452(sp)
      lw      s0, 448(sp)
      addi    sp, sp, 496
      ret     
printTree_if.end.0:
      # %_3 = getelementptr %class.Node, ptr %_cur, i32 0, i32 1
      li      s1, 1
      li      s0, 4
      mul     s0, s1, s0
      add     s0, s2, s0
      # %_4 = load ptr, ptr %_3
      lw      s1, 0(s0)
      # %_5 = getelementptr ptr, ptr %_4, i32 0
      li      s3, 0
      li      s0, 4
      mul     s0, s3, s0
      add     s0, s1, s0
      # %_6 = load ptr, ptr %_5
      lw      s0, 0(s0)
      # call void @printTree(ptr %_6)
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
      mv      a0, s0
      call    printTree
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
      # %_9 = getelementptr %class.Node, ptr %_cur, i32 0, i32 2
      li      s0, 2
      li      s1, 4
      mul     s0, s0, s1
      add     s0, s2, s0
      # %_10 = load i32, ptr %_9
      lw      s0, 0(s0)
      # %_7 = call ptr @toString(i32 %_10)
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
      # %_11 = call ptr @_string.concat(ptr %_7, ptr @string.0)
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
      la      a1, string.0
      call    _string.concat
      mv      s1, a0
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
      # %_14 = getelementptr %class.Node, ptr %_cur, i32 0, i32 3
      li      s0, 3
      li      s3, 4
      mul     s0, s0, s3
      add     s0, s2, s0
      # %_15 = load i32, ptr %_14
      lw      s0, 0(s0)
      # %_12 = call ptr @toString(i32 %_15)
      sw      ra, 192(sp)
      sw      t0, 196(sp)
      sw      t1, 200(sp)
      sw      t2, 204(sp)
      sw      t3, 208(sp)
      sw      t4, 212(sp)
      sw      t5, 216(sp)
      sw      t6, 220(sp)
      sw      a0, 224(sp)
      sw      a1, 228(sp)
      sw      a2, 232(sp)
      sw      a3, 236(sp)
      sw      a4, 240(sp)
      sw      a5, 244(sp)
      sw      a6, 248(sp)
      sw      a7, 252(sp)
      mv      a0, s0
      call    toString
      mv      s0, a0
      lw      ra, 192(sp)
      lw      t0, 196(sp)
      lw      t1, 200(sp)
      lw      t2, 204(sp)
      lw      t3, 208(sp)
      lw      t4, 212(sp)
      lw      t5, 216(sp)
      lw      t6, 220(sp)
      lw      a0, 224(sp)
      lw      a1, 228(sp)
      lw      a2, 232(sp)
      lw      a3, 236(sp)
      lw      a4, 240(sp)
      lw      a5, 244(sp)
      lw      a6, 248(sp)
      lw      a7, 252(sp)
      # %_16 = call ptr @_string.concat(ptr %_11, ptr %_12)
      sw      ra, 256(sp)
      sw      t0, 260(sp)
      sw      t1, 264(sp)
      sw      t2, 268(sp)
      sw      t3, 272(sp)
      sw      t4, 276(sp)
      sw      t5, 280(sp)
      sw      t6, 284(sp)
      sw      a0, 288(sp)
      sw      a1, 292(sp)
      sw      a2, 296(sp)
      sw      a3, 300(sp)
      sw      a4, 304(sp)
      sw      a5, 308(sp)
      sw      a6, 312(sp)
      sw      a7, 316(sp)
      mv      a0, s1
      mv      a1, s0
      call    _string.concat
      mv      s0, a0
      lw      ra, 256(sp)
      lw      t0, 260(sp)
      lw      t1, 264(sp)
      lw      t2, 268(sp)
      lw      t3, 272(sp)
      lw      t4, 276(sp)
      lw      t5, 280(sp)
      lw      t6, 284(sp)
      lw      a0, 288(sp)
      lw      a1, 292(sp)
      lw      a2, 296(sp)
      lw      a3, 300(sp)
      lw      a4, 304(sp)
      lw      a5, 308(sp)
      lw      a6, 312(sp)
      lw      a7, 316(sp)
      # call void @println(ptr %_16)
      sw      ra, 320(sp)
      sw      t0, 324(sp)
      sw      t1, 328(sp)
      sw      t2, 332(sp)
      sw      t3, 336(sp)
      sw      t4, 340(sp)
      sw      t5, 344(sp)
      sw      t6, 348(sp)
      sw      a0, 352(sp)
      sw      a1, 356(sp)
      sw      a2, 360(sp)
      sw      a3, 364(sp)
      sw      a4, 368(sp)
      sw      a5, 372(sp)
      sw      a6, 376(sp)
      sw      a7, 380(sp)
      mv      a0, s0
      call    println
      lw      ra, 320(sp)
      lw      t0, 324(sp)
      lw      t1, 328(sp)
      lw      t2, 332(sp)
      lw      t3, 336(sp)
      lw      t4, 340(sp)
      lw      t5, 344(sp)
      lw      t6, 348(sp)
      lw      a0, 352(sp)
      lw      a1, 356(sp)
      lw      a2, 360(sp)
      lw      a3, 364(sp)
      lw      a4, 368(sp)
      lw      a5, 372(sp)
      lw      a6, 376(sp)
      lw      a7, 380(sp)
      # %_18 = getelementptr %class.Node, ptr %_cur, i32 0, i32 1
      li      s0, 1
      li      s1, 4
      mul     s0, s0, s1
      add     s0, s2, s0
      # %_19 = load ptr, ptr %_18
      lw      s2, 0(s0)
      # %_20 = getelementptr ptr, ptr %_19, i32 1
      li      s0, 1
      li      s1, 4
      mul     s0, s0, s1
      add     s0, s2, s0
      # %_21 = load ptr, ptr %_20
      lw      s0, 0(s0)
      # call void @printTree(ptr %_21)
      sw      ra, 384(sp)
      sw      t0, 388(sp)
      sw      t1, 392(sp)
      sw      t2, 396(sp)
      sw      t3, 400(sp)
      sw      t4, 404(sp)
      sw      t5, 408(sp)
      sw      t6, 412(sp)
      sw      a0, 416(sp)
      sw      a1, 420(sp)
      sw      a2, 424(sp)
      sw      a3, 428(sp)
      sw      a4, 432(sp)
      sw      a5, 436(sp)
      sw      a6, 440(sp)
      sw      a7, 444(sp)
      mv      a0, s0
      call    printTree
      lw      ra, 384(sp)
      lw      t0, 388(sp)
      lw      t1, 392(sp)
      lw      t2, 396(sp)
      lw      t3, 400(sp)
      lw      t4, 404(sp)
      lw      t5, 408(sp)
      lw      t6, 412(sp)
      lw      a0, 416(sp)
      lw      a1, 420(sp)
      lw      a2, 424(sp)
      lw      a3, 428(sp)
      lw      a4, 432(sp)
      lw      a5, 436(sp)
      lw      a6, 440(sp)
      lw      a7, 444(sp)
      # ret void
      lw      s11, 492(sp)
      lw      s10, 488(sp)
      lw      s9, 484(sp)
      lw      s8, 480(sp)
      lw      s7, 476(sp)
      lw      s6, 472(sp)
      lw      s5, 468(sp)
      lw      s4, 464(sp)
      lw      s3, 460(sp)
      lw      s2, 456(sp)
      lw      s1, 452(sp)
      lw      s0, 448(sp)
      addi    sp, sp, 496
      ret     
      .section data
      .globl seed
seed:
      .word  0
      .section data
      .globl MAX
MAX:
      .word  128
      .section data
      .globl MaxRandInt
MaxRandInt:
      .word  0
      .section data
      .globl root
root:
      .word  0
      .section rodata
      .globl string.0
string.0:
      .asciz  ": "
