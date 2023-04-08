		    .syntax unified
			.text
			.global visNUEVE
			.thumb_func

#define		GPIOE	 R0     //R9
#define		GPIOD	 R1     //R11
#define		GPIOF	 R2     //R11

visNUEVE:	
				PUSH 	{LR}  					/* guardamos la direccion de retorno en la pila */
			
			//LDR 	R1, =CONTA    //CARGA LA DIRECCION DE MEMORIA DE CONTA
            //LDR     R0, [R1]      //LEE LO QUE TIENE CONTA Y LO GUARDA EN R0
			//BL		DISPLAY
				MOV		R3, #0x00     //R3=0000 1000 VISUALIZA LAS UNIDADES
				STR		R3, [GPIOD]     //HABILITA EL DISPLAY DOS (LAS UNIDADES)
				MOV		R3, #0x00     //R3= 0000 1000 
				STR		R3, [GPIOE]      //DESHABILITA EL DISPLAY DESC
				MOV		R3, #0x10     //R3= 0000 1000 
				STR		R3, [GPIOF]      //DESHABILITA EL DISPLAY DESC
				
			
			    POP		{PC}