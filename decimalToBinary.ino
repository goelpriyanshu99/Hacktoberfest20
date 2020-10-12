
void setup() {
  Serial.begin(9600);
  pinMode(6,OUTPUT);
  pinMode(5,OUTPUT);
  pinMode(4,OUTPUT);
  pinMode(3,OUTPUT);
  pinMode(2,OUTPUT);
}

void loop() {
  String h=convert(16);
  int i=0;
  int j=6;
  for(i=0,j=6;i<h.length();i++,j--){
    if(h.charAt(i)=='1'){
      digitalWrite(j,HIGH);
    }
    else{
      digitalWrite(j,LOW);
    }
  }
  delay(100);
}

String convert(int n){
  String s="";
  while(n>1){
    s=s+(n%2);
    n=n/2;
  }
  return s+n;
}

