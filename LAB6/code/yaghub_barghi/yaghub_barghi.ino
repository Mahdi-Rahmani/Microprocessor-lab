#include <Keypad.h>
#include <LiquidCrystal.h>
#include<Servo.h>

#define RS_PIN 13
#define E_PIN 12
#define DB7_PIN 11
#define DB6_PIN 10
#define DB5_PIN 9
#define DB4_PIN 8 

#define LEDS 0

#define I4 26
#define I3 25
#define I2 24
#define I1 23 
#define I0 22

#define FULL_CAPACITY 5


const byte ROWS = 4; //four rows
const byte COLS = 3; //three columns 

char keys[ROWS][COLS] = {
  {'1','2','3'},
  {'4','5','6'},
  {'7','8','9'},
  {'*','0','#'}
};

byte rowPins[ROWS] = {46, 48, 50, 52}; 
byte colPins[COLS] = {34, 36, 38};

Keypad keypad = Keypad( makeKeymap(keys), rowPins, colPins, ROWS, COLS );
LiquidCrystal lcd(RS_PIN, E_PIN, DB4_PIN, DB5_PIN, DB6_PIN, DB7_PIN);
Servo door;  
Servo myservo; 

const int passWord[] = {1, 3, 9, 7, 3, 1, 0};  // so is password is 1397310
int lenght = 0;
int input[7] = {-1, -1, -1, -1, -1, -1, -1};
int capacity[24];
int opened = 0;

void setup() {
  pinMode(LEDS, OUTPUT);

  pinMode(I0, OUTPUT);
  pinMode(I1, OUTPUT);
  pinMode(I2, OUTPUT);
  pinMode(I3, OUTPUT);
  pinMode(I4, OUTPUT);

  for (int i = 0; i < 24; i++)
  {
    capacity[i] = FULL_CAPACITY;
  }
  
  lcd.begin(16, 2);
  myservo.attach(3, 1000, 2000); 
  myservo.writeMicroseconds(700);
  door.attach(2, 1000, 2000); 
  door.writeMicroseconds(700);
  lcd.clear();
  delay(100);
  closeDoor();

  activeTable();
  delay(15);
  myservo.write(0);
  delay(15);
}



void loop() {
  char recieve = keypad.getKey();
  if (recieve)
  {
    if (recieve >= '0' && recieve <= '9' && opened == 0)
    {
      if (lenght < 7)
      {
        lcd.write(recieve);
        input[lenght] = recieve - 48;
        lenght++;
      }
    }
    else if (recieve == '*' && opened == 0) // confirm
    {
      if (lenght == 2)
      {
        int number = input[0] * 10 + input[1];
        if (number > 0 && number < 25)
        {
          mapTo(number);
          delay(15);

          
          if (capacity[number - 1] == 0)
          {
            //myservo.write(0);
            lcd.setCursor(0, 1);
            lcd.print("   SOLD OUT!!   ");
            delay(800);
            lcd.clear();
          }
          else
          {
            
            lcd.setCursor(0, 1);
            lcd.print("      DONE      ");
            myservo.write((FULL_CAPACITY + 1 - capacity[number - 1]) * (180 / FULL_CAPACITY));
            delay(15);
            capacity[number - 1] = capacity[number - 1] - 1;
            delay(800);
            lcd.clear();
          }
        }
      } 
      else if (lenght == 7)
      {
        int res = 0;
        for (int i = 0; i < 7; i++)
          if (input[i] != passWord[i])
          {
            res = -1;
            break;
          }
        if (res == 0)
        {
          lcd.setCursor(0, 1);
          lcd.print("     OPENED     ");
          openDoor();
          opened = 1;
          delay(800);
          lcd.clear();
          
        }
        else
        {
          lcd.setCursor(0, 1);
          lcd.print("WRONG PASSWORD!!");
          delay(800);
          lcd.clear();
        }
      } 
      else
      {
        lcd.setCursor(0, 1);
        lcd.print(" WRONG  INPUT!! ");
        delay(800);
        lcd.clear();
      }
      lenght = 0;
      for (int i = 0; i < 7; i++)
        input[i] = -1;
    }
    else if (recieve == '#') // delete
    {
      for (int i = 0; i < 7; i++)
        input[i] = -1;
      
      if (opened == 1)
      {
        lcd.setCursor(0, 1);
        lcd.print("     CLOSED     ");
        closeDoor();
        opened = 0;
        delay(800);
        
      }
      lcd.clear();
      lenght = 0;
    }
  }
}


