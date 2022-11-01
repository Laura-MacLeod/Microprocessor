	#include <xc.inc>

psect	code, abs
	
main:
	org	0x0
	goto	start

	org	0x100		    ; Main code starts here at address 0x100
start:
	movlw	0xff
	movwf	TRISC, A	    ; Port D all inputs
	
	movlw 	0x0
	movwf	TRISD, A	    ; Port C all outputs
	
	bra 	test
loop:
    
	movff 	0x06, PORTD
	incf 	0x06, W, A
test:
    
	movwf	0x06, A	    ; Test for end of loop condition
	movf	PORTC, W    ; Assigns value of port C to W
	cpfsgt 	0x06, A	    ; Compares against W
	bra 	loop		    ; Not yet finished goto start of loop again
	goto 	0x0		    ; Re-run program from start

	end	main
