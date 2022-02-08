#include <LiquidCrystal.h>
#include <Keypad.h>

// initialize the LCD library with the numbers of the interface pins
LiquidCrystal lcd(13, 12, 11, 10, 9, 8);
// initialize the KEYPAD library with the numbers of the interface pins
const int ROW_NUM = 4; //four rows
const int COLUMN_NUM = 3; //three columns
static const uint8_t ANALOG_PINS[] = {A0,A1,A2,A3,A4,A5,A6,A7,A8};
//DEFINE KEYPAD BUTTONS
char keys[ROW_NUM][COLUMN_NUM] = {
  {'1','2','3'},
  {'4','5','6'},
  {'7','8','9'},
  {'*','0','#'}
};
//DEFINE KEYPAD CONNECTED PORTS
byte pin_rows[ROW_NUM] = {18, 19, 20, 21}; //connect to the row pinouts of the keypad
byte pin_column[COLUMN_NUM] = {26, 24, 22}; //connect to the column pinouts of the keypad
Keypad keypad = Keypad( makeKeymap(keys), pin_rows, pin_column, ROW_NUM, COLUMN_NUM );
// end of initialize 

//set default password
int i = 0;
String password = "9731701";
String input;
int len = password.length();

void setup() {
  // set up the LCD's number of columns and rows:
  lcd.begin(16, 2);

  
}

void loop() {
  //GET CHARACTER OF KEY PRESSED
  char key = keypad.getKey();
  if (key){
    if (key == '*'){
      if (i == 7)
           checkPassword(input, password);
    }
    else if (i < 7 && isDigit(key)){
      input += key;
      lcd.setCursor(i++,0);
      lcd.print(key);
    }
    else{
      lcd.setCursor(0,1);
      lcd.print("INVALID INPUT");
      delay(262);
      lcd.setCursor(0,1);
      lcd.print("                ");
    }
    
  }
  
}

void checkPassword(String input, String password){
  lcd.setCursor(0,1);
  if (input == password)    
    lcd.print("Correct Password");
  else
    lcd.print("Wrong Password");
    
  delay(662);
  clearLCD();  
}

void clearLCD(){
  lcd.clear();
  i = 0;
  input = "";
}
