
			.syntax unified
			.text
			.global visTRES
			.thumb_func

#define		GPIOE	 R0     //R9
#define		GPIOD	 R1     //R11

visTRES:	
				PUSH 	{LR}  					/* guardamos la direccion de retorno en la pila */
			
			//	LDR 	R1, =CONTD    //CARGA LA DIRECCION DE MEMORIA DE CONTD
			//	LDR     R0, [R1]      //LEE LO QUE TIENE CONTD Y LO GUARDA EN R0
			//	BL		DISPLAY       //R0 = CONTADOR DOS (DECENAS)
				MOV		R3, #0x00     //R3= 0000 0000 
				STR		R3, [GPIOD]     //DESHABILITA EL DISPLAY ASC
				MOV		R3, #0x20     //R3= 10 0000 VISUALIZA LAS DECENAS DESCENDENTES
				STR		R3, [GPIOE]      //HABILITA EL DISPLAY UNO (LAS DECENAS)
				
			    POP		{PC}