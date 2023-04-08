
			.syntax unified
			.text
			.global init_PORTD
			.thumb_func


init_PORTD:	
			PUSH 	{LR}  					/* guardamos la direccion de retorno en la pila */
		
			LDR		R0, = 0x400FE108 //SYSCTL_RCGC2_R	 
			LDR		R1, [R0]				 	
			ORR		R2, R1, #0x08			
			STR     R2, [R0]				
			NOP																				
			NOP							
			NOP							
					
			LDR		R0, = 0x40007520//GPIO_LOCK_KEY 		
			LDR		R1, = 0x4C4F434B		
			STR		R1, [R0]					
		
			LDR		R0, = 0x40007524//GPIO_PORTD_CR_R
			MOV		R1, #0xFF
			STR		R1, [R0] 	
			
			LDR		R0, = 0x40007528//GPIO_PORTD_AMSEL_R
			MOV		R1, #0x00
			STR		R1, [R0] 	
			
			LDR		R0, = 0x4000752C//GPIO_PORTD_PCTL_R
			MOV		R1, #0x00000000
			STR		R1, [R0] 	

//          GPIO_PORTD_DIR_R
//			D7   D6   D5  D4	D3	D2	D1	D0
//          Q1   Q2   XX  XX    Q8  Q7  Q6  Q5
//          1    1    0   0     1   1   1   1  = CF
// 		    0 = ENTRADA
//			1 = SALIDA
			LDR		R0, = 0x40007400
			MOV		R1, #0xCF
			STR		R1, [R0] 	


			LDR		R0, = 0x40007420 //GPIO_PORTD_AFSEL_R
			MOV		R1, #0x00
			STR		R1, [R0] 
		
			LDR		R0, = 0x40007510//GPIO_PORTD_PUR_R = 0x00
			MOV		R1, #0x00
			STR		R1, [R0] 
		
			LDR		R0, = 0x4000751C//GPIO_PORTD_DEN_R 
			MOV		R1, #0xFF
			STR		R1, [R0] 
			
			// para leer el puerto D en un registro
			//R12, =GPIO_PORTD_DATA_R
			
			POP 	{PC}   				/* retorno   */