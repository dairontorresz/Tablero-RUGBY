		.syntax unified
			.text
			.global visOCHO
			.thumb_func

#define		GPIOE	 R0     //R9
#define		GPIOD	 R1     //R11

visOCHO:	
				PUSH 	{LR}  					/* guardamos la direccion de retorno en la pila */
			
			//LDR 	R1, =CONTA    //CARGA LA DIRECCION DE MEMORIA DE CONTA
            //LDR     R0, [R1]      //LEE LO QUE TIENE CONTA Y LO GUARDA EN R0
			//BL		DISPLAY
				MOV		R3, #0x00     //R3= 0000 0000 
				STR		R3, [GPIOE]      //DESHABILITA EL DISPLAY DESC
				MOV		R3, #0x08     //R3=0000 1000 VISUALIZA LAS UNIDADES
				STR		R3, [GPIOD]     //HABILITA EL DISPLAY DOS (LAS UNIDADES)
			
			    POP		{PC}