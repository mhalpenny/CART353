class Tar {

  public PVector location;
  PImage tar;
  float x,y;

  Tar() {

    //calculate random xy
    x = random(0, width);
    y = random(0, height);
    
    //vextor for distance calculation with other vectors
    this.location = new PVector(x, y);
    
    //load icon
    tar = loadImage("oil.png");
  }

  void display() {

   // //check if theres a tar patch within the local radius
   //for (int i = 0; i<5; i++){
   //  if ((tarX[i] - 50) < x && x > (tarX[i] + 50)){
   //    x = random(0, width);
   //  } else if ((tarY[i] - 50) < x && x > (tarY[i] + 50)){
   //    y = random(0, width);
   //}
   //  this.location = new PVector(x, y);
   //}
   
    ellipseMode(CENTER);
    fill(0, 0, 0, 170);
    stroke(0);
    strokeWeight(1);
    ellipse(location.x, location.y, 230, 230);
    pushMatrix();
    translate(location.x, location.y);
    imageMode(CENTER);
    image(tar, 0, 0);
    tar.resize(50, 50);
    popMatrix();
  }
  

  void checkForce() {

    float d = dist(ball.location.x, ball.location.y, location.x, location.y);  

    if (d < 160) {
      frictionVal = -1;
    } else {
      frictionVal = -0.01;
    }
  }
}