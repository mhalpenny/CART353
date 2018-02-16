class Body {
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  Body(){
    
    location = new PVector(width/2, height/2);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    
  }
  
void update(){ 
 location.add(velocity);
 velocity.add(acceleration);
 velocity.limit(2);
 
 PVector mouse = new PVector(mouseX, mouseY);
 //subtracts mouse vector from location to get the difference
 mouse.sub(location);
 //limit vector
 mouse.setMag(0.1);
 //assign mouse vector to acceleration
 acceleration = mouse;
}

void edges(){
  if (location.x > width) location.x = 0;
  if (location.x < 0) location.x = width;
  if (location.y > height) location.y = 0;
  if (location.y < 0) location.y = height;
  
}

void display(){
  
  ellipseMode(CENTER);
  fill(100);
  stroke(0);
  strokeWeight(1);
  ellipse(location.x, location.y, 30, 30); 
  
}
}