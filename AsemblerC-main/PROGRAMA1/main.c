
#include "tm4c123gh6pm.h"

extern void init_PORTB(void);
extern void init_PORTE(void);
extern void init_PORTD(void);
extern void init_PORTF(void);

extern void delay_ms(volatile unsigned long R0);
extern void led_blink(volatile unsigned long *GPIO, int DATO_SEL, int COLORA, int COLORB);
extern int leer(volatile unsigned long *R0);
extern void visDOS(volatile unsigned long *GPIOE,volatile unsigned long *GPIOD);
extern void visUNO(volatile unsigned long *GPIOE,volatile unsigned long *GPIOD);
extern void visTRES(volatile unsigned long *GPIOE,volatile unsigned long *GPIOD);
extern void visCUATRO(volatile unsigned long *GPIOE,volatile unsigned long *GPIOD);

extern void increm(volatile unsigned long *vara,volatile unsigned long *varb,int portF,volatile unsigned long *pulUP);
extern void decrem(volatile unsigned long *varc,volatile unsigned long *vard,int portF,volatile unsigned long *pulDOWN);
extern void display(volatile unsigned long R0,volatile unsigned long *GPIOB);
extern void visualizar(volatile unsigned long *contadores,volatile unsigned long *GPIOB,volatile unsigned long *PUERTOE,volatile unsigned long *PUERTOD);

int main (void)
{	
//-----------DEFINICION DE VARIABLES----------------------------------
	  int portF = 0; //LEE EL VALOR DE LOS PULSADORES
	
		volatile unsigned long vara	= 0; //U ASC
		volatile unsigned long varb	= 0; //D ASC
		volatile unsigned long varc	= 4; //U DESC
		volatile unsigned long vard	= 8; //D DESC
	
		volatile unsigned long pulUP = 1;
	  volatile unsigned long pulDOWN = 4;
	
	  int count = 0;
	  volatile unsigned long contadores[4] = {0,0,0,0};
//----------CONFIGURACION DE PUERTOS--------------------------------
	init_PORTB();
	init_PORTE();
	init_PORTD();
	init_PORTF();
//------------CICLO INFINITO------------------------------------------
	
	while(1)
	{
		contadores[0]=varb;
		contadores[1]=vara;
		contadores[2]=vard;
		contadores[3]=varc;
		visualizar(&contadores,&GPIO_PORTB_DATA_R,&GPIO_PORTE_DATA_R,&GPIO_PORTD_DATA_R);
		/*
		count=0;
			while(count<400){ //vusializa 200 veces el mismo numero
				display(varb,&GPIO_PORTB_DATA_R);
				visUNO(&GPIO_PORTE_DATA_R,&GPIO_PORTD_DATA_R);//VISUALIZA 
				delay_ms(2); 	//ESPERA
				
				display(vara,&GPIO_PORTB_DATA_R);
				visDOS(&GPIO_PORTE_DATA_R,&GPIO_PORTD_DATA_R);
				delay_ms(2);
				
				display(vard,&GPIO_PORTB_DATA_R);
				visTRES(&GPIO_PORTE_DATA_R,&GPIO_PORTD_DATA_R);
				delay_ms(2);
				
				display(varc,&GPIO_PORTB_DATA_R);
				visCUATRO(&GPIO_PORTE_DATA_R,&GPIO_PORTD_DATA_R);
				delay_ms(2);
				count=count+1;
			}	*/
		portF = leer(&GPIO_PORTF_DATA_R);
		increm(&vara,&varb,portF,&pulUP);
	  portF = leer(&GPIO_PORTF_DATA_R);
		decrem(&varc,&vard,portF,&pulDOWN);
		

	}
}
