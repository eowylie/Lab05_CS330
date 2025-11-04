	.file	"asgn5.c"
	.text
	.section	.rodata
.LC0:
	.string	"Original array: "
.LC1:
	.string	"%d "
.LC2:
	.string	"Modified array (squared): "
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$2, -32(%rbp)
	movl	$3, -28(%rbp)
	movl	$5, -24(%rbp)
	movl	$7, -20(%rbp)
	movl	$11, -16(%rbp)
	movl	$13, -12(%rbp)
	movl	$6, -40(%rbp)
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, -52(%rbp)
	jmp	.L2
.L3:
	movl	-52(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	-32(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	movl	%eax, %esi
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	addl	$1, -52(%rbp)
.L2:
	movl	-52(%rbp), %eax
	cmpl	-40(%rbp), %eax
	jl	.L3
	movl	$10, %edi
	call	putchar@PLT
	movl	$0, -48(%rbp)
	jmp	.L4
.L5:
	movl	-48(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	-32(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	movl	%eax, -36(%rbp)
	movl	-48(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	-32(%rbp), %rax
	addq	%rax, %rdx
	movl	-36(%rbp), %eax
	imull	%eax, %eax
	movl	%eax, (%rdx)
	addl	$1, -48(%rbp)
.L4:
	movl	-48(%rbp), %eax
	cmpl	-40(%rbp), %eax
	jl	.L5
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, -44(%rbp)
	jmp	.L6
.L7:
	movl	-44(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	-32(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	movl	%eax, %esi
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	addl	$1, -44(%rbp)
.L6:
	movl	-44(%rbp), %eax
	cmpl	-40(%rbp), %eax
	jl	.L7
	movl	$10, %edi
	call	putchar@PLT
	movl	$0, %eax
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L9
	call	__stack_chk_fail@PLT
.L9:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
