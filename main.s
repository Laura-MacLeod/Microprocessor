	#include <xc.inc>

psect	code, abs
	
main:
	org	0x0
	goto	start

	org	0x100		    ; Main code starts here at address 0x100
start:
	movlw	0x0e
	movwf	PORTE, A	    ; Set value to PORTE
	
	movlw	0xff
	movwf	0x02	    ; Counter of 0xff at position 0x02
	
	movlw	0xff
	movwf	PORTD		; Set clock pulse PORTD to 0xff
	
	bra	delay
	
	
delay:
	
	
	
	
	
	end	main
