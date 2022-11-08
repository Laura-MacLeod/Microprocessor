	#include <xc.inc>

psect	code, abs
	
main:
	org	0x0
	goto	start

	org	0x100		    ; Main code starts here at address 0x100
start:
	
	;ovlw 	0x0
	;ovwf	TRISD, A	    ; Port D all outputs
	clrf	TRISD
	
	;ovlw 	0x0
	;ovwf	TRISE, A	    ; Port E all outputs
	clrf	TRISE
    
	;ovlw	0x0e
	;ovwf	PORTE, A	    ; Set value to PORTE/LATE
	clrf	LATE
	
	
	;ovlw	0x03
	;ovwf	PORTD		; Set clock pulse and output enable both om. PORTD to 0x03,
				; for CP and OE on, PORTE=3, for CP on snd OE off, PORTE=2, for CP off and OE
				; on, PORTE=1, for CP and OE both off, PORTE=0
	clrf	LATD
	bsf	LATD, 0

	
				
	movlw	0xff
	movwf	0x02	    ; Counter of 0xff at position 0x02
	
	movlw	0xff
	movwf	0x03
	
	movlw	0xff
	movwf	0x04
	
	
increment:		    ; increment data sent to PORTE
	
	incf	LATE
	bcf	LATD, 0	
	
	bra	delay
	
	
delay:			    ; decrement position 0x02 once and then branches to 
	
	decfsz	0x02
	bra	delayloop1
	
	
	bsf	LATD, 0
	
	bra	increment
delayloop1:
    
	decfsz	0x03
	bra	delayloop2
	bra	delay

delayloop2:
	decfsz	0x04
	bra	delayloop2
	bra	delayloop1
    
	
test:
	movlw	0x05
	
	
	goto 	0x0
	
	end	main

	
	end	main
