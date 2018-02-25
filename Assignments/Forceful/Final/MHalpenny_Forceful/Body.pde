//The body class controls the ball object 

class Body {
  
  //The ball has location,velocity, acceleration, and mass
  public PVector location;
  public PVector velocity;
  public PVector acceleration;
  //mass is just a variable and will be changed throughout the sketch and applied to forces
  public float mass = 1;
 
  
  Body(){
    
    //Start the ball in the center of the screen with no velocity or acceleration
    this.location = new PVector(width/2, height/2);
    this.velocity = new PVector(0,0);
    this.acceleration = new PVector(0,0);
    
  }
  
  
//Update() calculates the balls physics within the world 
void update(){ 
  
 //add previously calculated velocity and acceleration to the ball
 location.add(velocity);
 velocity.add(acceleration);
 //limit the balls velocity 
 velocity.limit(2.5);
 //refresh acceleration every frame since acceleration does not stack on itself
 acceleration.mult(0);
 
 //For the ball to follow the mouse we need to create a PVector for the mouse coordinates
 PVector mouse = new PVector(mouseX, mouseY);
 //subtract the mouse vector from the balls location to get a new vector pointing towards the mouse
 mouse.sub(location);
 //limit the vector so the ball is more easily controlled
 mouse.setMag(5);
 //assign the mouse vector to the balls acceleration so it accelerates towards the mouse
 acceleration = mouse.mult(1);
  
}
 

//the display method draws the magnets on screen every draw() cycle
void display(){
  
  //set up graphics...
  ellipseMode(CENTER);
  //alpha on fill is lowered to give a force field apperance
  fill(100, 150);
  stroke(0);
  strokeWeight(1);
  //draw field around ellipse at current ball location, field size is controlled by mass
  ellipse(location.x, location.y, mass*30, mass*30); 
  //adjust fill
  fill(255);
  //draw core of the ball at current location
  ellipse(location.x, location.y, 30, 30); 
  
}

void applyForce(PVector f){
  PVector force = f.mult(mass);
  acceleration.add(force);
  println(force);
  
}


//amass() checks for text around the ball and adds or subtracts them from the mass
void amass(){
  
  //run through the array of letters determined by the variable used
  for(int i=0; i< letterCount; i++){
    
    //check the distance between the given letter and the ball
   float d = dist(letters[i].location.x, letters[i].location.y, location.x, location.y);  
   
   //if the letter is stationary (not yet picked up by the ball & determined by the follow boolean) add mass
   //here we use a follow boolean and not the orbit boolean from the text class because while orbit is on mass would keep incrementing, follow is an additional check to avoid looping
   if (d < 10 && follow[i] == false){
     //add the the current mass
     mass += 0.2;
     //switch the boolean so no more mass will be added unless its lost and re-picked up (switched again)
     follow[i] = true;    
   } 
   //if the letter becomes far enough from the ball and was following it (boolean) subtract mass as its lost
   else if (d > 80 && follow[i] == true){
     //subtract from the total mass
     mass = mass - 0.2;
     //switch the boolean so that the letter may be re picked up if possible
     follow[i] = false;

   }
  }
}


  void friction(){
    
//declare a temp variable for use in the following for loop
//allows compiling of all object values called from the array 
//refreshes value every loop so friction doesnt endlessly add to itself
float frictionTemp = 0;

for(int i=0; i<5; i++){
  
    //calculate the distance between the moving body and the current (i) sand trap
    float d = dist(ball.location.x, ball.location.y, sand[i].location.x, sand[i].location.y);  
   
   //if the ball is within the sand pit
   if (d<130) {
   //add -5 to the friction value for each sand pit within bounds (stacks effects), negative so that it diminishes acceleration
   frictionTemp += -2;
   } 
  }
    
   //fetch the balls current velocity 
  PVector friction = this.velocity.get();
  //normailze so we dont get double negatives
  friction.normalize();
 
 //multiply the frictionTemp from the for loop with the balls current velocity (as a seperate vector copy to allow multipe instances if required later on)
  friction.mult(frictionTemp);

  //apply this friction vector to the acceleration of the ball
  ball.applyForce(friction);
  }

}