class Power {
  
  public PVector location;
  int tempS = 255;
  boolean increase = false;
  
  Power(){
    
     float x = random(0, width);
     float y = random(0, height);
    
    this.location = new PVector(x, y);
    
  }
  
  void display(){
    
  ellipseMode(CENTER);
  fill(0, 0, tempS);
  stroke(0);
  strokeWeight(1);
  ellipse(location.x, location.y, 10, 10); 
    
  }
  
  void increase(){
    
    float d = dist(ball.location.x, ball.location.y, location.x, location.y);  
   
   if (d < 40 && increase == false){
     
     gravForce += 2;
     tempS = 0;
     increase = true;
  } 
  }
    
   
}