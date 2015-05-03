.globl dut

@ reps in r0
@ chunk of memory in r1

@ This routine takes 12 cycles per rep, unless you insert a nop at any of
@ the places marked as "@ HERE 11", in which case it takes 11 cycles per rep. 
@ Any "@ HERE 12" still takes 12 cycles per rep.

.align 3
dut:
	mov r3, #0x00
	mov r2, #0
.1:	@ HERE 11
	mov r2, r0	@ 1 cyc
	@ HERE 11	@ 1 cyc data dependency
	and r2, r2, r3	@ 1 cyc
	@ HERE 11	@ 1 cyc data dependency
	str r0, [r1, r2]	@ 1 cyc
	@ HERE 12
	sub r0, r0, #1	@ 1 cyc
	@ HERE 12	@ 1 cyc data dependency
	cmp r0, #0	@ 1 cyc
	@ HERE 12
	bne .1		@ 3 cyc
	bx lr