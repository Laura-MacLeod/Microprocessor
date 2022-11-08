	#include <xc.inc>

psect	code, abs
	
main:
	org	0x0
	goto	start

	org	0x100		    ; Main code starts here at address 0x100
start:
	movlw	0x0e
	movwf	PORTE, A	    ; Set value to PORTE
	
	
	movlw	0x03
	movwf	PORTD		; Set clock pulse and output enable both om. PORTD to 0x03,
				; for CP and OE on, PORTE=3, for CP on snd OE off, PORTE=2, for CP off and OE
				; on, PORTE=1, for CP and OE both off, PORTE=0
	
				
	movlw	0xff
	movwf	0x02	    ; Counter of 0xff at position 0x02
	
	bra	delay
	
	
delay:
	decfsz	0x02
	bra	delay
	
test:
	movlw	0x05
	
	
	
	
	end	main
