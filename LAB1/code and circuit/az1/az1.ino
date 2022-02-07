void setup() {
  // DEFINE INPUTS
  pinMode(12,INPUT);
  pinMode(11,INPUT);
  pinMode(10,INPUT);
 
  // DEFINE OUTPUTS
  pinMode(6,OUTPUT);
  pinMode(5,OUTPUT);
  pinMode(4,OUTPUT);
  pinMode(3,OUTPUT);
  pinMode(2,OUTPUT);
  pinMode(1,OUTPUT);
  pinMode(0,OUTPUT);  
}

void loop() {

  int left_right = digitalRead(12);
  int Amin = digitalRead(11);
  int off = digitalRead(10);


  // LIGHTS ARE SEETING ON FROM LEFT SIDE IF S1 IS ACTIVE
  if ( left_right == LOW ) {
    for (int i = 6; i >= 0; i--){
      digitalWrite(i,HIGH);
      delay(100);
    }
  }

  // LIGHTS ARE SEETING ON 4 time due to Amin string IF S2 IS ACTIVE
  else if ( Amin == LOW ) {
      for (int i = 3; i>=0; i--) {
        digitalWrite(0,HIGH);
        digitalWrite(1,HIGH);
        digitalWrite(2,HIGH);
        digitalWrite(3,HIGH);
        digitalWrite(4,HIGH);
        digitalWrite(5,HIGH);
        digitalWrite(6,HIGH);
        delay(500);
        digitalWrite(0,LOW);
        digitalWrite(1,LOW);
        digitalWrite(2,LOW);
        digitalWrite(3,LOW);
        digitalWrite(4,LOW);
        digitalWrite(5,LOW);
        digitalWrite(6,LOW);
        delay(500);
    }
  }

  // LIGHTS ARE SEETING OFF IF S3 IS ACTIVE
  else if ( off == LOW ) {
    for (int i = 6; i >= 0; i--)
      digitalWrite(i,LOW);
  }
  
  
}
