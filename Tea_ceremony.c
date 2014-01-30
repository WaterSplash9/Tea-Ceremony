#include <mega328p.h>
#include <ds18b20.h>
#include <1wire.h>
// Standard Input/Output functions
#include <stdio.h>
#include <delay.h>
#asm  
  .equ __w1_port=0xB; PORTD
  .equ __w1_bit=7; 
#endasm


int firststart=3; 
int temp1;
int temp2;
int data;
int temp;
int pwm;


 void writetemp()
{
                        temp=ds18b20_temperature(0); 
          if (temp>1000){            
             temp=4096-temp;          
             temp=-temp;                
          }
          printf("t=%i C",temp);    

}



void main(void)
{
 int startUDR0=UDR0;


devices = w1_init();
#pragma optsize-
CLKPR=0x80;
CLKPR=0x00;
#ifdef _OPTIMIZE_SIZE_
#pragma optsize+
#endif

PORTB=0x00;
DDRB=0xFF;
PORTC=0x01;
DDRC=0x01;
PORTD=0b00000000;
DDRD=0b01000000;

TCCR0A=0x00;
TCCR0B=0x00;
TCNT0=0x00;
OCR0A=0x00;
OCR0B=0x00;
TCCR1A=0x00;
TCCR1B=0x00;
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;
ASSR=0x00;
TCCR2A=0x00;
TCCR2B=0x00;
TCNT2=0x00;
OCR2A=0x00;
OCR2B=0x00;
EICRA=0x00;
EIMSK=0x00;
PCICR=0x00;


//UART инициализация
UCSR0A=0x00;
UCSR0B=0x18;
UCSR0C=0x06;
UBRR0H=0x00;
UBRR0L=0x33;

//Аналоговый компаратор
ACSR=0x80;
ADCSRB=0x00;
DIDR1=0x00;



printf("Write temp1"); 
while (1)
{

if (firststart==3)
{
    
    if(UDR0!=startUDR0)
    {
        firststart--;   
    }
}
else if (firststart==2)
    {
    temp1=UDR0;
    startUDR0=UDR0;
    if(UDR0!=startUDR0)
        {
         firststart--;
         printf("temp1 = ");
         printf("%d",temp1);        
         }
    }
else if (firststart==1)
{
    temp2=UDR0;
    firststart--;     
    printf("temp2 = ");  
    printf("%u",temp2);
}

else
{
    while(1)
        { 
              if (temp>temp2)
                {   
                    PORTB=0x00;   
                    writetemp();
                    printf("Thermo OFF");
                }   
                
                else if(temp<temp1)
                {      
                    PORTB=0xFF; 
                    writetemp();
                    printf("Thermo ON");
                }
        }
}



}

