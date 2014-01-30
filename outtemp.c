#include <mega328p.h>
#include <ds18b20.h>
#include <1wire.h>
#include <stdio.h> 
#include <delay.h>

void outtemp()
{
          temp=ds18b20_temperature(0); 
          if (temp>1000){            
             temp=4096-temp;          
             temp=-temp;                
          }
          printf("t=%i C",temp);    


}