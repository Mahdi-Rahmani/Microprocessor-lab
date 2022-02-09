#include <SPI.h>

const int slaveSelectPin1 = 49;


void setup() {
  
  pinMode(slaveSelectPin1, OUTPUT);
  digitalWrite(slaveSelectPin1, HIGH);
  SPI.setClockDivider(SPI_CLOCK_DIV32);
  SPI.begin();
}

void loop() {
  sendData("Amin9731024/Mahdi9731701", 24);
  delay(200);
}

void sendData (char data[], int _size)
{
  digitalWrite(slaveSelectPin1, LOW);
  
  delay(100);
  for (int i = 0; i < _size; i++)
  {
    SPI.transfer(data[i]);
    delay(25);
  }
  SPI.transfer('z');
  delay(100);

  digitalWrite(slaveSelectPin1, HIGH);
}
