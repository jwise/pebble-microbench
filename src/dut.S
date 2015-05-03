.globl dut

@ reps in r0
@ chunk of memory in r1
dut:
	mov r1, #1
1:	sub r0, r0, r1	@ 1 cyc
	cmp r0, #0	@ 1 cyc
	bne 1b		@ 4 cyc
	bx lr