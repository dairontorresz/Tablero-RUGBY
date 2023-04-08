
			.syntax unified
			.text
			.global init_PORTA
			.thumb_func


init_PORTA:	
			PUSH 	{LR}  					/* guardamos la direccion de retorno en la pila */
		
			LDR		R0, = 0x400FE108 //SYSCTL_RCGC2_R	 
			LDR		R1, [R0]				 	
			ORR		R2, R1, #0x01			
			STR     R2, [R0]				
			NOP																				
			NOP							
			NOP							
					
		//	LDR		R0, = 0x40004520//GPIO_LOCK_KEY 		
		//	LDR		R1, = 0x4C4F434B		
		//	STR		R1, [R0]					
		
			LDR		R0, = 0x40004524//GPIO_PORTA_CR_R
			MOV		R1, #0xFC
			STR		R1, [R0] 	
			
			LDR		R0, = 0x40004528//GPIO_PORTA_AMSEL_R
			MOV		R1, #0x00
			STR		R1, [R0] 	
			
			LDR		R0, = 0x4000452C//GPIO_PORTA_PCTL_R
			MOV		R1, #0x00000000
			STR		R1, [R0] 	

//          GPIO_PORTA_DIR_R
//			A7  A6	A5	A4	A3	A2  A1  A0
//          P1  P2  P3  P4  P5  P6  XX  XX
//          0   0   0   0    0   0   0   0 = 00   EL A0 SIEMPRE SE MANTIENE INTERNAMENTE EN 1
// 		    0 = ENTRADA
//			1 = SALIDA
			LDR		R0, = 0x40004400
			MOV		R1, #0x00
			STR		R1, [R0] 	


			LDR		R0, = 0x40004420 //GPIO_PORTA_AFSEL_R
			MOV		R1, #0x00
			STR		R1, [R0] 
		
			LDR		R0, = 0x40004510//GPIO_PORTA_PUR_R = 0x00
			MOV		R1, #0x00
			STR		R1, [R0] 
		
			LDR		R0, = 0x4000451C//GPIO_PORTA_DEN_R 
			MOV		R1, #0xFF
			STR		R1, [R0] 
			
			// para leer el puerto A en un registro
			//R12, =GPIO_PORTA_DATA_R
			
			POP 	{PC}   				/* retorno   */