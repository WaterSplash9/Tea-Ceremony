#include <mega328p.h>
#include <ds18b20.h>
#include <1wire.h>
#include <stdio.h> 
#include <delay.h>

int temp;

void thermcontrol(int temperature)
{
if (temperature<90)
{
	PORTB=0xFF;
}
else if (temperature>=90&&temperature<100)
{
	PORTB=0xFF;
}
else if (temperature>=100)
{
	PORTB=0x00;
}
else 
{
	PORTB = 0x00;
}  

}