//MHalpenny Forceful alpha planning

Body dna;

void setup(){
  size(500, 500);
  background(255);

  dna = new Body();
  
}


void draw(){
  background(255);
  dna.update();
  //dna.edges();
  dna.display();

}



 