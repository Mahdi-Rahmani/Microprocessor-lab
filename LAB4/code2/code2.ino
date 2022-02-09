#include <Servo.h>
#include <Keypad.h>

const byte ROWS = 4; //four rows
const byte COLS = 4; //three columns 

char keys[ROWS][COLS] = {
  {'7','8','9','/'},
  {'4','5','6','*'},
  {'1','2','3','-'},
  {'s','0','=','+'}
};

byte rowPins[ROWS] = {31, 33, 35, 37}; 
byte colPins[COLS] = {23, 25, 27, 29};

Keypad keypad = Keypad( makeKeymap(keys), rowPins, colPins, ROWS, COLS );

Servo myservo;  
int number = 0;
void setup() {
  myservo.attach(9); 
  myservo.writeMicroseconds(700);
}

void loop() {
  char recieve = keypad.getKey();
  if (recieve)
  {
    if (recieve >= '0' && recieve <= '9')
    {
      number = (number * 10) + ((int)recieve - 48) ;
    }
    else if (recieve == '=')
    {
      if (number > 360)
        number = myservo.read();
        
       myservo.write(number);  
       number = 0;
    }
  }           
}
