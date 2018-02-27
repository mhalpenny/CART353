//The Tar class is used to create sand trap objects 

class Trap {
  
  //location vectors are important for calculating vectors for friction
  public PVector location;
  //PImage is used to store the icons
  PImage tar;
  //float x,y;

  Trap() {

    //calculate random xy
    float x = random(0, width);
    float y = random(0, height);
    
    //vextor for distance calculation with other vectors
    this.location = new PVector(x, y);
    
    //load icon
    tar = loadImage("sand.png");
  }

//the display method draws the magnets on screen every draw() cycle
  void display() {
   
    //set up graphics
    ellipseMode(CENTER);
    fill(0, 0, 0, 170);
    stroke(0);
    strokeWeight(1);
    
    //draw the ellipse at the calculated location (constructor)
    ellipse(location.x, location.y, 230, 230);
    
    //this push/pop matrix will draw the icons ontop of the existing ellipses
    pushMatrix();
    //translate to the sand traps xy position
    translate(location.x, location.y);
    //image and ellipse modes match for aligned icons
    imageMode(CENTER);
    //display icon which we loaded earlier
    image(tar, 0, 0);
    //by default the image will display at its standard size so we need to resize is using a PImage function
    tar.resize(60, 60);
    //exit the matrix
    popMatrix();
  }
  
}