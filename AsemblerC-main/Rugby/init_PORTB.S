
			.syntax unified
			.text
			.global init_PORTB
			.thumb_func


init_PORTB:	
			PUSH 	{LR}  					/* guardamos la direccion de retorno en la pila */
		
			LDR		R0, = 0x400FE108 //SYSCTL_RCGC2_R	 
			LDR		R1, [R0]				 	
			ORR		R2, R1, #0x02			
			STR     R2, [R0]				
			NOP																				
			NOP							
			NOP							
					
//			LDR		R0, = 0x40025520//GPIO_LOCK_KEY 		
//			LDR		R1, = 0x4C4F434B		
//			STR		R1, [R0]					
		
			LDR		R0, = 0x40005524//GPIO_PORTB_CR_R
			MOV		R1, #0xFF
			STR		R1, [R0] 	
			
			LDR		R0, = 0x40005528//GPIO_PORTB_AMSEL_R
			MOV		R1, #0x00
			STR		R1, [R0] 	
			
			LDR		R0, = 0x4000552C//GPIO_PORTB_PCTL_R
			MOV		R1, #0x00000000
			STR		R1, [R0] 	

//          GPIO_PORTF_DIR_R
//			B7 B6 B5 B4 B3 B2 B1 B0
//          dp g  f  e  d  c  b  a
//          1  1  1  1  1  1  1  1 = FF
// 		    0 = ENTRADA
//			1 = SALIDA
			LDR		R0, = 0x40005400
			MOV		R1, #0xFF
			STR		R1, [R0] 	


			LDR		R0, = 0x40005420 //GPIO_PORTB_AFSEL_R
			MOV		R1, #0x00
			STR		R1, [R0] 
		
			LDR		R0, = 0x40005510//GPIO_PORTB_PUR_R = 0x00
			MOV		R1, #0x00
			STR		R1, [R0] 
		
			LDR		R0, = 0x4000551C//GPIO_PORTF_DEN_R 
			MOV		R1, #0xFF
			STR		R1, [R0] 
			
			// para leer el puerto B en un registro
			//R12, =GPIO_PORTB_DATA_R
			
			POP 	{PC}   				/* retorno   */