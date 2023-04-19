
#include "tm4c123gh6pm.h"

extern void init_PORTA(void);
extern void init_PORTB(void);
//extern void init_PORTC(void);
extern void init_PORTE(void);
extern void init_PORTD(void);
extern void init_PORTF(void);

extern void display(volatile unsigned long R0,volatile unsigned long *GPIOB);
extern void delay_ms(volatile unsigned long R0);
extern int botonesPuntos(volatile unsigned long *R0);
extern int botonesTime(volatile unsigned long *R0);
extern int botonStart(volatile unsigned long *R0);

extern void temA(volatile unsigned long *temAu,volatile unsigned long *temAd,int botonP);
extern void temB(volatile unsigned long *temBu,volatile unsigned long *temBd,int botonP);
extern void time(volatile unsigned long *tiempo,int botonT);
extern void starTime(volatile unsigned long *tiempo,volatile unsigned long *reloj, volatile unsigned long *Btodo, volatile unsigned long *relojdos);
extern void starTimeseg(volatile unsigned long *tiempo,volatile unsigned long *reloj,int bStart, volatile unsigned long *contar);
//-----------------prueba--------------------------
extern void incre_tiemp(volatile unsigned long *tiempodos,volatile unsigned long *reloj,int bStart, volatile unsigned long *contar);
//----------------------------------------------------
extern void finPartido(volatile unsigned long *tiempo,volatile unsigned long *reloj,volatile unsigned long *contar,volatile unsigned long *puntajeEqipos);
extern void finPtiempo(volatile unsigned long *tiempo,volatile unsigned long *reloj,volatile unsigned long *contar,volatile unsigned long *puntajeEqipos);

extern void visUNO(volatile unsigned long *GPIOE,volatile unsigned long *GPIOD,volatile unsigned long *GPIOF);
extern void visDOS(volatile unsigned long *GPIOE,volatile unsigned long *GPIOD);
extern void visTRES(volatile unsigned long *GPIOE,volatile unsigned long *GPIOD);
extern void visCUATRO(volatile unsigned long *GPIOE,volatile unsigned long *GPIOD);
extern void visCINCO(volatile unsigned long *GPIOE,volatile unsigned long *GPIOD);
extern void visSEIS(volatile unsigned long *GPIOE,volatile unsigned long *GPIOD);
extern void visSIETE(volatile unsigned long *GPIOE,volatile unsigned long *GPIOD);
extern void visOCHO(volatile unsigned long *GPIOE,volatile unsigned long *GPIOD);
extern void visNUEVE(volatile unsigned long *GPIOE,volatile unsigned long *GPIOD,volatile unsigned long *GPIOF);

