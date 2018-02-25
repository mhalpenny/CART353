class Pole {

  public PVector location;
  PImage mag;


  Pole() {

    float x = random(0, width);
    float y = random(0, height);

    this.location = new PVector(x, y);
    mag = loadImage("mag.png");
  }

  void display() {

    ellipseMode(CENTER);
    fill(255);
    stroke(0);
    strokeWeight(1);
    ellipse(location.x, location.y, 40, 40); 
    pushMatrix();
    translate(location.x, location.y);
    imageMode(CENTER);
    image(mag, 0, 0);
    mag.resize(30, 30);
    popMatrix();
  }

  void pull() {
  }
}