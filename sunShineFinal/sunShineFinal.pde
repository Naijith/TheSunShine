public static final int numOfArc = 40;
float step, speed,offset;
float[] arcEnd1 = new float[numOfArc];
float[] arcEndTemp1 = new float[numOfArc];
float[] arcEndFlag1 = new float[numOfArc];
float[] arcEnd2 = new float[numOfArc];
float[] arcEndTemp2 = new float[numOfArc];
float[] arcEndFlag2 = new float[numOfArc];
int currentTime;
float steps = 1,stepFlag=0;
int offFlag=0;
int[] offArray = {0,1,2,3,5,27,26,25,28,38,39,41,42};
int off=0;

void setup() {
  size(1000, 800);
  step = 13;
  noFill();
  frameRate(20);
  strokeWeight(5);
  currentTime=millis();
}

void sunCenterf1(int o){
  background(0);
  stroke(215,65,0);
  for(int i = 1; i < numOfArc; i++) {
    offset = o*PI / numOfArc * i;
    arcEnd1[i] = map(cos(speed+offset), -1,1, PI, TWO_PI);
    if(arcEnd1[i]<=3.15){
      arcEndFlag1[i]=1;
      arcEndTemp1[i]=arcEnd1[i];
    }
    if(arcEndFlag1[i]==1)
        arcEnd1[i]=arcEndTemp1[i];
    arc(0, -4, i * step, i * step, arcEnd1[i], TWO_PI);
  }
  speed+=0.05;
  
  stroke(55);
  for(int i = 1; i < numOfArc; i++) {
    offset = o*PI / numOfArc * i;
    arcEnd2[i] = map(-cos(speed+offset), -1,1, PI, 0);
    if(arcEnd2[i]<=0.01){
      arcEndFlag2[i]=1;
      arcEndTemp2[i]=arcEnd2[i];
    }
    if(arcEndFlag2[i]==1)
        arcEnd2[i]=arcEndTemp2[i];
    arc(0, 4, i * step, i * step, arcEnd2[i], PI);
  }
  speed+=0.05;
}

void sunCenterf2(int o){
  background(0);
  stroke(random(80)+170,random(80)+70,0);
  for(int i = 1; i < numOfArc; i++) {
    offset = o*PI / numOfArc * i;
    arcEnd1[i] = map(cos(speed+offset), -1,1, PI, TWO_PI);
    if(arcEnd1[i]<=3.15){
      arcEndFlag1[i]=1;
      arcEndTemp1[i]=arcEnd1[i];
    }
    if(arcEndFlag1[i]==1)
        arcEnd1[i]=arcEndTemp1[i];
    arc(0, -4, i * step, i * step, arcEnd1[i], TWO_PI);
  }
  speed+=0.05;
  
  stroke(random(100)+20);
  for(int i = 1; i < numOfArc; i++) {
    offset = o*PI / numOfArc * i;
    arcEnd2[i] = map(-cos(speed+offset), -1,1, PI, 0);
    if(arcEnd2[i]<=0.01){
      arcEndFlag2[i]=1;
      arcEndTemp2[i]=arcEnd2[i];
    }
    if(arcEndFlag2[i]==1)
        arcEnd2[i]=arcEndTemp2[i];
    arc(0, 4, i * step, i * step, arcEnd2[i], PI);
  }
  speed+=0.05;
}


void sunCenter2(){
  background(0);
  stroke(random(80)+170,random(80)+70,0);
  for(int i = 1; i < numOfArc; i++) {
    offset = PI / numOfArc * i;
    arcEnd1[i] = map(cos(speed+offset), -1,1, PI, random(PI)+PI);
    arc(0, -4, i * step, i * step, arcEnd1[i], TWO_PI);
  }
  speed+=0.025;
  
  stroke(random(100)+20);
  for(int i = 1; i < numOfArc; i++) {
    offset = 10*PI / numOfArc * i;
    arcEnd2[i] = map(-cos(speed+offset), -1,1, PI, 0);
    arc(0, 4, i * step, i * step, arcEnd2[i], PI);
  }
  speed+=0.025;
}

void dashedCircle(float radius, int dashWidth, int dashSpacing) {
    if(steps==200)
      stepFlag=1;
    else if(steps==0)
      stepFlag=0;
    if(stepFlag == 0)
      steps+=0.5;
    else
      steps-=0.5;
    int dashPeriod = dashWidth + dashSpacing;
    boolean lastDashed = false;
    for(int i = 0; i < steps; i++) {
      boolean curDashed = (i % dashPeriod) < dashWidth;
      if(curDashed && !lastDashed) {
        beginShape();
      }
      if(!curDashed && lastDashed) {
        endShape();
      }
      if(curDashed) {
        float theta = map(i, 0, steps, 0, TWO_PI);
        vertex(cos(theta) * radius, sin(theta) * radius);
      }
      lastDashed = curDashed;
    }
    if(lastDashed) {
      endShape();
    }
}

void sunOuter1(){
  noFill();
  stroke(random(225)+30,random(225)+30,random(225)+30);
  for(int k=30,j=8;k<=38;k++,j--)
    dashedCircle(k*10,j,9 -j);
}

void sunOuter2(){
  noFill();
  stroke(random(55)+200,random(200)+55,0);
  for(int k=30,j=8;k<=38;k++,j--)
    dashedCircle(k*10,j,9 -j);
}

void draw() {
  background(0);
  translate(width / 2, height / 2);
  if(millis()-currentTime >= 30500)
    sunCenterf2(offArray[off]);
  else
    sunCenterf1(offArray[off]);

    for(int j=1;j<numOfArc;j++)
        if(arcEndFlag1[j]==1)
            offFlag++;
        else
            offFlag--;
    if(offFlag>=39){
      offFlag=0;
      off = (off+1)%13;
      for(int j=1;j<numOfArc;j++)
          {
            arcEndFlag1[j]=0;
            arcEndFlag2[j]=0;
            arcEndTemp1[j]=0;
            arcEndTemp2[j]=0;
          }
    }
    
    if(millis()-currentTime >= 73000)
        {
          sunCenter2();
          sunOuter2();
        }
        
    else if(millis()-currentTime >= 59000)
        sunOuter1();
        
    
}
