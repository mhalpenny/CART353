//The Text class is used to create letters that will be amassed by the body or stolen by magnets

class Text {

  //Since the text will be orbiting the ball we have to include location, velocity, and acceleration
  PVector location;
  PVector velocity;
  PVector acceleration;
  //float mass = 1;
  

  public float x, y;
  
  //the val integer will be used to determine which letter is displayed
  int val;
  //the orbit boolean will determine if physics are appied to the text in relation to the ball
  //allows the magnets to permanently steal letters and avoids constant text floating around the screen
  boolean orbit = false;

  Text() {

    //calculate random xy
    this.x = random(0, width);
    this.y = random(0, height);
    
    //choose a random value for the letter between 1 and 26 (the alphabet)
    val = int(random(26)+1);
    
    //create a vector location from xy
    location = new PVector(x, y);
    //start with a velocity and acceleration of 0
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

//the display method draws the magnets on screen every draw() cycle
  void display() {

    //when being displayed the text has two options controlled by the orbit boolean, it may be picked up or dropped
    //these properties are controlled below, but first we need to calculate the distance of the text in relation to the ball
    float d = dist(location.x, location.y, ball.location.x, ball.location.y);  

    //if the ball is over the text, switch orbit to true - this will trigger a function allowing orbiting...
    if (d < 15) {
      orbit = true;
    } 
    //this section will determine if orbiting text has left the grvitational field of the ball, and will turn orbiting off if so
    else if (d > 80) {     
      orbit = false;
    }

  //if the text is orbiting, aka if the ball picks it up, apply the following physics...
  //the physics are not always on to avoid slow movement across the screen, its simply a design/display choice
    if (orbit == true) {

      //add velocity and acceleration to the text (determined below)
      location.add(velocity);
      velocity.add(acceleration);
      //limit the texts velocity so it does not create a feedback loop and instead has a constant maximum
      velocity.limit(5);
      //refresh acceleration each cycle
      acceleration.mult(0);
      
      //create a vector that is the balls location
      PVector body = new PVector(ball.location.x, ball.location.y);
      //subtract the ball vector from the text location to get a new vector pointing towards the balls core
      body.sub(location);
      //limit the vector as mentioned above, but allow it to be modified via powerUp (changes in gravForce) which create a stronger pull towards the ball
      body.setMag(gravForce);
      //assign the balls vector to the texts acceleration, creating an orbit
      acceleration = body;
    }

    //set up text graphics
    stroke(0);
    fill(0);
    textSize(14);
    
    
    //the following if/else sequence will determine which letter is drawn 
    if (val == 1) {
      text("a", location.x, location.y);
    } else if (val == 2) {
      text("b", location.x, location.y);
    } else if (val == 3) {
      text("c", location.x, location.y);
    } else if (val == 4) {
      text("d", location.x, location.y);
    } else if (val == 5) {
      text("e", location.x, location.y);
    } else if (val == 6) {
      text("f", location.x, location.y);
    } else if (val == 7) {
      text("g", location.x, location.y);
    } else if (val == 8) {
      text("h", location.x, location.y);
    } else if (val == 9) {
      text("i", location.x, location.y);
    } else if (val == 10) {
      text("j", location.x, location.y);
    } else if (val == 11) {
      text("k", location.    x, location.y);
    } else if (val == 12) {
      text("l", location.x, location.y);
    } else if (val == 13) {
      text("m", location.x, location.y);
    } else if (val == 14) {
      text("n", location.x, location.y);
    } else if (val == 15) {
      text("o", location.x, location.y);
    } else if (val == 16) {
      text("p", location.x, location.y);
    } else if (val == 17) {
      text("q", location.x, location.y);
    } else if (val == 18) {
      text("r", location.x, location.y);
    } else if (val == 19) {
      text("s", location.x, location.y);
    } else if (val == 20) {
      text("t", location.x, location.y);
    } else if (val == 21) {
      text("u", location.x, location.y);
    } else if (val == 22) {
      text("v", location.x, location.y);
    } else if (val == 23) {
      text("w", location.x, location.y);
    } else if (val == 24) {
      text("x", location.x, location.y);
    } else if (val == 25) {
      text("y", location.x, location.y);
    } else if (val == 26) {
      text("z", location.x, location.y);
    }
  }

//the pull function corresponds to the physics behind the magnet and text (rather than the ball)
  void pull() {
    
    //run through each magnet object and check if the text is proximal to the magnet
    for (int i=0; i< magnetCount; i++) {
      
      //check the distance between text and magnet
      float d = dist(location.x, location.y, magnet[i].location.x, magnet[i].location.y);
     
     //is the text less than 25 units away from the magnet...
      if (d < 25) {
        
        //create a new PVector for the magnet
        PVector mag = new PVector((magnet[i].location.x), (magnet[i].location.y));
        //subtractthe magnet vector from the text location to get a new vector attracting the text
        mag.sub(location);
        //set the limit of attraction high
        mag.setMag(10);
        //assign the magnet vector to the text accleration causing it to fly towards the magnet and stick
        acceleration = mag;       
      }
    }
  }
}