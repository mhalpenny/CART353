//MHalpenny Forceful alpha planning

Body dna;
Text[] letters = new Text[10];
int letterCount = 10;


void setup(){
  size(500, 500);
  background(255);


  dna = new Body();
  for(int i=0; i< letterCount; i++){
  letters[i] = new Text();
  }
}


void draw(){
  
  PVector f =  new PVector(0, 0);
  dna.applyForce(f);
  
  background(255);
  dna.update();
  //dna.edges();
  dna.display();
  for(int i=0; i< letterCount; i++){
  letters[i].display();
  }
  dna.eat();

  //println(frameRate);
}



 