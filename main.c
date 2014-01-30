void main(void)
{
w1_init();
#pragma optsize-
CLKPR=0x80;
CLKPR=0x00;
#ifdef _OPTIMIZE_SIZE_
#pragma optsize+
#endif

PORTB=0x00;
DDRB=0xFF;

PORTC=0x00;
DDRC=0x00;

PORTD=0b00000000;
DDRD=0b00000000;


UCSR0A=0x00;
UCSR0B=0x18;
UCSR0C=0x06;
UBRR0H=0x00;
UBRR0L=0x33;

while (1)
{
    outtemp();
    data=UDR0;
	
      if(data=='1')
      {
      PORTB=0xFF;
      printf("Thermostat forced on!");
      }
      else if(data=='0')
      {
      PORTB=0x00;
       printf("Thermostat forced off!");
      }
else
{
	    thermcontrol(temp);
		printf("Thermostat AUTO");
}

    
} 
}