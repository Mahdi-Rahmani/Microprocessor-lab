#include <Keypad.h>

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
byte pin_rows[ROW_NUM] = {6, 5, 4, 3}; //connect to the row pinouts of the keypad
byte pin_column[COLUMN_NUM] = {7, 8, 9}; //connect to the column pinouts of the keypad

Keypad keypad = Keypad( makeKeymap(keys), pin_rows, pin_column, ROW_NUM, COLUMN_NUM );

void setup(){
  //BEGIN SERIAL
  Serial.begin(9600);
  //DEFINE OUTPUT PINS
  pinMode(A0,OUTPUT);
  pinMode(A1,OUTPUT);
  pinMode(A2,OUTPUT);
  pinMode(A3,OUTPUT);
  pinMode(A4,OUTPUT);
  pinMode(A5,OUTPUT);
  pinMode(A6,OUTPUT);
  pinMode(A7,OUTPUT);
  pinMode(A8,OUTPUT);
}

void loop(){
  
  //GET CHARACTER OF KEY PRESSED
  char key = keypad.getKey();
  //CHECK KEY AND TURN ON OR OFF LED
  check(key);
   
  //SERIAL AVAILABLITY CHECK
  if(Serial.available()){
    //GET CHARACTER OF KEY PRESSED IN TERMINAL
    key = Serial.read();
    //CHECK KEY AND TURN ON OR OFF LED
    check(key);
  }
     
}

void check(char key){
  //Control EMPTY TERMINAL
  if(!key)
    return;
  //PRINT INVALIDs
  if((key<'1' || key>'9') && key!='#'){
    Serial.println("Invalid number");
    return;
  }
  //PRINT KEY NUMBER
  Serial.println(key);
  //TURN OFF LEDs
  for (int i=0; i<9; i++)
      digitalWrite(ANALOG_PINS[i],LOW);
  //TURN ON LEDs
  for (char i='1'; i<=key; i++){
   digitalWrite(ANALOG_PINS[i-49],HIGH);
   delay(100);
  }
}
