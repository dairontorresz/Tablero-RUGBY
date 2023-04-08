
			.syntax unified
			.text
			.global visSIETE
			.thumb_func

#define		GPIOE	 R0     //R9
#define		GPIOD	 R1     //R11

visSIETE:	
				PUSH 	{LR}  					/* guardamos la direccion de retorno en la pila */
		//		LDR 	R1, =CONTC    //CARGA LA DIRECCION DE MEMORIA DE CONTC
		//		LDR     R0, [R1]      //LEE LO QUE TIENE CONTC Y LO GUARDA EN R0
		//		BL		DISPLAY  
				MOV		R3, #0x00     //R3= 0000 0000 
				STR		R3, [GPIOE]     //DESHABILITA EL DISPLAY ASC
				MOV		R3, #0x04     //R3=00 0100 VISUALIZA LAS UNIDADES DESCENDENTES
				STR		R3, [GPIOD]      //HABILITA EL DISPLAY DOS (LAS UNIDADES)

			    POP		{PC}