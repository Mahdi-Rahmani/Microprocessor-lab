#include <SPI.h>

const int slaveSelectPin1 = 43;
const int slaveSelectPin2 = 42;
const int tempPIN = A8;
const int lightPIN = A9;

int analogValue;
uint8_t mapped;
int turn = 1;

void setup() {
  
  pinMode(slaveSelectPin1, OUTPUT);
  digitalWrite(slaveSelectPin1, HIGH);

  pinMode(slaveSelectPin2, OUTPUT);
  digitalWrite(slaveSelectPin2, HIGH);

  pinMode(lightPIN, INPUT);
  pinMode(tempPIN, INPUT);

  SPI.begin();
}

void loop() {
  if (turn == 1)
  {
    delay(400);
    analogValue = analogRead(tempPIN);
    mapped = map(analogValue, 0, 306, 0, 150); 
    sendData(mapped, turn);
    turn = 2;
    delay(200);
  } else if (turn == 2){
    delay(200);
    analogValue = analogRead(lightPIN);
    mapped = map(analogValue, 0, 1023, 0, 100);  
    sendData(mapped, turn);
    turn = 1;
    delay(200);
  }
}
void sendData (uint8_t data, int ss)
{
  if (ss == 1)
    digitalWrite(slaveSelectPin1, LOW);
  else if (ss == 2)
    digitalWrite(slaveSelectPin2, LOW);
  delay(100);
  SPI.transfer(data);
  delay(100);
  if (ss == 1)
    digitalWrite(slaveSelectPin1, HIGH);
  else if (ss == 2)
    digitalWrite(slaveSelectPin2, HIGH);
}
