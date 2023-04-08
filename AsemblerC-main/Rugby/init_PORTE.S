
			.syntax unified
			.text
			.global init_PORTE
			.thumb_func


init_PORTE:	
			PUSH 	{LR}  					/* guardamos la direccion de retorno en la pila */
		
			LDR		R0, = 0x400FE108 //SYSCTL_RCGC2_R	 
			LDR		R1, [R0]				 	
			ORR		R2, R1, #0x10			
			STR     R2, [R0]				
			NOP																				
			NOP							
			NOP							
					
//			LDR		R0, = 0x40025520//GPIO_LOCK_KEY 		
//			LDR		R1, = 0x4C4F434B		
//			STR		R1, [R0]					
		
			LDR		R0, = 0x40024524//GPIO_PORTE_CR_R
			MOV		R1, #0xFF
			STR		R1, [R0] 	
			
			LDR		R0, = 0x40024528//GPIO_PORTE_AMSEL_R
			MOV		R1, #0x00
			STR		R1, [R0] 	
			
			LDR		R0, = 0x4002452C//GPIO_PORTE_PCTL_R
			MOV		R1, #0x00000000
			STR		R1, [R0] 	

//          GPIO_PORTE_DIR_R
//			E5  E4	E3	E2	E1	   E0
//          HD3 HD4 XX  XX  LED10  LED9 
//          Q3  Q4
//          1   1   1   0    0     0 = 30
// 		    0 = ENTRADA
//			1 = SALIDA
			LDR		R0, = 0x40024400
			MOV		R1, #0x38
			STR		R1, [R0] 	


			LDR		R0, = 0x40024420 //GPIO_PORTE_AFSEL_R
			MOV		R1, #0x00
			STR		R1, [R0] 
		
			LDR		R0, = 0x40024510//GPIO_PORTE_PUR_R = 0x00
			MOV		R1, #0x00
			STR		R1, [R0] 
		
			LDR		R0, = 0x4002451C//GPIO_PORTE_DEN_R  PE5,PE4,PE1,PE0
			MOV		R1, #0x33
			STR		R1, [R0] 
			
			// para leer el puerto E en un registro
			//R12, =GPIO_PORTE_DATA_R
			
			POP 	{PC}   				/* retorno   */