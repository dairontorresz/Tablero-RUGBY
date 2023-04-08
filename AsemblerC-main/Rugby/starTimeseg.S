
			.syntax unified
			.text
			.global starTimeseg
			.thumb_func

#define		TIEMPO	 R0  //TIEMPO[DMIN, UMIN, DSEG, USEG]
#define     RELOJ    R1  //RELOJ[DMIN, UMIN, DSEG, USEG]
#define     BSTART   R2
#define     CONTAR   R3  //BOTON PARA GUARDAR EL ESTADO DEL CONTADOR POR DEFECTO DEBE SER CERO
            
starTimeseg:	  
			PUSH 	{LR}  					
			
			CMP     BSTART, #0x01     
			BEQ     CARGAP1  // ENPIEZA A INCREMENTAR EL TIEMPO
			CMP     BSTART, #0x02      
			BEQ     CARGAP2  // 
			
NEXT:       LDR     R5, [CONTAR]
            CMP     R5, #2
			BEQ     INCREMENTAR
			CMP     R5, #1
			BEQ     STOP
			B       STOP

CARGAP1:    // MUEVE EL ESTADO DE 1 AL BOTON CONTAR PARA QUE NO VUELVA A ENTRAR ACA Y LEA EL ESTADO INFINITAMENTE
			LDR     R6, [CONTAR]
			MOV     R5, #1
			STR     R5, [CONTAR]
			// MUEVE EL TIEMPO AL RELOJ
			LDR     R6, [TIEMPO]
			LDR     R7, [RELOJ]
			MOV     R7, R6     //MUEVE TIEMPO A RELOJ
			STR     R7, [RELOJ] // GUARDA RELOJ
			MOV     R6, #0  //PARA INICIALIZAR TIEMPO
			STR     R6, [TIEMPO]
			//-------------
			LDR     R6, [TIEMPO,#0x04]!
			LDR     R7, [RELOJ,#0x04]!
			MOV     R7, R6     //MUEVE TIEMPO A RELOJ
			STR     R7, [RELOJ] // GUARDA RELOJ
			MOV     R6, #0  //PARA INICIALIZAR TIEMPO
			STR     R6, [TIEMPO]
			//-------------
			LDR     R6, [TIEMPO,#0x04]!
			LDR     R7, [RELOJ,#0x04]!
			MOV     R7, R6     //MUEVE TIEMPO A RELOJ
			STR     R7, [RELOJ] // GUARDA RELOJ
			MOV     R6, #0  //PARA INICIALIZAR TIEMPO
			STR     R6, [TIEMPO]
			//--------------
			LDR     R6, [TIEMPO,#0x04]!
			LDR     R7, [RELOJ,#0x04]!
			MOV     R7, R6     //MUEVE TIEMPO A RELOJ
			STR     R7, [RELOJ] // GUARDA RELOJ
			MOV     R6, #0  //PARA INICIALIZAR TIEMPO
			STR     R6, [TIEMPO]
			B       NEXT
CARGAP2:    
			LDR     R6, [CONTAR]
			MOV     R5, #2
			STR     R5, [CONTAR]
			B       NEXT
			
INCREMENTAR:  			
			LDR     R6, [TIEMPO,#0x0C]!
			ADD     R6, #0x01
			STR     R6, [TIEMPO]

CONTINUAR:	
			CMP     R6, #10
			BEQ     RESET_USEG
			B       FIN
RESET_USEG:	
			LDR     R6, [TIEMPO]   //C
			MOV     R7, #0
			STR     R7, [TIEMPO]  
		 //AUMENTA LAS UNIDADES DE SEGUNDOS
			LDR     R6, [TIEMPO,#-0x04]!   //8
			ADD     R6, #1
			STR     R6, [TIEMPO]
			CMP     R6, #6                //6   ACA SE DISMINUYE PARA TENER MINUTOS MAS CORTOS POR EJEMPLO 2 PRA QUE CUENTE 20 SEGUNDOS Y AUMENTE LOS MINUTOS
			BEQ     RESET_UMIN
			B       FIN
RESET_UMIN:
			LDR     R6, [TIEMPO]//RESETEA LOS SEGUNDOS
			MOV     R7, #0
			STR     R7, [TIEMPO]
			//AUMENTA LAS UNIDADES DE MINUTOS
			LDR     R6, [TIEMPO,#-0x04]!
			ADD     R6, #1
			STR     R6, [TIEMPO] 
			CMP     R6, #10       
			BEQ     RESET_DMIN
			B       FIN
RESET_DMIN:	
            LDR     R6, [TIEMPO,#0x00]!//RESETEA LOS SEGUNDOS
			MOV     R7, #0
			STR     R7, [TIEMPO]
			//AUMENTA LAS DECENAS DE MINUTOS
			LDR     R6, [TIEMPO,#-0x04]!
			ADD     R6, #1
			STR     R6, [TIEMPO]  
			CMP     R6, #10
			BEQ     REIN_TOTAL   // EN CASO DE QUE LLEGUE A 99:99 MINUTOS
			B       FIN
REIN_TOTAL:  
            LDR     R6, [TIEMPO]
			MOV     R7, #0
			STR     R7, [TIEMPO]
			LDR     R6, [TIEMPO,#4]!
			MOV     R7, #0
			STR     R7, [TIEMPO]
			LDR     R6, [TIEMPO,#4]!
			MOV     R7, #0
			STR     R7, [TIEMPO]
			LDR     R6, [TIEMPO,#4]!
			MOV     R7, #0
			STR     R7, [TIEMPO]
			B       FIN
			
STOP:		B       FIN	

FIN:		
			POP 	{PC}  

