	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 12, 0
	.globl	_main                           ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:                               ## %entry
	pushq	%rbx
	.cfi_def_cfa_offset 16
	subq	$48, %rsp
	.cfi_def_cfa_offset 64
	.cfi_offset %rbx, -16
	movl	$76, %edi
	callq	_malloc
	leaq	12(%rax), %rcx
	movabsq	$326417514504, %rbx             ## imm = 0x4C00000008
	movq	%rbx, (%rax)
	movl	$8, 8(%rax)
	movq	%rcx, 16(%rsp)
	leaq	L_str_ptr(%rip), %rax
	movq	%rax, 24(%rsp)
	leaq	L_str_ptr.6(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	L_str_ptr.7(%rip), %rax
	movq	%rax, 40(%rsp)
	movl	$76, %edi
	callq	_malloc
	leaq	12(%rax), %rcx
	movq	%rbx, (%rax)
	movl	$8, 8(%rax)
	movq	%rcx, 8(%rsp)
	movq	24(%rsp), %rcx
	movq	%rcx, 12(%rax)
	movq	32(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rax, 8(%rcx)
	movq	40(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rax, 16(%rcx)
	movq	24(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rax, 24(%rcx)
	movq	24(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rax, 32(%rcx)
	movq	24(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rax, 40(%rcx)
	movq	24(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rax, 48(%rcx)
	movq	32(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rax, 56(%rcx)
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	%rax, (%rcx)
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	%rax, 8(%rcx)
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	%rax, 16(%rcx)
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	%rax, 24(%rcx)
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	%rax, 32(%rcx)
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	%rax, 40(%rcx)
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	%rax, 48(%rcx)
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	%rax, 56(%rcx)
	movq	16(%rsp), %rdi
	xorl	%eax, %eax
	callq	_play_song
	xorl	%eax, %eax
	addq	$48, %rsp
	popq	%rbx
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__cstring,cstring_literals
L_fmt:                                  ## @fmt
	.asciz	"%d\n"

L_fmt.1:                                ## @fmt.1
	.asciz	"%B\n"

L_fmt.2:                                ## @fmt.2
	.asciz	"%g\n"

L_fmt.3:                                ## @fmt.3
	.asciz	"%c\n"

L_fmt.4:                                ## @fmt.4
	.asciz	"%s\n"

L_fmt.5:                                ## @fmt.5
	.asciz	"/%s/ /%g/\n"

L_str_ptr:                              ## @str_ptr
	.asciz	"A1"

L_str_ptr.6:                            ## @str_ptr.6
	.asciz	"A2"

L_str_ptr.7:                            ## @str_ptr.7
	.asciz	"B1"

.subsections_via_symbols
