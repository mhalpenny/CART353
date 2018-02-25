void updateScore(){
  
  int score = int(ball.mass*100);
  
  
  stroke(0);
  fill(255, 200);
  rect(0, 0, 110, 65);
  fill(0);
  textSize(14);
  text(("score: " + score), 15, 25);
  text(("pull: " + gravForce), 15, 45);
  //text(("friction: " + frictionVal), 15, 55);
  
  
}