void openDoor()
{
  int i = door.read();
  
  for (; i >= 0; i -= 5)
  {
    door.write(i);
    delay(15);
  }

  activeTable();
  delay(15);
  myservo.write(0);
  delay(15);
  for (int i = 0; i < 24; i++)
  {
    capacity[i] = FULL_CAPACITY;
  }
  digitalWrite(LEDS, LOW);
}

void closeDoor()
{
  int i = door.read();
  for (; i <= 180; i += 5)
  {
    door.write(i);
    delay(15);
  }
  digitalWrite(LEDS, HIGH);
}

void mapTo(int number)
{
  int number2 = 0;
  switch(number)
  {
    case 1: number2 = 1;
    break;
    case 2: number2 = 7;
    break;
    case 3: number2 = 13;
    break;
    case 4: number2 = 19;
    break;
    case 5: number2 = 2;
    break;
    case 6: number2 = 8;
    break;
    case 7: number2 = 14;
    break;
    case 8: number2 = 20;
    break;
    case 9: number2 = 3;
    break;
    case 10: number2 = 9; 
    break;
    case 11: number2 = 15;
    break;
    case 12: number2 = 21;
    break;
    case 13: number2 = 4;
    break;
    case 14: number2 = 10;
    break;
    case 15: number2 = 16;
    break;
    case 16: number2 = 22;
    break;
    case 17: number2 = 5;
    break;
    case 18: number2 = 11;
    break;
    case 19: number2= 17;
    break;
    case 20: number2 = 23;
    break;
    case 21: number2 = 6;
    break;
    case 22: number2 = 12;
    break;
    case 23: number2 = 18;
    break;
    case 24: number2 = 24;
    break;
  }

  switch(number2)
  {
    case 1:
      digitalWrite(I0, HIGH);
      digitalWrite(I1, LOW);
      digitalWrite(I2, LOW);
      digitalWrite(I3, LOW);
      digitalWrite(I4, LOW);
    break;
    case 2:
      digitalWrite(I0, LOW);
      digitalWrite(I1, HIGH);
      digitalWrite(I2, LOW);
      digitalWrite(I3, LOW);
      digitalWrite(I4, LOW);
    break;
    case 3:
      digitalWrite(I0, HIGH);
      digitalWrite(I1, HIGH);
      digitalWrite(I2, LOW);
      digitalWrite(I3, LOW);
      digitalWrite(I4, LOW);
    break;
    case 4:
      digitalWrite(I0, LOW);
      digitalWrite(I1, LOW);
      digitalWrite(I2, HIGH);
      digitalWrite(I3, LOW);
      digitalWrite(I4, LOW);
    break;
    case 5:
      digitalWrite(I0, HIGH);
      digitalWrite(I1, LOW);
      digitalWrite(I2, HIGH);
      digitalWrite(I3, LOW);
      digitalWrite(I4, LOW);
    break;
    case 6:
      digitalWrite(I0, LOW);
      digitalWrite(I1, HIGH);
      digitalWrite(I2, HIGH);
      digitalWrite(I3, LOW);
      digitalWrite(I4, LOW);
    break;
    case 7:
      digitalWrite(I0, HIGH);
      digitalWrite(I1, HIGH);
      digitalWrite(I2, HIGH);
      digitalWrite(I3, LOW);
      digitalWrite(I4, LOW);
    break;
    case 8:
      digitalWrite(I0, LOW);
      digitalWrite(I1, LOW);
      digitalWrite(I2, LOW);
      digitalWrite(I3, HIGH);
      digitalWrite(I4, LOW);
    break;
    case 9:
      digitalWrite(I0, HIGH);
      digitalWrite(I1, LOW);
      digitalWrite(I2, LOW);
      digitalWrite(I3, HIGH);
      digitalWrite(I4, LOW);
    break;
    case 10:
      digitalWrite(I0, LOW);
      digitalWrite(I1, HIGH);
      digitalWrite(I2, LOW);
      digitalWrite(I3, HIGH);
      digitalWrite(I4, LOW);
    break;
    case 11:
      digitalWrite(I0, HIGH);
      digitalWrite(I1, HIGH);
      digitalWrite(I2, LOW);
      digitalWrite(I3, HIGH);
      digitalWrite(I4, LOW);
    break;
    case 12:
      digitalWrite(I0, LOW);
      digitalWrite(I1, LOW);
      digitalWrite(I2, HIGH);
      digitalWrite(I3, HIGH);
      digitalWrite(I4, LOW);
    break;
    case 13:
      digitalWrite(I0, HIGH);
      digitalWrite(I1, LOW);
      digitalWrite(I2, HIGH);
      digitalWrite(I3, HIGH);
      digitalWrite(I4, LOW);
    break;
    case 14:
      digitalWrite(I0, LOW);
      digitalWrite(I1, HIGH);
      digitalWrite(I2, HIGH);
      digitalWrite(I3, HIGH);
      digitalWrite(I4, LOW);
    break;
    case 15:
      digitalWrite(I0, HIGH);
      digitalWrite(I1, HIGH);
      digitalWrite(I2, HIGH);
      digitalWrite(I3, HIGH);
      digitalWrite(I4, LOW);
    break;
    case 16:
      digitalWrite(I0, LOW);
      digitalWrite(I1, LOW);
      digitalWrite(I2, LOW);
      digitalWrite(I3, LOW);
      digitalWrite(I4, HIGH);
    break;
    case 17:
      digitalWrite(I0, HIGH);
      digitalWrite(I1, LOW);
      digitalWrite(I2, LOW);
      digitalWrite(I3, LOW);
      digitalWrite(I4, HIGH);
    break;
    case 18:
      digitalWrite(I0, LOW);
      digitalWrite(I1, HIGH);
      digitalWrite(I2, LOW);
      digitalWrite(I3, LOW);
      digitalWrite(I4, HIGH);
    break;
    case 19:
      digitalWrite(I0, HIGH);
      digitalWrite(I1, HIGH);
      digitalWrite(I2, LOW);
      digitalWrite(I3, LOW);
      digitalWrite(I4, HIGH);
    break;
    case 20:
      digitalWrite(I0, LOW);
      digitalWrite(I1, LOW);
      digitalWrite(I2, HIGH);
      digitalWrite(I3, LOW);
      digitalWrite(I4, HIGH);
    break;
    case 21:
      digitalWrite(I0, HIGH);
      digitalWrite(I1, LOW);
      digitalWrite(I2, HIGH);
      digitalWrite(I3, LOW);
      digitalWrite(I4, HIGH);
    break;
    case 22:
      digitalWrite(I0, LOW);
      digitalWrite(I1, HIGH);
      digitalWrite(I2, HIGH);
      digitalWrite(I3, LOW);
      digitalWrite(I4, HIGH);
    break;
    case 23:
      digitalWrite(I0, HIGH);
      digitalWrite(I1, HIGH);
      digitalWrite(I2, HIGH);
      digitalWrite(I3, LOW);
      digitalWrite(I4, HIGH);
    break;
    case 24:
      digitalWrite(I0, LOW);
      digitalWrite(I1, LOW);
      digitalWrite(I2, LOW);
      digitalWrite(I3, HIGH);
      digitalWrite(I4, HIGH);
    break;
  }
  

}

void resetTable()
{
  digitalWrite(I0, LOW);
  digitalWrite(I1, LOW);
  digitalWrite(I2, LOW);
  digitalWrite(I3, LOW);
  digitalWrite(I4, LOW);
  
}

void activeTable()
{
  digitalWrite(I0, HIGH);
  digitalWrite(I1, LOW);
  digitalWrite(I2, LOW);
  digitalWrite(I3, HIGH);
  digitalWrite(I4, HIGH);
}
