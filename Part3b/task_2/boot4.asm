section .boot
bits 16
global boot
boot:
	mov ax, 0x2401
	int 0x15

	mov ax, 0x3
	int 0x10

	mov [disk], dl

	mov ah, 0x2    ; read sectors
	mov al, 6      ; sectors to read
	mov ch, 0      ; cylinder idx
	mov dh, 0      ; head idx
	mov cl, 2      ; sector idx
	mov dl, [disk] ; disk idx
	mov bx, copy_target ; target pointer
	int 0x13

	cli
	lgdt [gdt_pointer]
	mov eax, cr0
	or eax, 0x1
	mov cr0, eax
	mov ax, DATA_SEG
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax

	; Display menu and get user input
	display_menu:
		call clear_screen
		mov si, menu_text
		call print_string
		call read_key
		cmp al, '1'
		je option_1
		cmp al, '2'
		je option_2
		cmp al, '3'
		je option_3
		jmp display_menu

	option_1:
		mov si, option1_text
		call print_string
		jmp halt

	option_2:
		mov si, option2_text
		call print_string
		jmp halt

	option_3:
		mov si, option3_text
		call print_string
		jmp halt

	halt:
		mov esp, kernel_stack_top
		extern kmain
		call kmain
		cli
		hlt

	clear_screen:
		mov eax, 0x0600
		mov ebx, 0x0000
		xor edx, edx
		mov esi, clear_text
		call 0x13*0x10+0
		ret

	read_key:
		mov ah, 0
		int 16h
		ret

	print_string:
		lodsb
		or al, al
		jz .done
		or eax, 0x0F00
		mov word [ebx], ax
		add ebx, 2
		jmp print_string
	.done:
		ret

menu_text db 'Select an option:', 0
option1_text db 'Option 1 selected.', 0
option2_text db 'Option 2 selected.', 0
option3_text db 'Option 3 selected.', 0
clear_text db 0x0, 0x0
	gdt_start:
		dq 0x0
	gdt_code:
		dw 0xFFFF
		dw 0x0
		db 0x0
		db 10011010b
		db 11001111b
		db 0x0
	gdt_data:
		dw 0xFFFF
		dw 0x0
		db 0x0
		db 10010010b
		db 11001111b
		db 0x0
	gdt_end:
	gdt_pointer:
		dw gdt_end - gdt_start
		dd gdt_start
	disk:
		db 0x0
	CODE_SEG equ gdt_code - gdt_start
	DATA_SEG equ gdt_data - gdt_start

	times 510 - ($-$$) db 0
	dw 0xaa55
	copy_target:
		bits 32
			hello: db "Hello more than 512 bytes world!!", 0
	boot2:
		mov esi, hello
		mov ebx, 0xb8000
	.loop:
		lodsb
		or al, al
		jz halt
		or eax, 0x0F00
		mov word [ebx], ax
		add ebx, 2
		jmp .loop
	halt:
		mov esp, kernel_stack_top
		extern kmain
		call kmain
		cli
		hlt

	section .bss
	align 4
	kernel_stack_bottom: equ $
		resb 16384 ; 16 KB
	kernel_stack_top: ; bottom of stack

