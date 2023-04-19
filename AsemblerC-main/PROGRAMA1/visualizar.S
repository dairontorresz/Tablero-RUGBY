
			.syntax unified
			.text
			.global visualizar
			.thumb_func

#define		CONTADRS    R0	
#define		GPIOB		R1	
#define		PORTE		R2
#define		PORTD		R3	

visualizar:	
			PUSH 	{LR} 
			
			MOV     R11,#0
			
			LDR     R10,[CONTADRS]
			LDR     R9,[CONTADRS,#0x04]!
			LDR     R7,[CONTADRS,#0x04]!
			LDR     R8,[CONTADRS,#0x04]!
			
LOOPV:     
			MOV     R4, R10
			BL      DISP
			MOV     R4,#0
			STR     R4,[PORTE]  //11 D  9 E
			MOV     R4,#0x80
			STR     R4,[PORTD]
			MOV     R5,#2
			BL      DELAY_MS 
			
			
			MOV     R4, R9
			BL      DISP
			MOV     R4,#0
			STR     R4,[PORTE]  //11 D  9 E
			MOV     R4,#0x40    //0100 0000
			STR     R4,[PORTD]
			MOV     R5,#2
			BL      DELAY_MS  
		 
			MOV     R4, R7
			BL      DISP
			MOV     R4,#0x00
			STR     R4,[PORTD]
			MOV     R4,#0x20
			STR     R4,[PORTE]  //11 D  9 E
			MOV     R5,#2
			BL      DELAY_MS
			
			MOV     R4, R8
			BL      DISP
			MOV     R4,#0x00
			STR     R4,[PORTD]
			MOV     R4,#0x10
			STR     R4,[PORTE]  //11 D  9 E
			MOV     R5,#2
			BL      DELAY_MS 
           
		    ADD     R11,#1
			CMP     R11,#200
			BEQ     FIN
			B       LOOPV
			B       FIN
													
DISP:  		CMP 	R4, #0x00
			BEQ 	SEG0
			CMP 	R4, #0x01
			BEQ 	SEG1
			CMP 	R4, #0x02
			BEQ 	SEG2
			CMP 	R4, #0x03
			BEQ 	SEG3
			CMP 	R4, #0x04
			BEQ 	SEG4
			CMP 	R4, #0x05
			BEQ 	SEG5
			CMP 	R4, #0x06
			BEQ 	SEG6
			CMP 	R4, #0x07
			BEQ 	SEG7
			CMP 	R4, #0x08
			BEQ 	SEG8
			CMP 	R4, #0x09
			BEQ 	SEG9
			MOV		R12, #0xFF
			STR 	R12, [GPIOB]  
			BX		LR		

SEG0:		MOV		R12, #0x40
			STR 	R12, [GPIOB]               
			BX		LR

SEG1:		MOV		R12, #0x79
			STR 	R12, [GPIOB]               
			BX		LR

SEG2:		MOV		R12, #0x24
			STR 	R12, [GPIOB]               
			BX		LR

SEG3:		MOV		R12, #0x30
			STR 	R12, [GPIOB]               
			BX		LR

SEG4:		MOV		R12, #0x19
			STR 	R12, [GPIOB]               
			BX		LR

SEG5:		MOV		R12, #0x12
			STR 	R12, [GPIOB]               
			BX		LR

SEG6:		MOV		R12, #0x02
			STR 	R12, [GPIOB]               
			BX		LR

SEG7:		MOV		R12, #0x78
			STR 	R12, [GPIOB]               
			BX		LR

SEG8:		MOV		R12, #0x00
			STR 	R12, [GPIOB]               
			BX		LR

SEG9:		MOV		R12, #0x10
			STR 	R12, [GPIOB]               
			BX		LR
			
			
DELAY_MS:	MOV		R6, #5333   
			SUBS 	R5, R5, #1  //R5 = R5 - 1               
			BNE 	LOOP_MS     //SI ES MAYOR A CERO VA A LA ETIQUETA Y SI ES NEGATIVO VA AL LR 
			BX  	LR                         
		
LOOP_MS:	SUBS 	R6, R6, #1  //R1 = R1 - 1                
			BNE 	LOOP_MS     //SI ES MAYOR A CERO VA A LA ETIQUETA Y SI ES NEGATIVO VA AL DELAYMS                
			B		DELAY_MS			
					
	
FIN:		POP 	{PC}   				/* retorno   */