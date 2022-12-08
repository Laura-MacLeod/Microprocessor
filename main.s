#include <xc.inc>

extrn	UART_Setup, UART_Transmit_Message  ; external subroutines
extrn	LCD_Setup, LCD_Write_Message, clear
extrn	keypad_setup, keypad_read_row, keypad_read_column, combine, interpret
	
psect	udata_acs   ; reserve data space in access ram
counter:    ds 1    ; reserve one byte for a counter variable
delay_count:ds 1    ; reserve one byte for counter in the delay routine
length:	    ds 1
store:	    ds 1

    
psect	udata_bank4 ; reserve data anywhere in RAM (here at 0x400)
storage:    ds 0x80



psect	code, abs	
rst: 	org 0x0
 	goto	setup

	; ******* Programme FLASH read Setup Code ***********************
setup:	call	keypad_setup
	call	UART_Setup
	call	LCD_Setup
	movlw	0x02
	movwf	length
	
    
	; ******* Main programme ****************************************
start: 	
	nop
	call	keypad_read_row
	call	delay
	nop
	call	keypad_read_column
	call	combine

	nop
	call	interpret
	lfsr	0, storage
	movwf	store
	
	movwf	TBLPTRH
	movff	TABLAT, POSTINC0
	
	movlw	length
	addlw	0xff
	call	UART_Transmit_Message
	
	movlw	length
	call	LCD_Write_Message
	bra	start
loop: 	
	
	goto	$		; goto current line in code
	


	; a delay subroutine if you need one, times around loop in delay_count
delay:	decfsz	delay_count, A	; decrement until zero
	bra	delay
	return

	end	rst
