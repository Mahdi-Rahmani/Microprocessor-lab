#include <SPI.h>

int value;
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
  byte number = SPDR;
  value = (uint8_t)number;
  process = true;  
}


void loop (void)
{
  if (process)
  { 
    Serial.print("Temprature : ");
    Serial.print(value);
    Serial.println(" C");
    process = false;
  }
}  
