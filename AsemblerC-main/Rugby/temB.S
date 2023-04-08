
			.syntax unified
			.text
			.global temB
			.thumb_func

#define		TEMBU	 R0 //0
#define		TEMBD	 R1 //0
#define		BOTONP	 R2 //
#define     BESTADO  R3 //0x01


temB:	
			PUSH 	{LR}  					/* guardamos la direccion de retorno en la pila */
			
			CMP     BOTONP, #32           // 100001 = 21 en HEX
			BEQ     TRYB
			CMP     BOTONP, #64      //PREGUNTA SI ES CONVERSION   0x08
			BEQ     CONVERSION
			CMP     BOTONP, #128      //PREGUNTA SI ES UN PENAL O UN DROP
			BEQ     PENAL
			B       FIN
			
TRYB:       LDR     R8, [TEMBU]
			CMP     R8, #0x05    //PREGUNTA SI ES 5 SI LE SUMA UNO A LAS UNIDADES Y SE VUELVE CERO
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
			STR     R8, [TEMBU]
			B       FIN

INCREME_DEC:
			LDR     R9, [TEMBD] //CARGA LAS DECENAS
			ADD     R9, #0x01   // LE SUMA UNO A LAS DECENAS
			STR     R9,  [TEMBD] // Y LAS GUARDA
			SUB     R8, #0x05   // LE RESTA 5 A LAS UNIDADES PARA CONVERTIR EN 11
			STR     R8, [TEMBU] // LO GUARDA
			B       FIN         
CONVERSION: 
			LDR     R8, [TEMBU]
			CMP     R8, #8    //PREGUNTA SI ES 8 SI LE SUMA UNO A LAS DECENAS Y DOS A LAS UNIDADES
			BEQ     INCREME_DEC2
			CMP     R8, #9
			BEQ     INCREME_DEC2
			ADD     R8, #2
			STR     R8, [TEMBU]
			B		FIN

INCREME_DEC2:
			LDR     R9, [TEMBD] //CARGA LAS DECENAS
			ADD     R9, #0x01   // LE SUMA UNO A LAS DECENAS
			STR     R9, [TEMBD] // Y LAS GUARDA
			SUB     R8, #8      // REINICIA LAS UNIDADES
			STR     R8, [TEMBU] // LO GUARDA
			B       FIN  
			
PENAL:      LDR     R8, [TEMBU]
			CMP     R8, #0x07    //PREGUNTA SI ES 5 SI LE SUMA UNO A LAS DECENAS Y SE VUELVE CERO LAS UNIDADES
			BEQ     INCREME_DEC3
			CMP     R8, #0x08    //PREGUNTA SI ES 6 
			BEQ     INCREME_DEC3
			CMP     R8, #0x09    //PREGUNTA SI ES 7 
			BEQ     INCREME_DEC3
			ADD     R8, #0x03    //SI ES MENOR A 7 SIMPLEMENTE SUMA 3 
			STR     R8, [TEMBU]
			B       FIN

INCREME_DEC3:
			LDR     R9, [TEMBD] //CARGA LAS DECENAS
			ADD     R9, #0x01   // LE SUMA UNO A LAS DECENAS
			STR     R9, [TEMBD] // Y LAS GUARDA
			SUB     R8, #0x07  // LE RESTA 5 A LAS UNIDADES PARA CONVERTIR EN 11
			STR     R8, [TEMBU] // LO GUARDA
			B       FIN  

FIN:		
			POP 	{PC}   				/* retorno   */