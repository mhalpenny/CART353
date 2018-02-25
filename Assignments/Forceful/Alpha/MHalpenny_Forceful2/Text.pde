class Text {
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  //float mass = 1;
  public float x,y;
  int val;
  boolean orbit = false;
  
  Text(){
    
    this.x = random(0, width);
    this.y = random(0, height);
    val = int(random(26)+1);
    
    location = new PVector(x, y);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    
  }
  
  void display(){
   
  float d = dist(location.x, location.y, dna.location.x, dna.location.y);  
   if (d < 15){
 orbit = true;
   }
   
     if (orbit == true){
 
       location.add(velocity);
 velocity.add(acceleration);
 velocity.limit(5);
 //refresh acc
 acceleration.mult(0);
 
 PVector body = new PVector(dna.location.x, dna.location.y);
 //subtracts mouse vector from location to get the difference
 body.sub(location);
 //limit vector
 body.setMag(0.5);
 //assign mouse vector to acceleration
 acceleration = body;
        
   }
   
    stroke(0);
    fill(0);
    textSize(14);
    
    if (val == 1){
      text("a", location.x, location.y);
    }else if (val == 2){
      text("b", location.x, location.y);
    }else if (val == 3){
      text("c", location.x, location.y);
    }else if (val == 4){
      text("d", location.x, location.y);
    }else if (val == 5){
      text("e", location.x, location.y);
    }else if (val == 6){
      text("f", location.x, location.y);
    }else if (val == 7){
      text("g", location.x, location.y);
    }else if (val == 8){
      text("h", location.x, location.y);
    }else if (val == 9){
      text("i", location.x, location.y);
    }else if (val == 10){
      text("j", location.x, location.y);
    }else if (val == 11){
      text("k", location.x, location.y);
    }else if (val == 12){
      text("l", location.x, location.y);
    }else if (val == 13){
      text("m", location.x, location.y);
    }else if (val == 14){
      text("n", location.x, location.y);
    }else if (val == 15){
      text("o", location.x, location.y);
    }else if (val == 16){
      text("p", location.x, location.y);
    }else if (val == 17){
      text("q", location.x, location.y);
    }else if (val == 18){
      text("r", location.x, location.y);
    }else if (val == 19){
      text("s", location.x, location.y);
    }else if (val == 20){
      text("t", location.x, location.y);
    }else if (val == 21){
      text("u", location.x, location.y);
    }else if (val == 22){
      text("v", location.x, location.y);
    }else if (val == 23){
      text("w", location.x, location.y);
    }else if (val == 24){
      text("x", location.x, location.y);
    }else if (val == 25){
      text("y", location.x, location.y);
    }else if (val == 26){
      text("z", location.x, location.y);
    }

  }

}