#include <Servo.h>

Servo myservo;  


int val;    
int potpin = A0;

void setup() {
  myservo.attach(9, 1000, 2000);  
}

void loop() {
  val = analogRead(potpin);           
  val = map(val, 0, 1023, 0, 180);     
  myservo.write(val);                  
  delay(15);                           
}
