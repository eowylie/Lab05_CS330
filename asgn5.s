	.file	"asgn5.c" # Identifies source file
	.text
	.section	.rodata
.LC0: # Label for first string
	.string	"Original array: "
.LC1: # Label for second string
	.string	"%d "
.LC2: # Label for third string
	.string	"Modified array (squared): "
	.text
	.globl	main # Set the main as global
	.type	main, @function # Declare the main function
main: # Label for start of main function
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp # Save pointer on stack
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp # Set up new pointer (rbp = rsp)
	.cfi_def_cfa_register 6
	subq	$64, %rsp # Allocate 64 bytes on stack
	movq	%fs:40, %rax # Load canary value for security check
	movq	%rax, -8(%rbp) # Store canary at rbp-8 for later
	xorl	%eax, %eax # Clear eax register
	
	# Initialize array myarr[] = {2, 3, 5, 7, 11, 13} on stack
	movl	$2, -32(%rbp) # myarr[0] = 2 at rbp-32
	movl	$3, -28(%rbp) # myarr[1] = 3 at rbp-28  
	movl	$5, -24(%rbp) # myarr[2] = 5 at rbp-24
	movl	$7, -20(%rbp) # myarr[3] = 7 at rbp-20
	movl	$11, -16(%rbp) # myarr[4] = 11 at rbp-16
	movl	$13, -12(%rbp) # myarr[5] = 13 at rbp-12
	movl	$6, -40(%rbp) # Store size = 6 at rbp-40
	
	# Print "Original array: "
	leaq	.LC0(%rip), %rax # Load address of "Original array: " string
	movq	%rax, %rdi # Move string address to rdi (1st argument for printf)
	movl	$0, %eax # Clear eax (no floating-point args to printf)
	call	printf@PLT # Call printf function
	
	# First loop prints array values
	movl	$0, -52(%rbp)  # Set counter i = 0 at rbp-52
	jmp	.L2 # Jump to condition check
.L3: # Loop body label
	movl	-52(%rbp), %eax # Load i into eax
	cltq  # Sign extend eax to rax 
	leaq	0(,%rax,4), %rdx # Calculate i*4 into rdx
	leaq	-32(%rbp), %rax # Load address of array into rax
	addq	%rdx, %rax # Add offset (rax = myarr + i)
	movl	(%rax), %eax # Load *(myarr + i) into eax
	movl	%eax, %esi # Move value to esi (2nd argument for printf)
	leaq	.LC1(%rip), %rax # Load address of "%d "
	movq	%rax, %rdi # Move format string to rdi (1st arg)
	movl	$0, %eax # Clear eax
	call	printf@PLT # Call printf
	addl	$1, -52(%rbp) # i++
.L2:    # Loop condition label
	movl	-52(%rbp), %eax # Load i into eax
	cmpl	-40(%rbp), %eax # Compare i with size
	jl	.L3 # If i < size, jump back to loop
	movl	$10, %edi # ASCII code for newline
	call	putchar@PLT # Print newline
	
	# Second loop squares each element
	movl	$0, -48(%rbp) # Initialize loop counter i = 0 at rbp-48
	jmp	.L4 # Jump to loop condition check
.L5:   # Loop body label
	movl	-48(%rbp), %eax  # Load i into eax
	cltq  # Sign extend eax to rax
	leaq	0(,%rax,4), %rdx # Calculate i*4 into rdx
	leaq	-32(%rbp), %rax  # Load address of array into rax
	addq	%rdx, %rax  # Add offset (rax = myarr + i)
	movl	(%rax), %eax  # Load *(myarr + i) into eax
	movl	%eax, -36(%rbp) # Store current_value at rbp-36
	movl	-48(%rbp), %eax # Load i into eax again
	cltq # Sign-extend eax to rax
	leaq	0(,%rax,4), %rdx # Calculate i*4 into rdx
	leaq	-32(%rbp), %rax # Load base address of array into rax
	addq	%rax, %rdx # Add base to offset (rdx = myarr + i)
	movl	-36(%rbp), %eax # Load current_value into eax
	imull	%eax, %eax # Square the value (eax = eax * eax)
	movl	%eax, (%rdx)  # Store squared value: *(myarr + i) = squared
	addl	$1, -48(%rbp) # i++
.L4:   # Loop condition label
	movl	-48(%rbp), %eax # Load i into eax
	cmpl	-40(%rbp), %eax  # Compare i with size
	jl	.L5 # If i < size, jump back to loop
	
	# Print "Modified array (squared): "
	leaq	.LC2(%rip), %rax # Load address of string
	movq	%rax, %rdi # Move string address to rdi (1st argument)
	movl	$0, %eax # Clear eax
	call	printf@PLT # Call printf function
	
	# Third loop prints modified array values
	movl	$0, -44(%rbp) # Initialize counter i = 0 at rbp-44
	jmp	.L6 # Jump to condition check
.L7: # Loop body label
	movl	-44(%rbp), %eax # Load i into eax
	cltq # Sign extend eax to rax
	leaq	0(,%rax,4), %rdx # Calculate i*4 into rdx
	leaq	-32(%rbp), %rax # Load address of array into rax
	addq	%rdx, %rax # Add offset (rax = myarr + i)
	movl	(%rax), %eax # Load *(myarr + i) into eax
	movl	%eax, %esi # Move to esi (2nd arg for printf)
	leaq	.LC1(%rip), %rax # Load address of "%d"
	movq	%rax, %rdi # Move format string to rdi (1st arg)
	movl	$0, %eax # Clear eax
	call	printf@PLT # Call printf
	addl	$1, -44(%rbp) # i++
.L6: # Loop condition label
	movl	-44(%rbp), %eax # Load i into eax
	cmpl	-40(%rbp), %eax # Compare i with size
	jl	.L7 # If i < size, jump back to loop
	movl	$10, %edi # ASCII code for '\n'
	call	putchar@PLT # Print newline
	movl	$0, %eax # Set return value to 0 (success)
	
	# Stack protection check
	movq	-8(%rbp), %rdx # Load saved canary value
	subq	%fs:40, %rdx # Subtract current canary from saved
	je	.L9 # If difference is 0, jump to exit
	call	__stack_chk_fail@PLT # If not equal, abort
.L9: # Exit label
	leave
	.cfi_def_cfa 7, 8
	ret  # Return from main function
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
