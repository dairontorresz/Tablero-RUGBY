
			.syntax unified
			.text
			.global botonStart
			.thumb_func

#define		GPIO_PORTE_DATA_R	 R0

botonStart:	
				PUSH 	{LR}  					/* guardamos la direccion de retorno en la pila */
		
				LDR     R1, [GPIO_PORTE_DATA_R]
				AND     R1, 0x03               //  00 0011
				MOV		R0, R1
				//STR		R2, [GPIO_PORTF_DATA_R] 
	
				POP 	{PC}   				/* retorno   */