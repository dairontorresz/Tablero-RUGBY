
			.syntax unified
			.text
			.global init_PORTC
			.thumb_func


init_PORTC:	
			PUSH 	{LR}  					/* guardamos la direccion de retorno en la pila */
		
			LDR		R0, = 0x400FE108 //SYSCTL_RCGC2_R	 
			LDR		R1, [R0]				 	
			ORR		R2, R1, #0x04			
			STR     R2, [R0]				
			NOP																				
			NOP							
			NOP							
					
//			LDR		R0, = 0x40025520//GPIO_LOCK_KEY 		
//			LDR		R1, = 0x4C4F434B		
//			STR		R1, [R0]					
		
			LDR		R0, = 0x40006524//GPIO_PORTC_CR_R
			MOV		R1, #0xF0
			STR		R1, [R0] 	
			
			LDR		R0, = 0x40006528//GPIO_PORTC_AMSEL_R
			MOV		R1, #0x00
			STR		R1, [R0] 	
			
			LDR		R0, = 0x4000652C//GPIO_PORTC_PCTL_R
			MOV		R1, #0x00000000
			STR		R1, [R0] 	

//          GPIO_PORTA_DIR_R
//			C4	C3	C2	C1	
//          Q8  Q7  Q6  Q5
//          1   1   1   1    0 = 0F
// 		    0 = ENTRADA
//			1 = SALIDA
			LDR		R0, = 0x40006400
			MOV		R1, #0x0F
			STR		R1, [R0] 	


			LDR		R0, = 0x40006420 //GPIO_PORTC_AFSEL_R
			MOV		R1, #0x00
			STR		R1, [R0] 
		
			LDR		R0, = 0x40006510//GPIO_PORTC_PUR_R = 0x00
			MOV		R1, #0x00
			STR		R1, [R0] 
		
			LDR		R0, = 0x4000651C//GPIO_PORTC_DEN_R 
			MOV		R1, #0x1F
			STR		R1, [R0] 
			
			// para leer el puerto C en un registro
			//R12, =GPIO_PORTC_DATA_R
			
			POP 	{PC}   				/* retorno   */