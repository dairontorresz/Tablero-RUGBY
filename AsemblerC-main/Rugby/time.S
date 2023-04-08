
			.syntax unified
			.text
			.global time
			.thumb_func

//#define		UMIN	 R0 
//#define		DMIN	 R1 
#define		TIEMPO	 R0  //TIEMPO[DMIN, UMIN, DSEG, USEG]
#define		BOTONT	 R1 

time:	
			PUSH 	{LR}  					
			
			CMP     BOTONT, #0x02     
			BEQ     SUMDEC
			CMP     BOTONT, #0x01      
			BEQ     SUMUNI
			CMP     BOTONT, #0x04      
			BEQ     SUMDECSEG
			CMP     BOTONT, #0x08      
			BEQ     SUMUNISEG
			B       FIN
			
SUMUNI:     LDR     R8, [TIEMPO]
			CMP     R8, #0x09    
			BEQ     RESETUNI
			ADD     R8, #0x01    
			STR     R8, [TIEMPO]
			B       FIN

RESETUNI:
			MOV     R8, #0x00   
			STR     R8, [TIEMPO] 
			B       FIN         

SUMDEC: 
			LDR     R9, [TIEMPO,0x04]!
			CMP     R9, #9    
			BEQ     RESETDEC
			ADD     R9, #1
			STR     R9, [TIEMPO]
			B		FIN

RESETDEC:
			MOV     R9, #0      
			STR     R9, [TIEMPO] 
			B       FIN  
SUMDECSEG:  
			//LDR     R4, =TIEMPO   //DECENAS SEG
			LDR     R10, [TIEMPO,0x08]!
			CMP     R10, #9    
			BEQ     RESETDECSEG
			ADD     R10, #1
			STR     R10, [TIEMPO]
			B		FIN
RESETDECSEG:
			MOV     R10, #0      
			STR     R10, [TIEMPO] 
			B       FIN 
SUMUNISEG:  
			LDR     R11, [TIEMPO,0x0C]!  // R11 = *(TIEMPO+4); TIEMPO+=4 
			CMP     R11, #9    
			BEQ     RESETUNISEG
			ADD     R11, #1
			STR     R11, [TIEMPO]
			B		FIN
RESETUNISEG:
			MOV     R11, #0      
			STR     R11, [TIEMPO]
			B       FIN 
FIN:		
			POP 	{PC}  

