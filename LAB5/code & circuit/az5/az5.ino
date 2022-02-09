void setup() {
  // put your setup code here, to run once:
  pinMode(26,OUTPUT);
 
}

void loop() {
  // put your main code here, to run repeatedly:
  bool state = digitalRead(26);
  digitalWrite(26,not state);
  delay(626);
}
