class Body {
  
  public PVector location;
  public PVector velocity;
  public PVector acceleration;
  public float mass = 1;
  //float elipSize = 30;
  
  Body(){
    
    this.location = new PVector(width/2, height/2);
    this.velocity = new PVector(0,0);
    this.acceleration = new PVector(0,0);
    
  }
  
void update(){ 
 location.add(velocity);
 velocity.add(acceleration);
 velocity.limit(2);
 //refresh acc
 acceleration.mult(0);
 
 PVector mouse = new PVector(mouseX, mouseY);
 //subtracts mouse vector from location to get the difference
 mouse.sub(location);
 //limit vector
 mouse.setMag(gravForce);
 //assign mouse vector to acceleration
 acceleration = mouse.mult(1);

 
}

void edges(){
  if (location.x > width) location.x = 0;
  if (location.x < 0) location.x = width;
  if (location.y > height) location.y = 0;
  if (location.y < 0) location.y = height;
  
}

void display(){
  
  ellipseMode(CENTER);
  fill(100, 150);
  stroke(0);
  strokeWeight(1);
  ellipse(location.x, location.y, mass*30, mass*30); 
  fill(255);
  ellipse(location.x, location.y, 30, 30); 
  
}

void applyForce(PVector f){
  PVector force = f.mult(mass);
  acceleration.add(force);
}

void eat(){
  
  for(int i=0; i< letterCount; i++){
   float d = dist(letters[i].location.x, letters[i].location.y, location.x, location.y);  
   if (d < 10 && follow[i] == false){
     mass += 0.2;
     follow[i] = true;
   } else if (d > 80 && follow[i] == true){
     mass = mass - 0.2;
     follow[i] = false;

   }
  }
}


  void friction(float tempC){
  PVector friction = velocity.get();
  friction.normalize();
 
  float c = tempC;
  friction.mult(c);
  
  ball.applyForce(friction);
  }

}