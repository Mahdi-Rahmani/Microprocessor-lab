#include <LiquidCrystal.h>
#include <Keypad.h>

// initialize the LCD library with the numbers of the interface pins
LiquidCrystal lcd(13, 12, 11, 10, 9, 8);
// initialize the KEYPAD library with the numbers of the interface pins
const int ROW_NUM = 4; //four rows
const int COLUMN_NUM = 4; //three columns
static const uint8_t ANALOG_PINS[] = {A0,A1,A2,A3,A4,A5,A6,A7,A8};
//DEFINE KEYPAD BUTTONS
char keys[ROW_NUM][COLUMN_NUM] = {
  {'7','8','9', '/'},
  {'4','5','6', '*'},
  {'1','2','3', '-'},
  {'c','0','=', '+'}
};
//DEFINE KEYPAD CONNECTED PORTS
byte pin_rows[ROW_NUM] = {22, 24, 26, 28}; //connect to the row pinouts of the keypad
byte pin_column[COLUMN_NUM] = {18, 19, 20, 21}; //connect to the column pinouts of the keypad
Keypad keypad = Keypad( makeKeymap(keys), pin_rows, pin_column, ROW_NUM, COLUMN_NUM );
// end of initialize 

//define inputs and which input
String inputs[3];
char op = NULL;
int i = 0 , no = 0;

void setup() {
  // set up the LCD's number of columns and rows:
  lcd.begin(16, 2);
  //BEGIN SERIAL
  Serial.begin(9600);
  
}

void loop() {
  //GET CHARACTER OF KEY PRESSED
  char key = keypad.getKey();
  checkKey(key);
}

void checkKey(char key){
  if (key){
    if (key == 'c')
      clearLCD();
    else if (isDigit(key)){
      inputs[no] += key;
      lcd.setCursor(i++,0);
      lcd.print(key);
    }
    else if (key == '=' and op != NULL){
      int result = calculate(inputs[0],inputs[1],op);
      lcd.setCursor(0,1);
      lcd.print(result);
    }
    else if (op == NULL){
      op = key;
      no ++;
      lcd.setCursor(i++,0);
      lcd.print(key);
    }
    else{
      lcd.setCursor(0,1);
      lcd.print("INVALID INPUT");
      delay(100);
      lcd.setCursor(0,1);
      lcd.print("                ");
    }
    
    
  }
  
}

unsigned long calculate(String input1, String input2, char operat){
  unsigned long in1 = ( unsigned long ) (input1.toInt());
  unsigned long in2 = ( unsigned long ) (input2.toInt());
  switch (operat){
    case '+':
      return in1 + in2;
      break;
    case '-':
      return in1 - in2;
      break;
    case '*':
      return in1 * in2;
      break;
    case '/':
      return in1 / in2;
      break;
       
  }
}

void clearLCD(){
  lcd.clear();
  inputs[0] = "";
  inputs[1] = "";
  no = 0;
  i = 0;
  op = NULL;
}
