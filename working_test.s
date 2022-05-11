	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 12, 0
	.globl	_main                           ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:                               ## %entry
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movl	$268, %edi                      ## imm = 0x10C
	callq	_malloc
	leaq	12(%rax), %rcx
	movabsq	$1151051235336, %rdx            ## imm = 0x10C00000008
	movq	%rdx, (%rax)
	movl	$32, 8(%rax)
	movq	%rcx, 8(%rsp)
	leaq	L_str_ptr(%rip), %rax
	movq	%rax, 16(%rsp)
	leaq	L_str_ptr.6(%rip), %rax
	movq	%rax, 24(%rsp)
	leaq	L_str_ptr.7(%rip), %rax
	movq	%rax, 32(%rsp)
	movl	$76, %edi
	callq	_malloc
	leaq	12(%rax), %rcx
	movabsq	$326417514504, %rdx             ## imm = 0x4C00000008
	movq	%rdx, (%rax)
	movl	$8, 8(%rax)
	movq	%rcx, (%rsp)
	movq	16(%rsp), %rcx
	movq	%rcx, 12(%rax)
	movq	24(%rsp), %rax
	movq	(%rsp), %rcx
	movq	%rax, 8(%rcx)
	movq	32(%rsp), %rax
	movq	(%rsp), %rcx
	movq	%rax, 16(%rcx)
	movq	16(%rsp), %rax
	movq	(%rsp), %rcx
	movq	%rax, 24(%rcx)
	movq	16(%rsp), %rax
	movq	(%rsp), %rcx
	movq	%rax, 32(%rcx)
	movq	16(%rsp), %rax
	movq	(%rsp), %rcx
	movq	%rax, 40(%rcx)
	movq	16(%rsp), %rax
	movq	(%rsp), %rcx
	movq	%rax, 48(%rcx)
	movq	24(%rsp), %rax
	movq	(%rsp), %rcx
	movq	%rax, 56(%rcx)
	movq	(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rax, (%rcx)
	movq	(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rax, 8(%rcx)
	movq	(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rax, 16(%rcx)
	movq	(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rax, 24(%rcx)
	movq	(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rax, 32(%rcx)
	movq	(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rax, 40(%rcx)
	movq	(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rax, 48(%rcx)
	movq	(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rax, 56(%rcx)
	movq	8(%rsp), %rdi
	xorl	%eax, %eax
	callq	_play_song
	xorl	%eax, %eax
	addq	$40, %rsp
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
