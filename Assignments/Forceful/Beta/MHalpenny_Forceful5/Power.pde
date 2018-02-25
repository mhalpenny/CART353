//The Power class is used to create the powerUp objects, which change the balls pull on text.

class Power {
  
  //location vectors are important for calculating vectors between text objects
  public PVector location;
  //c will display the power ups color (active/used), it initialized on 255 which will translate to blue
  int c = 255;
  //increase acts as a switch for the use of the power up. When switched to true it increases the pull and turns off the power up
  boolean increase = false;
  
  Power(){
    
    //calculate a random x y position within the sketch...
     float x = random(0, width);
     float y = random(0, height);
     
    //apply this xy position into the location vector
    this.location = new PVector(x, y);
    
  }
  
  //the display method draws the magnets on screen every draw() cycle
  void display(){
    
  //set up graphics
  ellipseMode(CENTER);
  //the fill is dependent on a variable controlled by the increase() function
  fill(0, 0, c);
  stroke(0);
  strokeWeight(1);
  //draw ellipse at the vector location of this object
  ellipse(location.x, location.y, 10, 10); 
    
  }
  
  //the function will control the increase of the balls pull and change the activity on the powerUp object
  void increase(){
    
    //calculate the distance between the ball and this powerUp object
    float d = dist(ball.location.x, ball.location.y, location.x, location.y);  
   
   //if the ball is over the powerUp and this is the first time (boolean is in its initial state)...
   if (d < 30 && increase == false){
     
     //add to the gravitational force of the ball, passed inside the Body class
     gravForce += 0.5;
     //switch the object color
     c = 0;
     //do not allow this increase to occur again by switching off the conditional boolean
     increase = true;
  } 
  }
    
   
}