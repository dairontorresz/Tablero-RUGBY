
			.syntax unified
			.text
			.global finPartido
			.thumb_func

#define		TIEMPO	  R0  //TIEMPO[DMIN, UMIN, DSEG, USEG]
#define     RELOJ     R1  //RELOJ[DMIN, UMIN, DSEG, USEG]
#define     CONTAR    R2  //BOTON PARA GUARDAR EL ESTADO DEL CONTADOR, POR DEFECTO DEBE SER CERO
#define     V_PUNTAJE R3  // TRAE LOS PUNTAJES DE LOS EQUIPOS V=[temAd,temAu,temBd,temBu]
            
finPartido:	  
			PUSH 	{LR} 
			
			LDR     R5, [CONTAR]
            CMP     R5, #2
			BEQ     INCREMENTAR
			CMP     R5, #0
			BEQ     STOP
			B       STOP

INCREMENTAR: 
          /*  LDR     R6, [CONTAR]  //SI SON IGUALES SE DETIENE EL INCREMENTO hace de boton stop 
			MOV     R5, #0
			STR     R5, [CONTAR]*/
			
			B       COMP       // VA A COMPARAR SI YA SE LLEGO AL MAXIMO DEL TIEMPO 
			
CONTINUAR:	B       FIN
			
STOP:		
			B       FIN	
// compara si llega al tiempo maximo (fin del partido)
COMP:		LDR     R12, [TIEMPO,#0x0C]! //COMPARA SI TIME[3] ES IGUAL A RELOJ[3]
			LDR     R11, [RELOJ,#0x0C]! 
			
          	LDR     R10, [TIEMPO,#-0x04]! // TIEMPO = C-4  = 8
			LDR     R9, [RELOJ,#-0x04]!	
			
			LDR     R8, [TIEMPO,#-0x04]! // TIEMPO = 8-4  = 4
			LDR     R7, [RELOJ,#-0x04]!	
			
			LDR     R6, [TIEMPO,#-0x04]! // TIEMPO = 4-4  = 0
			LDR     R5, [RELOJ,#-0x04]!		
			
			CMP     R12,R11            // COMPARA SI LAS UNIDADES DE SEGUNDOS DEL TIEMPO SON IGUALES 
			BEQ     COMP_UMIN   
			B       CONTINUAR
			
COMP_UMIN:  CMP     R10,R9             // COMPARA SI LAS DECENAS DE SEGUNDOS DEL TIEMPO SON IGUALES 
			BEQ     COMP_DSEG     
			B       CONTINUAR

COMP_DSEG:  CMP     R8,R7             // COMPARA SI LAS UNIDADES DE MINUTOS DEL TIEMPO SON IGUALES 
			BEQ     COMP_USEG
			B       CONTINUAR

COMP_USEG:  CMP     R6,R5            // COMPARA SI LAS DECENAS DE MINUTOS DEL TIEMPO SON IGUALES 
			BEQ     FIN_PARTIDO
			B       CONTINUAR

FIN_PARTIDO: 

            LDR     R6, [V_PUNTAJE]
			LDR     R5, [V_PUNTAJE,#0x04]!
			LDR     R4, [V_PUNTAJE,#0x04]!
			LDR     R9, [V_PUNTAJE,#0x04]!
			
			MOV     R7, #10
		    MLA     R10,R6,R7,R5   //R10 = (R6*R7)+R5   Ej: 54     EQUIPO A
			MLA     R11,R4,R7,R9   //R11 = (R4*R7)+R9   Ej: 54     EQUIPO B
			
			SUBS    R12,R10,R11    //R12 = R10 - R11
			BEQ     IGUALES        // SI DA CERO SON IGUALES
			BMI     B_MAYOR        // SI DA NEGATIVO  ES PORQUE B ES MAYOR
			B       A_MAYOR        // DI DA POSITIVO (NO SON LAS ANTERIORES)  ES PORQUE A ES MAYOR


IGUALES:	LDR     R8, [TIEMPO,#-0x04]!
			MOV     R7, #0                         // TIEMPO[3]
			STR     R7, [TIEMPO]
			LDR     R8, [TIEMPO,#-0x04]!
			MOV     R7, #0                         // TIEMPO[2]
			STR     R7, [TIEMPO]
			LDR     R8, [TIEMPO,#-0x04]! 
			MOV     R7, #0x0E                      // TIEMPO[1]
			STR     R7, [TIEMPO]
			LDR     R8, [TIEMPO,#-0x04]!
			MOV     R7, #0x00                      // TIEMPO[0]
			STR     R7, [TIEMPO]
			
			LDR     R6, [CONTAR]  //SI SON IGUALES SE DETIENE EL INCREMENTO hace de boton stop 
			MOV     R5, #0
			STR     R5, [CONTAR]
            B       FIN
			
B_MAYOR:	LDR     R8, [TIEMPO,#-0x04]!
			MOV     R7, #0                         // TIEMPO[3]
			STR     R7, [TIEMPO]
			LDR     R8, [TIEMPO,#-0x04]!
			MOV     R7, #0                         // TIEMPO[2]
			STR     R7, [TIEMPO]
			LDR     R8, [TIEMPO,#-0x04]! 
			MOV     R7, #0x0B                      // TIEMPO[1]
			STR     R7, [TIEMPO]
			LDR     R8, [TIEMPO,#-0x04]!
			MOV     R7, #0x00                      // TIEMPO[0]
			STR     R7, [TIEMPO]
			
			LDR     R6, [CONTAR]  //SI SON IGUALES SE DETIENE EL INCREMENTO hace de boton stop 
			MOV     R5, #0
			STR     R5, [CONTAR]
            B       FIN	

A_MAYOR:	LDR     R8, [TIEMPO,#-0x04]!
			MOV     R7, #0                         // TIEMPO[3]
			STR     R7, [TIEMPO]
			LDR     R8, [TIEMPO,#-0x04]!
			MOV     R7, #0                         // TIEMPO[2]
			STR     R7, [TIEMPO]
			LDR     R8, [TIEMPO,#-0x04]! 
			MOV     R7, #0x0A                      // TIEMPO[1]
			STR     R7, [TIEMPO]
			LDR     R8, [TIEMPO,#-0x04]!
			MOV     R7, #0x00                      // TIEMPO[0]
			STR     R7, [TIEMPO]
			
			LDR     R6, [CONTAR]  //SI SON IGUALES SE DETIENE EL INCREMENTO hace de boton stop 
			MOV     R5, #0
			STR     R5, [CONTAR]
            B       FIN	
						
FIN:		

			POP 	{PC}  