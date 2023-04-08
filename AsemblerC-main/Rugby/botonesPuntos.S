
			.syntax unified
			.text
			.global botonesPuntos
			.thumb_func

#define		GPIO_PORTA_DATA_R	 R0

botonesPuntos:	
				PUSH 	{LR}  					/* guardamos la direccion de retorno en la pila */
		
				LDR     R1, [GPIO_PORTA_DATA_R]
				AND     R1, 0xFE               //A0 SIEMPRE ESTA EN 1
				MOV		R0, R1
				//STR		R2, [GPIO_PORTA_DATA_R] 
	
				POP 	{PC}   				/* retorno   */
			