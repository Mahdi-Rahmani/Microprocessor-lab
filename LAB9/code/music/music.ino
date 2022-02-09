#include <Keypad.h>
#include "pitches.h"

#include "ey_iran.h"
#include "jingle_bells.h"
#include "Ode_to_Joy.h"
#include "the_imperial_march.h"
#include "frere_jacques.h"
#include "Pirates_of_Caribbean.h"

#define TEMPO1 210
#define TEMPO2 210
#define TEMPO3 150
#define TEMPO4 150
#define TEMPO5 135
#define TEMPO6 150


const byte ROWS = 4; //four rows
const byte COLS = 3; //three columns 

char keys[ROWS][COLS] = {
  {'1','2','3'},
  {'4','5','6'},
  {'7','8','9'},
  {'*','0','#'}
};

byte rowPins[ROWS] = {29, 31, 33, 35}; 
byte colPins[COLS] = {23, 25, 27};


const int potPin = A0, buttonPin = 0, soundPin = 8;
bool play = false;
float scale = 0;
int choose = 1;

Keypad keypad = Keypad( makeKeymap(keys), rowPins, colPins, ROWS, COLS );

void setup() {
  pinMode(buttonPin, INPUT_PULLUP);
}

void loop() {
  play = 1 - digitalRead(buttonPin);
  char recieve = keypad.getKey();
  if (recieve)
  {
    switch(recieve){
      case '1':
        choose = 1;
        break;
       case '2':
        choose = 2;
        break;
       case '3':
        choose = 3;
        break;
       case '4':
        choose = 4;
        break;
       case '5':
        choose = 5;
        break;
       case '6':
        choose = 6;
        break;   
    }
  }
  if(play && choose == 1)
  {
    for (int note = 0; note < sizeof(melody1) / sizeof(int); note++) {
      scale = analogRead(potPin) / 512.0;
      int duration = 2 * 60 * 1000.0 / (TEMPO1 * noteDurations1[note]);
      tone(soundPin, (int) (melody1[note] * scale), duration);
      delay( (int) duration );
      if (digitalRead(buttonPin)) {
        break;
      }
    }
  }else if(play && choose == 2){
    for (int note = 0; note < sizeof(melody2) / sizeof(int); note++) {
      scale = analogRead(potPin) / 512.0;
      int duration = 2 * 60 * 1000.0 / (TEMPO2 * noteDurations2[note]);
      tone(soundPin, (int) (melody2[note] * scale), duration);
      delay( (int) duration );
      if (digitalRead(buttonPin)) {
        break;
      }
    }
  }else if(play && choose == 3){
    for (int note = 0; note < sizeof(melody3) / sizeof(int); note++) {
      scale = analogRead(potPin) / 512.0;
      int duration = 2 * 60 * 1000.0 / (TEMPO3 * noteDurations3[note]);
      tone(soundPin, (int) (melody3[note] * scale), duration);
      delay( (int) duration );
      if (digitalRead(buttonPin)) {
        break;
      }
    }
  }else if(play && choose == 4){
    for (int note = 0; note < sizeof(melody4) / sizeof(int); note++) {
      scale = analogRead(potPin) / 512.0;
      int duration = 2 * 60 * 1000.0 / (TEMPO4 * noteDurations4[note]);
      tone(soundPin, (int) (melody4[note] * scale), duration);
      delay( (int) duration );
      if (digitalRead(buttonPin)) {
        break;
      }
    }
  }else if(play && choose == 5){
    for (int note = 0; note < sizeof(melody5) / sizeof(int); note++) {
      scale = analogRead(potPin) / 512.0;
      int duration = 2 * 60 * 1000.0 / (TEMPO5 * noteDurations5[note]);
      tone(soundPin, (int) (melody5[note] * scale), duration);
      delay( (int) duration );
      if (digitalRead(buttonPin)) {
        break;
      }
    }
  }else if(play && choose == 6){
    for (int note = 0; note < sizeof(melody6) / sizeof(int); note++) {
      scale = analogRead(potPin) / 512.0;
      int duration = 2 * 60 * 1000.0 / (TEMPO6 * noteDurations6[note]);
      tone(soundPin, (int) (melody6[note] * scale), duration);
      delay( (int) duration );
      if (digitalRead(buttonPin)) {
        break;
      }
    }
  }
}
