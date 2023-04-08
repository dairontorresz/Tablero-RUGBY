
			.syntax unified
			.text
			.global display
			.thumb_func

#define		GPIOB		R1	

display:	
			PUSH 	{LR}  					/* guardamos la direccion de retorno en la pila */
		
DISP:  		CMP 	R0, #0x00
			BEQ 	SEG0
			CMP 	R0, #0x01
			BEQ 	SEG1
			CMP 	R0, #0x02
			BEQ 	SEG2
			CMP 	R0, #0x03
			BEQ 	SEG3
			CMP 	R0, #0x04
			BEQ 	SEG4
			CMP 	R0, #0x05
			BEQ 	SEG5
			CMP 	R0, #0x06
			BEQ 	SEG6
			CMP 	R0, #0x07
			BEQ 	SEG7
			CMP 	R0, #0x08
			BEQ 	SEG8
			CMP 	R0, #0x09
			BEQ 	SEG9
			CMP 	R0, #0x0A            //para indicar si gana el equipo A
			BEQ 	SEG10
			CMP 	R0, #0x0B            //para indicar si gana el equipo B
			BEQ 	SEG11
			CMP 	R0, #0x0E            //para indicar si gana el equipo B
			BEQ 	SEG12
			MOV		R12, #0xFF
			STR 	R12, [GPIOB]  
			B		FIN		

SEG0:		MOV		R12, #0x40
			STR 	R12, [GPIOB]               
			B		FIN

SEG1:		MOV		R12, #0x79
			STR 	R12, [GPIOB]               
			B		FIN

SEG2:		MOV		R12, #0x24
			STR 	R12, [GPIOB]               
			B		FIN

SEG3:		MOV		R12, #0x30
			STR 	R12, [GPIOB]               
			B		FIN

SEG4:		MOV		R12, #0x19
			STR 	R12, [GPIOB]               
			B		FIN

SEG5:		MOV		R12, #0x12
			STR 	R12, [GPIOB]               
			B		FIN

SEG6:		MOV		R12, #0x02
			STR 	R12, [GPIOB]               
			B		FIN

SEG7:		MOV		R12, #0x78
			STR 	R12, [GPIOB]               
			B		FIN

SEG8:		MOV		R12, #0x00
			STR 	R12, [GPIOB]               
			B		FIN

SEG9:		MOV		R12, #0x10
			STR 	R12, [GPIOB]               
			B		FIN
			
SEG10:		MOV		R12, #0x88    //MANDA A al display si gana el equipo A
			STR 	R12, [GPIOB]               
			B		FIN
			
SEG11:		MOV		R12, #0x83    //MANDA B al display si gana el equipo B
			STR 	R12, [GPIOB]               
			B		FIN

SEG12:		MOV		R12, #0xBF    //MANDA B al display si gana el equipo B
			STR 	R12, [GPIOB]               
			B		FIN
			
FIN:		POP 	{PC}   				/* retorno   */