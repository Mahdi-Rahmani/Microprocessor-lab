#include <SPI.h>

char buf [100];
volatile int pos = 0;
volatile bool process = false;

void setup (void)
{
  Serial.begin(9600);
  pinMode(SS, INPUT_PULLUP);
  pinMode(MOSI, INPUT);
  pinMode(SCK, INPUT);
  SPCR |= _BV(SPE);
  SPI.attachInterrupt();
}  
ISR (SPI_STC_vect)
{
  char c = SPDR;
  if (pos < 100 && process == false)
  {
    if (c == 'z')
      process = true;
    else
    {
      buf [pos] = SPDR;
      pos++;
    }  
  }  
}
void loop (void)
{
  if (process)
  {
    buf[pos] = 0;  
    Serial.println (buf);
    pos = 0;
    process = false;
  }
}  
