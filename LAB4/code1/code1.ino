#include <Servo.h>

Servo myservo;  
int i = 0;    

void setup() {
  myservo.attach(9);  
}

void loop() {
  for (i = 0; i <= 90; i++) { 
    myservo.write(i);             
    delay(15);                       
  }
  for (i = 90; i >= 0; i--) { 
    myservo.write(i);              
    delay(15);                       
  }
}
