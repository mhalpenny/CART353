class Text {
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  //float mass = 1;
  public float x,y;
  int val;
  
  Text(){
    
    this.x = random(0, width);
    this.y = random(0, height);
    val = int(random(26)+1);
    
    location = new PVector(x, y);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    
  }
  
  void display(){
    
    stroke(0);
    fill(0);
    textSize(14);
    
    if (val == 1){
      text("a", x, y);
    }else if (val == 2){
      text("b", x, y);
    }else if (val == 3){
      text("c", x, y);
    }else if (val == 4){
      text("d", x, y);
    }else if (val == 5){
      text("e", x, y);
    }else if (val == 6){
      text("f", x, y);
    }else if (val == 7){
      text("g", x, y);
    }else if (val == 8){
      text("h", x, y);
    }else if (val == 9){
      text("i", x, y);
    }else if (val == 10){
      text("j", x, y);
    }else if (val == 11){
      text("k", x, y);
    }else if (val == 12){
      text("l", x, y);
    }else if (val == 13){
      text("m", x, y);
    }else if (val == 14){
      text("n", x, y);
    }else if (val == 15){
      text("o", x, y);
    }else if (val == 16){
      text("p", x, y);
    }else if (val == 17){
      text("q", x, y);
    }else if (val == 18){
      text("r", x, y);
    }else if (val == 19){
      text("s", x, y);
    }else if (val == 20){
      text("t", x, y);
    }else if (val == 21){
      text("u", x, y);
    }else if (val == 22){
      text("v", x, y);
    }else if (val == 23){
      text("w", x, y);
    }else if (val == 24){
      text("x", x, y);
    }else if (val == 25){
      text("y", x, y);
    }else if (val == 26){
      text("z", x, y);
    }
  }
void orbit(){

 location.add(velocity);
 velocity.add(acceleration);
 velocity.limit(2);
 //refresh acc
 acceleration.mult(0);
 
 PVector mouse = new PVector(mouseX, mouseY);
 //subtracts mouse vector from location to get the difference
 mouse.sub(location);
 //limit vector
 mouse.setMag(0.1);
 //assign mouse vector to acceleration
 acceleration = mouse;
}
}