#include <xc.inc>

global  ADC_Setup, ADC_Read, convert    

psect udata_acs   ; named variables in access ram
RES0:	    ds 1
RES1:	    ds 1
RES2:	    ds 1
RES3:	    ds 1
ARG1L:	    ds 1
ARG1H:	    ds 1
ARG2L:	    ds 1
ARG2H:	    ds 1
ARG2HH:	    ds 1
k:	    ds 1
hexhigher:  ds 1
hexlower:   ds 1
dec1:	    ds 1
dec2:	    ds 1
dec3:	    ds 1
dec4:	    ds 1

    
psect	adc_code, class=CODE
        
ADC_Setup:
	bsf	TRISA, PORTA_RA0_POSN, A  ; pin RA0==AN0 input
	movlb	0x0f
	bsf	ANSEL0	    ; set AN0 to analog
	movlb	0x00
	movlw   0x01	    ; select AN0 for measurement
	movwf   ADCON0, A   ; and turn ADC on
	movlw   0x30	    ; Select 4.096V positive reference
	movwf   ADCON1,	A   ; 0V for -ve reference and -ve input
	movlw   0xF6	    ; Right justified output
	movwf   ADCON2, A   ; Fosc/64 clock and acquisition times
	return

ADC_Read:
	bsf	GO	    ; Start conversion by setting GO bit in ADCON0
adc_loop:
	btfsc   GO	    ; check to see if finished
	bra	adc_loop
	return

	
	
convert:
	
	MOVLW	0X41		
	MOVWF	ARG1H		    ; K HIGHER
	MOVLW	0X8A		
	MOVWF	ARG1L		    ; K LOWER
	
	MOVFF	ADRESH, ARG2H	    ;move upper hex value
	MOVFF	ADRESL, ARG2L	    ;move lower hex value
	
	call	multiply16x16
	
	
convert2:
	
	MOVFF	RES3, DEC1	    ;move most significant bit to storage
    
	MOVLW	0X0A		
	MOVWF	ARG1L		    ; 10 LOWER
	
	MOVFF	RES3, ARG2HH	    ;move upper upper hex value (most significant)
	MOVFF	RES2, ARG2H	    ;move upper hex value
	MOVFF	RES1, ARG2L	    ;move lower hex value
	MOVFF	RES0, ARG2LL	    ;move lower lower hex value
	
	call	multiply8x24	    
	

convert3:
	
	MOVFF	RES3, DEC2	    ;move most significant bit to storage
    
	MOVLW	0X0A		
	MOVWF	ARG1L		    ; 10 LOWER
	
	MOVFF	RES3, ARG2HH	    ;move upper upper hex value (most significant)
	MOVFF	RES2, ARG2H	    ;move upper hex value
	MOVFF	RES1, ARG2L	    ;move lower hex value
	MOVFF	RES0, ARG2LL	    ;move lower lower hex value
	
	call	multiply8x24
	
	
convert4:
	
	MOVFF	RES3, DEC3	    ;move most significant bit to storage
    
	MOVLW	0X0A		
	MOVWF	ARG1L		    ; 10 LOWER
	
	MOVFF	RES3, ARG2HH	    ;move upper upper hex value (most significant)
	MOVFF	RES2, ARG2H	    ;move upper hex value
	MOVFF	RES1, ARG2L	    ;move lower hex value
	MOVFF	RES0, ARG2LL	    ;move lower lower hex value
	
	call	multiply8x24
	
	
	MOVFF	RES3, DEC4	    ;move most significant bit to storage
	

	
multiply16x16:
    
	MOVF ARG1L, W
	MULWF ARG2L ; ARG1L * ARG2L->
	; PRODH:PRODL
	MOVFF PRODH, RES1 ;
	MOVFF PRODL, RES0 ;
	;
	MOVF ARG1H, W
	MULWF ARG2H ; ARG1H * ARG2H->
	; PRODH:PRODL
	MOVFF PRODH, RES3 ;
	MOVFF PRODL, RES2 ;
	;
	MOVF ARG1L, W
	MULWF ARG2H ; ARG1L * ARG2H->
	; PRODH:PRODL
	MOVF PRODL, W ;
	ADDWF RES1, F ; Add cross
	MOVF PRODH, W ; products
	ADDWFC RES2, F ;
	CLRF WREG ;
	ADDWFC RES3, F ;
	;
	MOVF ARG1H, W ;
	MULWF ARG2L ; ARG1H * ARG2L->
	; PRODH:PRODL
	MOVF PRODL, W ;
	ADDWF RES1, F ; Add cross
	MOVF PRODH, W ; products
	ADDWFC RES2, F ;
	CLRF WREG ;
	ADDWFC RES3, F ;
	
	MOVF	RES3, W, A
	MOVFF	RES3, 
	
	return

	
	
multiply8x24:
    
	MOVF ARG1L, W
	MULWF ARG2LL ; ARG1L * ARG2L->
	; PRODH:PRODL
	MOVFF PRODH, RES1 ;
	MOVFF PRODL, RES0 ;
	;
	MOVF ARG1L, W
	MULWF ARG2H ; ARG1H * ARG2H->
	; PRODH:PRODL
	MOVFF PRODH, RES3 ;
	MOVFF PRODL, RES2 ;
	;
	MOVF ARG1L, W
	MULWF ARG2L ; ARG1L * ARG2H->
	; PRODH:PRODL
	MOVF PRODL, W ;
	ADDWF RES1, F ; Add cross
	MOVF PRODH, W ; products
	ADDWFC RES2, F ;
	CLRF WREG ;
	ADDWFC RES3, F ;
	;

	MOVF	RES3, W, A
	
	return


	
ASCII:
	




	
end