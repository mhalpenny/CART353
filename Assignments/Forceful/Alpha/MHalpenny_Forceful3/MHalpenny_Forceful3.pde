//MHalpenny Forceful alpha planning

Body ball;
Text[] letters = new Text[40];
int letterCount = 40;
boolean[] follow = new boolean[40];
Pole[] magnet = new Pole[5];
Tar[] sand = new Tar[5];
Power[] powerUp = new Power[2];
float frictionVal;
float gravForce = 1;
float[] tarX = new float[5];
float[] tarY = new float[5];

void setup(){
  size(1000, 700);
  background(255);


  ball = new Body();
  for(int i=0; i< letterCount; i++){
  letters[i] = new Text();
  }
  for(int i=0; i< letterCount; i++){
  follow[i] = false;
  }
   for(int i=0; i< 5; i++){
  magnet[i] = new Pole();
  }
  for(int i=0; i< 5; i++){
  sand[i] = new Tar();
  tarX[i] = sand[i].location.x;
  tarY[i] = sand[i].location.x;
  }
   for(int i=0; i< 2; i++){
  powerUp[i] = new Power();
  }
}


void draw(){
 

  background(255);

  //ball.edges();
  
  ball.eat();
 
 for(int i=0; i< 5; i++){
   magnet[i].display();
   }
    for(int i=0; i< 5; i++){
   sand[i].display();
   sand[i].checkForce();
   }
   
   for(int i=0; i< 2; i++){
   powerUp[i].display();
   powerUp[i].increase();
   }
  
  ball.friction(frictionVal);
  ball.update();
  ball.display();
  
  for(int i=0; i< letterCount; i++){
  letters[i].display();
  letters[i].pull();
   }
   
   updateScore();
}



 