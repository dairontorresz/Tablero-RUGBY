
			.syntax unified
			.text
			.global suma
			.thumb_func

#define		VARA	 R0
#define		VARB	 R1

suma:	
			PUSH 	{LR}  					/* guardamos la direccion de retorno en la pila */
		
			//LDR     R1, [GPIO_PORTF_DATA_R]
		    //AND     R1, 0x0F
			//MOV		R0, R1
			//STR		R2, [GPIO_PORTF_DATA_R] 
			
			//LDR     R10, VARA
			LDR     R10, [VARA]
			ADD     R10, #1
			STR     R10, [VARA]
			
			LDR     R11, [VARB]
			ADD     R11, #1
			STR     R11, [VARB]
			
	
			POP 	{PC}   				/* retorno   */
			