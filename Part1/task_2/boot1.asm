bits 16        ; tell NASM this is 16 bit code
org 0x7c00     ; tell NASM to start outputting stuff at offset 0x7c00

jmp boot       ; jump to start of bootloader code

; Bootloader code starts here
boot:
    mov si, menu ; point si register to menu label memory location
    call print_string  ; print the menu options

.read_option:
    call read_char   ; read user input character
    cmp al, '1'      ; compare input with option 1
    je option1       ; jump to option1 if equal
    cmp al, '2'      ; compare input with option 2
    je option2       ; jump to option2 if equal
    cmp al, '3'      ; compare input with option 3
    je option3       ; jump to option3 if equal
    jmp .read_option ; jump back to read_option if no valid option

option1:
    mov si, hello1   ; point si to hello1 label
    call print_message_and_wait ; call subroutine to print message and wait for keypress
    jmp boot        ; jump back to menu

option2:
    mov si, hello2   ; point si to hello2 label
    call print_message_and_wait ; call subroutine to print message and wait for keypress
    jmp boot        ; jump back to menu

option3:
    mov si, hello3   ; point si to hello3 label
    call print_message_and_wait ; call subroutine to print message and wait for keypress
    jmp boot        ; jump back to menu

print_message_and_wait:
    call print_string  ; print the message pointed by si
    call print_newline ; print newline (CR, LF)
    call wait_for_keypress ; wait for any keypress
    ret

print_string:
    mov ah, 0x0e       ; BIOS teletype function
.loop:
    lodsb              ; load byte at si into al, increment si
    or al, al          ; check if al is zero
    jz .done           ; jump to .done if end of string
    int 0x10           ; call BIOS interrupt to print character
    jmp .loop          ; loop to print next character
.done:
    ret                ; return from print_string subroutine

print_newline:
    mov al, 0x0d       ; carriage return
    int 0x10           ; print CR
    mov al, 0x0a       ; line feed
    int 0x10           ; print LF
    ret                ; return from print_newline subroutine

wait_for_keypress:
    mov ah, 0          ; BIOS function for keyboard input
    int 0x16           ; interrupt to wait for keypress
    ret                ; return from wait_for_keypress subroutine

read_char:
    mov ah, 0          ; BIOS function for keyboard input
    int 0x16           ; interrupt to wait for keypress
    ret                ; return with the ASCII code in al

halt:
    cli                ; clear interrupt flag
    hlt                ; halt execution

; Data section
hello1 db "Hello from option 1!", 0
hello2 db "Hello from option 2!", 0
hello3 db "Hello from option 3!", 0

menu db "Bootloader Menu:", 0x0d, 0x0a
     db "1. Option 1", 0x0d, 0x0a
     db "2. Option 2", 0x0d, 0x0a
     db "3. Option 3", 0x0d, 0x0a
     db "Enter your choice: ", 0

times 510 - ($-$$) db 0  ; pad remaining 510 bytes with zeroes
dw 0xaa55                ; magic bootloader magic - marks this 512 byte sector bootable!
