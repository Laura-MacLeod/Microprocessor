	#include <xc.inc>

psect	code, abs
	; THIS IS A TEST FROM MY LAPTOP TO TEST GITHUB PUSHES
main:
	org	0x0
	goto	start

	org	0x100		    ; Main code starts here at address 0x100
start:
	movlw	0xff
	movwf	TRISC, A	    ; Port C all inputs
	
	movlw 	0x0
	movwf	TRISD, A	    ; Port D all outputs
	
	movlw	0xff
	movwf	0x01		    ; move number 0xff to position 0x01 for delay decriment
	
	bra 	test
	
loopdelay:
    
	movff 	0x06, PORTD	    ; Flashes lights with contents of 0x06
	incf 	0x06, W, A	    ; Increments 0x06
	call	delay
	

delay:
	decfsz	0x01, F, A
	bra	delay
	return	0

test:
    
	movwf	0x06, A	    ; Test for end of loop condition
	;movf	PORTC, W    ; Assigns value of port C to W
	movlw	0x10
	cpfsgt 	0x06, A	    ; Compares against W
	bra 	loopdelay		    ; Not yet finished goto start of loop again
	goto 	0x0		    ; Re-run program from start

	end	main
