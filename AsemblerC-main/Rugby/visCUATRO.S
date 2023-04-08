
			.syntax unified
			.text
			.global visCUATRO
			.thumb_func

#define		GPIOE	 R0     //R9
#define		GPIOD	 R1     //R11

visCUATRO:	
				PUSH 	{LR}  					/* guardamos la direccion de retorno en la pila */
		//		LDR 	R1, =CONTC    //CARGA LA DIRECCION DE MEMORIA DE CONTC
		//		LDR     R0, [R1]      //LEE LO QUE TIENE CONTC Y LO GUARDA EN R0
		//		BL		DISPLAY  
				MOV		R3, #0x00     //R3= 0000 0000 
				STR		R3, [GPIOD]     //DESHABILITA EL DISPLAY ASC
				MOV		R3, #0x10     //R3=01 0000 VISUALIZA LAS UNIDADES DESCENDENTES
				STR		R3, [GPIOE]      //HABILITA EL DISPLAY DOS (LAS UNIDADES)

			    POP		{PC}