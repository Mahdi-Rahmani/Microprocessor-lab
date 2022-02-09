#include <SPI.h>

const int slaveSelectPin1 = 43;
const int slaveSelectPin2 = 42;

int turn = 1;

void setup() {
  
  pinMode(slaveSelectPin1, OUTPUT);
  digitalWrite(slaveSelectPin1, HIGH);

  pinMode(slaveSelectPin2, OUTPUT);
  digitalWrite(slaveSelectPin2, HIGH);

  SPI.begin();
}

void loop() {
  if (turn == 1)
  {
    sendData("Hello Amin & Mahdi", 18, turn);
    turn = 2;
    delay(200);
  } else if (turn == 2)
  {
    sendData("Amin/Mahdi", 10, turn);
    turn = 1;
    delay(300);
  }
}

void sendData (char data[], int _size, int ss)
{
  if (ss == 1)
    digitalWrite(slaveSelectPin1, LOW);
  else if (ss == 2)
    digitalWrite(slaveSelectPin2, LOW);
  
  delay(100);
  for (int i = 0; i < _size; i++)
  {
    SPI.transfer(data[i]);
    delay(25);
  }
  SPI.transfer('z');
  delay(200);

  if (ss == 1)
    digitalWrite(slaveSelectPin1, HIGH);
  else if (ss == 2)
    digitalWrite(slaveSelectPin2, HIGH);
}
