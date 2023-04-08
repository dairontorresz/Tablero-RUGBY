
			.syntax unified
			.text
			.global visSEIS
			.thumb_func

#define		GPIOE	 R0     //R9
#define		GPIOD	 R1     //R11

visSEIS:	
				PUSH 	{LR}  					/* guardamos la direccion de retorno en la pila */
			
			//LDR 	R1, =CONTA    //CARGA LA DIRECCION DE MEMORIA DE CONTA
            //LDR     R0, [R1]      //LEE LO QUE TIENE CONTA Y LO GUARDA EN R0
			//BL		DISPLAY
				MOV		R3, #0x00     //R3= 0000 0000 
				STR		R3, [GPIOE]      //DESHABILITA EL DISPLAY DESC
				MOV		R3, #0x02     //R3=0000 0010 VISUALIZA LAS UNIDADES
				STR		R3, [GPIOD]     //HABILITA EL DISPLAY DOS (LAS UNIDADES)
			
			    POP		{PC}