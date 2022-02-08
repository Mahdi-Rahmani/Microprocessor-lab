#include <LiquidCrystal.h>

// initialize the library with the numbers of the interface pins
LiquidCrystal lcd(13, 12, 11, 10, 9, 8);
int i = 0;

void setup() {
  // set up the LCD's number of columns and rows:
  lcd.begin(16, 2);
}
  
void loop() {
  int line_no = i%2;
  int char_no = i++%16;
  lcd.clear();
  lcd.setCursor(char_no, line_no);
  lcd.print("M");
  delay(100);
  
}
