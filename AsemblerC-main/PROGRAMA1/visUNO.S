
			.syntax unified
			.text
			.global visUNO
			.thumb_func

#define		GPIOE	 R0     //R9
#define		GPIOD	 R1     //R11

visUNO:	
				PUSH 	{LR}  					/* guardamos la direccion de retorno en la pila */
		
			//MOV		R7, #0        //R7=0  REINICIA EL TIEMPO DE MUESTRA DE CADA DISP
			//MOV		R8,	LR	      //R8=LR

			
			//	LDR 	R1, =CONTB    //CARGA LA DIRECCION DE MEMORIA DE CONTB
			//	LDR     R0, [R1]      //LEE LO QUE TIENE CONTB Y LO GUARDA EN R0
			//	BL		DISPLAY       //R0 = CONTADOR DOS (DECENAS)
				MOV		R3, #0x00     //R3= 0000 0000 
				STR		R3, [GPIOE]      //DESHABILITA EL DISPLAY DESC
				MOV		R3, #0x80     //R3= 1000 0000 VISUALIZA LAS DECENAS
				STR		R3, [GPIOD]     //HABILITA EL DISPLAY UNO (LAS DECENAS)

			    POP		{PC}