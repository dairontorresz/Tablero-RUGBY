
			.syntax unified
			.text
			.global init_PORTF
			.thumb_func


init_PORTF:	
			PUSH 	{LR}  					/* guardamos la direccion de retorno en la pila */
		
			LDR		R0, = 0x400FE108 //SYSCTL_RCGC2_R	 
			LDR		R1, [R0]				 	
			ORR		R2, R1, #0x20			
			STR     R2, [R0]				
			NOP																				
			NOP							
			NOP							
					
			LDR		R0, = 0x40025520//GPIO_LOCK_KEY 		
			LDR		R1, = 0x4C4F434B		
			STR		R1, [R0]					
		
			LDR		R0, = 0x40025524//GPIO_PORTF_CR_R
			MOV		R1, #0xFF
			STR		R1, [R0] 	
			
			LDR		R0, = 0x40025528//GPIO_PORTF_AMSEL_R
			MOV		R1, #0x00
			STR		R1, [R0] 	
			
			LDR		R0, = 0x4002552C//GPIO_PORTF_PCTL_R
			MOV		R1, #0x00000000
			STR		R1, [R0] 	

//          GPIO_PORTF_DIR_R
//			F4	F3	F2	F1	F0
//          SW1 G   B   R   SW2
//              P1  P2  P3  P4
//          1   0   0   0    0 = 10
// 		    0 = ENTRADA
//			1 = SALIDA
			LDR		R0, = 0x40025400
			MOV		R1, #0x10
			STR		R1, [R0] 	


			LDR		R0, = 0x40025420 //GPIO_PORTF_AFSEL_R
			MOV		R1, #0x00
			STR		R1, [R0] 
		
			LDR		R0, = 0x40025510//GPIO_PORTF_PUR_R = 0x00
			MOV		R1, #0x00
			STR		R1, [R0] 
		
			LDR		R0, = 0x4002551C//GPIO_PORTF_DEN_R 
			MOV		R1, #0x1F
			STR		R1, [R0] 
			
			// para leer el puerto f en un registro
			//R12, =GPIO_PORTF_DATA_R
			
			POP 	{PC}   				/* retorno   */