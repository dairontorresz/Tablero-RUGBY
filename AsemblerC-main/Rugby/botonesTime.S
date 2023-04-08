
			.syntax unified
			.text
			.global botonesTime
			.thumb_func

#define		GPIO_PORTF_DATA_R	 R0

botonesTime:	
				PUSH 	{LR}  					/* guardamos la direccion de retorno en la pila */
		
				LDR     R1, [GPIO_PORTF_DATA_R]
				AND     R1, 0x0F               //A0 SIEMPRE ESTA EN 1
				MOV		R0, R1
				//STR		R2, [GPIO_PORTF_DATA_R] 
	
				POP 	{PC}   				/* retorno   */