#include <Servo.h>

Servo myservo; 
int number = 0;
int first = 1;
void setup() {
  Serial.begin(9600);
  myservo.attach(9, 1000, 2000); 
  myservo.writeMicroseconds(700);
  delay(15);
}

void loop() {
  char recieve = Serial.read();

  if (recieve)
  {
    if (recieve >= '0' && recieve <= '9')
    {
      if (first == 1 && recieve == '0')
        return;
      number = (number * 10) + recieve - 48;
      Serial.write(recieve);
      first = 0;
    }
    else if (recieve == '=')
    {
      if (number > 180)
        number = myservo.read();
        myservo.write(180 - number);  
      Serial.write(12);
      number = 0;
      first = 1;
    }
  }

}
