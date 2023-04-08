
			.syntax unified
			.text
			.global temA
			.thumb_func

#define		TEMAU	 R0 //0
#define		TEMAD	 R1 //0
#define		BOTONP	 R2 //
#define     BESTADO  R3 //0x01


temA:	
			PUSH 	{LR}  					/* guardamos la direccion de retorno en la pila */
			
			CMP     BOTONP, #0x04     // PREGUNTA SI ES TRY BOTON 0x04
			BEQ     TRYA
			CMP     BOTONP, #0x08      //PREGUNTA SI ES CONVERSION   0x08
			BEQ     CONVERSION
			CMP     BOTONP, #16      //PREGUNTA SI ES UN PENAL O UN DROP
			BEQ     PENAL
			B       FIN
			
TRYA:       LDR     R8, [TEMAU]
			CMP     R8, #0x05    //PREGUNTA SI ES 5 SI LE SUMA UNO A LAS DECENAS Y SE VUELVE CERO LAS UNIDADES
			BEQ     INCREME_DEC
			CMP     R8, #0x06    //PREGUNTA SI ES 6 
			BEQ     INCREME_DEC
			CMP     R8, #0x07    //PREGUNTA SI ES 7 
			BEQ     INCREME_DEC
			CMP     R8, #0x08    //PREGUNTA SI ES 8 
			BEQ     INCREME_DEC
			CMP     R8, #0x09    //PREGUNTA SI ES 9 
			BEQ     INCREME_DEC
			ADD     R8, #0x05    //SI ES MENOR A CUATRO SIMPLEMENTE SUMA 5 
			STR     R8, [TEMAU]
			B       FIN

INCREME_DEC:
			LDR     R9, [TEMAD] //CARGA LAS DECENAS
			ADD     R9, #0x01   // LE SUMA UNO A LAS DECENAS
			STR     R9,  [TEMAD] // Y LAS GUARDA
			SUB     R8, #0x05   // LE RESTA 5 A LAS UNIDADES PARA CONVERTIR EN 11
			STR     R8, [TEMAU] // LO GUARDA
			B       FIN         

CONVERSION: 
			LDR     R8, [TEMAU]
			CMP     R8, #8    //PREGUNTA SI ES 8 SI LE SUMA UNO A LAS DECENAS Y DOS A LAS UNIDADES
			BEQ     INCREME_DEC2
			CMP     R8, #9
			BEQ     INCREME_DEC2
			ADD     R8, #2
			STR     R8, [TEMAU]
			B		FIN

INCREME_DEC2:
			LDR     R9, [TEMAD] //CARGA LAS DECENAS
			ADD     R9, #0x01   // LE SUMA UNO A LAS DECENAS
			STR     R9, [TEMAD] // Y LAS GUARDA
			SUB     R8, #8      // REINICIA LAS UNIDADES
			STR     R8, [TEMAU] // LO GUARDA
			B       FIN  
			
PENAL:      LDR     R8, [TEMAU]
			CMP     R8, #0x07    //PREGUNTA SI ES 5 SI LE SUMA UNO A LAS DECENAS Y SE VUELVE CERO LAS UNIDADES
			BEQ     INCREME_DEC3
			CMP     R8, #0x08    //PREGUNTA SI ES 6 
			BEQ     INCREME_DEC3
			CMP     R8, #0x09    //PREGUNTA SI ES 7 
			BEQ     INCREME_DEC3
			ADD     R8, #0x03    //SI ES MENOR A 7 SIMPLEMENTE SUMA 3 
			STR     R8, [TEMAU]
			B       FIN

INCREME_DEC3:
			LDR     R9, [TEMAD] //CARGA LAS DECENAS
			ADD     R9, #0x01   // LE SUMA UNO A LAS DECENAS
			STR     R9,  [TEMAD] // Y LAS GUARDA
			SUB     R8, #0x07  // LE RESTA 5 A LAS UNIDADES PARA CONVERTIR EN 11
			STR     R8, [TEMAU] // LO GUARDA
			B       FIN  
FIN:		
			POP 	{PC}   				/* retorno   */