int main (void)
{	
//-----------DEFINICION DE VARIABLES--------------------------------
	int contador = 0;   //CONTADOR DE DISPLAY
	int contador1 = 0;   //CONTADOR DE DISPLAY
	int botonP = 0;     //GUARDA LOS BOTONES QUE SE PULSARON PARA LOS PUNTOS (PUERTO A)
	int botonT = 0;     //GUARDA LOS BOTONES PULSADOS PARA EL TIEMPO (PUERTO F)
	int bStart = 0;     //boton start para que empiece a correr el tiempo del reloj
//	volatile unsigned long uMin = 0;
//	volatile unsigned long dMin = 0;
//	volatile unsigned long uSeg = 0;
//	volatile unsigned long dSeg = 0;
	volatile unsigned long tiempo[4]={0,0,0,0};    //dMin[0] uMin[1] dSeg[2]  uSeg[3] ->GUARDA EL TIEMPO MAXIMO DEL PARTIDO
	volatile unsigned long reloj[4]={0,0,0,0};    //dMin[0] uMin[1] dSeg[2]  uSeg[3] ->cuenta hasta el tiempo maximo
	volatile unsigned long relojdos[4]={0,0,0,0};    //dMin[0] uMin[1] dSeg[2]  uSeg[3] ->cuenta hasta el tiempo maximo
	volatile unsigned long contar=0;     //mantiene el estado del boton bStart
	volatile unsigned long Btodo[2]={0,0};     //mantiene el estado del boton bStart
	//----------intento para sumar dos tiempod de 40 minutos---------------
	volatile unsigned long tiempodos[4]={0,0,0,0};    //dMin[0] uMin[1] dSeg[2]  uSeg[3] ->GUARDA EL TIEMPO MAXIMO DEL PARTIDO
	//---------------------------------------------------------------------
	volatile unsigned long temAu	= 0; //equipo a unidades
	volatile unsigned long temAd	= 0; //equipo a decenas
	volatile unsigned long temBu	= 0; //equipo b unidades
	volatile unsigned long temBd	= 0; //equipo b decenas
	volatile unsigned long puntajeEquipos[4]={temAd,temAu,temBd,temBu}; //para guardar en un vector todos los puntajes
	volatile unsigned long puntaje=1;     //mantiene el estado del boton bStart
//----------CONFIGURACION DE PUERTOS--------------------------------
	init_PORTA();
	init_PORTB();
//	init_PORTC();
	init_PORTE();
	init_PORTD();
	init_PORTF();
//------------CICLO INFINITO----------------------------------------	
	while(1)
	{
		contador=0;
		while(contador<40){ // 20 para vectores
				display(tiempo[0],&GPIO_PORTB_DATA_R);//
				visUNO(&GPIO_PORTE_DATA_R,&GPIO_PORTD_DATA_R,&GPIO_PORTF_DATA_R);//VISUALIZA 
				delay_ms(5); 	//ESPERA
				display(tiempo[1],&GPIO_PORTB_DATA_R);
				visDOS(&GPIO_PORTE_DATA_R,&GPIO_PORTD_DATA_R);
				delay_ms(5);
				display(tiempo[2],&GPIO_PORTB_DATA_R);
				visTRES(&GPIO_PORTE_DATA_R,&GPIO_PORTD_DATA_R);
				delay_ms(5);
				display(tiempo[3],&GPIO_PORTB_DATA_R);
				visCUATRO(&GPIO_PORTE_DATA_R,&GPIO_PORTD_DATA_R);
				delay_ms(5);
				display(temAd,&GPIO_PORTB_DATA_R); // temAd  reloj[0]
				visCINCO(&GPIO_PORTE_DATA_R,&GPIO_PORTD_DATA_R);
				delay_ms(5);	
			  display(temAu,&GPIO_PORTB_DATA_R);  //   reloj[1] temAu   
				visSEIS(&GPIO_PORTE_DATA_R,&GPIO_PORTD_DATA_R);
				delay_ms(5);	
				display(temBd,&GPIO_PORTB_DATA_R);  //    temBd
				visSIETE(&GPIO_PORTE_DATA_R,&GPIO_PORTD_DATA_R);
				delay_ms(5);	
				display(temBu,&GPIO_PORTB_DATA_R);    //    temBu
				visOCHO(&GPIO_PORTE_DATA_R,&GPIO_PORTD_DATA_R);
				delay_ms(5);
				display(puntaje,&GPIO_PORTB_DATA_R);    // puntaje 
				visNUEVE(&GPIO_PORTE_DATA_R,&GPIO_PORTD_DATA_R,&GPIO_PORTF_DATA_R);
				delay_ms(5);
				contador=contador+1;
		}
		botonP = botonesPuntos(&GPIO_PORTA_DATA_R);// LEE LOS BOTONES DEL PUERTO A PARA MARCAR LOS PUNTOS
		temA(&temAu,&temAd,botonP);//MARCA LOS PUNTOS DEL EQUIPO A
		botonP = botonesPuntos(&GPIO_PORTA_DATA_R);// LEE LOS BOTONES DEL PUERTO A PARA MARCAR LOS PUNTOS
		temB(&temBu,&temBd,botonP);//MARCA LOS PUNTOS DEL EQUIPO B
		
		botonT = botonesTime(&GPIO_PORTF_DATA_R);//LEE LOS BOTONES DEL PUERTO F PARA ESTABLECER EL TIEMPO DEL PARTIDO
		time(&tiempo,botonT); //LEE CUAL ES EL TIEMPO DEL PARTIDO
		
		bStart = botonStart(&GPIO_PORTE_DATA_R); // lee los botones del pueto e el p0 permite iniciar a contar, p1 -> detiene el contador
		
		Btodo[0]=bStart;
		Btodo[1]=contar;
		
		starTime(&tiempo,&reloj,&Btodo,&relojdos);  //le envia tiempo a reloj 
		puntajeEquipos[0]=temAd; // guarda todos los puntajes en un vector
		puntajeEquipos[1]=temAu;
		puntajeEquipos[2]=temBd;
		puntajeEquipos[3]=temBu; 
		//--------------prueba-------------------
		tiempodos[0]=tiempo[0];
		tiempodos[1]=tiempo[1];
		tiempodos[2]=tiempo[2];
		tiempodos[3]=tiempo[3];
		//---------------------------------
		finPtiempo(&tiempo,&reloj,&contar,&puntajeEquipos);   //pregunta si ya llego al maximo tiempo para indicar el fin del partido	
		
		while(contar==3){//prueba
		contador=0;
		while(contador<40){ // 20 para vectores
				display(tiempodos[0],&GPIO_PORTB_DATA_R);//
				visUNO(&GPIO_PORTE_DATA_R,&GPIO_PORTD_DATA_R,&GPIO_PORTF_DATA_R);//VISUALIZA 
				delay_ms(5); 	//ESPERA
				display(tiempodos[1],&GPIO_PORTB_DATA_R);
				visDOS(&GPIO_PORTE_DATA_R,&GPIO_PORTD_DATA_R);
				delay_ms(5);
				display(tiempodos[2],&GPIO_PORTB_DATA_R);
				visTRES(&GPIO_PORTE_DATA_R,&GPIO_PORTD_DATA_R);
				delay_ms(5);
				display(tiempodos[3],&GPIO_PORTB_DATA_R);
				visCUATRO(&GPIO_PORTE_DATA_R,&GPIO_PORTD_DATA_R);
				delay_ms(5);
				display(temAd,&GPIO_PORTB_DATA_R); // temAd  reloj[0]
				visCINCO(&GPIO_PORTE_DATA_R,&GPIO_PORTD_DATA_R);
				delay_ms(5);	
			  display(temAu,&GPIO_PORTB_DATA_R);  //   reloj[1] temAu   
				visSEIS(&GPIO_PORTE_DATA_R,&GPIO_PORTD_DATA_R);
				delay_ms(5);	
				display(temBd,&GPIO_PORTB_DATA_R);  //    temBd
				visSIETE(&GPIO_PORTE_DATA_R,&GPIO_PORTD_DATA_R);
				delay_ms(5);	
				display(temBu,&GPIO_PORTB_DATA_R);    //    temBu
				visOCHO(&GPIO_PORTE_DATA_R,&GPIO_PORTD_DATA_R);
				delay_ms(5);
				display(puntaje,&GPIO_PORTB_DATA_R);    //  
				visNUEVE(&GPIO_PORTE_DATA_R,&GPIO_PORTD_DATA_R,&GPIO_PORTF_DATA_R);
				delay_ms(5);
				contador=contador+1;
		}
		bStart = botonStart(&GPIO_PORTE_DATA_R); // lee los botones del pueto e el p0 permite iniciar a contar, p1 -> detiene el contador
		Btodo[0]=bStart;
		Btodo[1]=contar;
		starTime(&tiempo,&reloj,&Btodo,&relojdos);  //le envia tiempo a reloj 
		}  //termina w de prueba 
		while(contar==2){
		contador1=0;
		while(contador1<40){ // 20 para vectores
		display(tiempodos[0],&GPIO_PORTB_DATA_R);//
		visUNO(&GPIO_PORTE_DATA_R,&GPIO_PORTD_DATA_R,&GPIO_PORTF_DATA_R);//VISUALIZA 
		delay_ms(5); 	//ESPERA
		display(tiempodos[1],&GPIO_PORTB_DATA_R);
		visDOS(&GPIO_PORTE_DATA_R,&GPIO_PORTD_DATA_R);
		delay_ms(5);
		display(tiempodos[2],&GPIO_PORTB_DATA_R);
		visTRES(&GPIO_PORTE_DATA_R,&GPIO_PORTD_DATA_R);
		delay_ms(5);
		display(tiempodos[3],&GPIO_PORTB_DATA_R);
		visCUATRO(&GPIO_PORTE_DATA_R,&GPIO_PORTD_DATA_R);
		delay_ms(5);
		display(temAd,&GPIO_PORTB_DATA_R); // temAd  reloj[0]
		visCINCO(&GPIO_PORTE_DATA_R,&GPIO_PORTD_DATA_R);
		delay_ms(5);	
		display(temAu,&GPIO_PORTB_DATA_R);  //   reloj[1]   
		visSEIS(&GPIO_PORTE_DATA_R,&GPIO_PORTD_DATA_R);
		delay_ms(5);	
		display(temBd,&GPIO_PORTB_DATA_R);  // temBd   
		visSIETE(&GPIO_PORTE_DATA_R,&GPIO_PORTD_DATA_R);
		delay_ms(5);	
		display(temBu,&GPIO_PORTB_DATA_R);    //  temBu  
		visOCHO(&GPIO_PORTE_DATA_R,&GPIO_PORTD_DATA_R);
		delay_ms(5);
		display(2,&GPIO_PORTB_DATA_R);    //  
		visNUEVE(&GPIO_PORTE_DATA_R,&GPIO_PORTD_DATA_R,&GPIO_PORTF_DATA_R);
		delay_ms(5);
		contador1=contador1+1;
		}
		botonP = botonesPuntos(&GPIO_PORTA_DATA_R);// LEE LOS BOTONES DEL PUERTO A PARA MARCAR LOS PUNTOS
		temA(&temAu,&temAd,botonP);//MARCA LOS PUNTOS DEL EQUIPO A
		botonP = botonesPuntos(&GPIO_PORTA_DATA_R);// LEE LOS BOTONES DEL PUERTO A PARA MARCAR LOS PUNTOS
		temB(&temBu,&temBd,botonP);//MARCA LOS PUNTOS DEL EQUIPO B
		//------------------------prueba---------------------
		incre_tiemp(&tiempodos,&relojdos,bStart,&contar);
		//---------------------------------------------------
		starTimeseg(&tiempo,&relojdos,bStart,&contar);  //le envia tiempo a reloj 
		puntajeEquipos[0]=temAd; // guarda todos los puntajes en un vector
		puntajeEquipos[1]=temAu;
		puntajeEquipos[2]=temBd;
		puntajeEquipos[3]=temBu; 
		finPartido(&tiempo,&relojdos,&contar,&puntajeEquipos);   //pregunta si ya llego al maximo tiempo para indicar el fin del partido
		puntaje=reloj[1];
		}	
	}
}
