//The Pole class, named for the magnetic poles they represent, it is used to create the magnet objects.

class Pole {
  
  //location vectors are important for calculating vectors between text objects
  public PVector location;
  //PImage is used to store the icons
  PImage mag;


  Pole() {

    //calculate a random x y position within the sketch...
    float x = random(0, width);
    float y = random(0, height);

    //apply this xy position into the location vector
    this.location = new PVector(x, y);
    //load the icon into memory 
    mag = loadImage("mag.png");
  }

//the display method draws the magnets on screen every draw() cycle
  void display() {
    
    //set up graphics
    ellipseMode(CENTER);
    fill(255);
    stroke(0);
    strokeWeight(1);
    
    //draw the ellipse at the calculated location (constructor)
    ellipse(location.x, location.y, 40, 40); 
    
    //this push/pop matrix will draw the icons ontop of the existing ellipses
    pushMatrix();
    //translate to the magnets xy position
    translate(location.x, location.y);
    //image and ellipse modes match for aligned icons
    imageMode(CENTER);
    //display icon which we loaded earlier
    image(mag, 0, 0);
    //by default the image will display at its standard size so we need to resize is using a PImage function
    mag.resize(30, 30);
    //exit the matrix
    popMatrix();
  }

  
}