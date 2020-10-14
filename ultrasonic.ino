const int trigPin = 12;
const int echoPin = 13;
long duration;
int distance;
void setup() {
  pinMode(trigPin,OUTPUT);
  pinMode(echoPin,INPUT);
  Serial.begin(9600);
}

void loop() {
  digitalWrite(trigPin,LOW);
  delayMicroseconds(200);
  digitalWrite(trigPin,HIGH);
  delayMicroseconds(1000);
  digitalWrite(trigPin,LOW);
  long duration = pulseIn(echoPin,HIGH);
  int distance = duration*0.034/2;
  Serial.print("Distance : ");
  Serial.println(distance);
}
