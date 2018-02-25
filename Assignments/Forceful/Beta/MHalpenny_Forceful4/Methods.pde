//method to display an end game message overtop the previous frame, relies on updateScore() for time
void endGame(){
  
  //set up graphics
  stroke(0);
  fill(255, 200);
  rectMode(CENTER);
  rect(width/2, height/2, 400, 60);
  fill(0);
  textSize(14);
  textAlign(CENTER);
  text("game over", width/2, height/2);
  
}

//updates the score and game attributes, also acts as a timer function for the game duration
void updateScore(){
  
  //the score is calculated based on the balls mass, meaning it can increase and decrease
  int score = int(ball.mass*100);
  
  //the time remaining is based off millis() - or the time since the sketch has started
  //75 seconds are given, since millis is in milliseconds we need to convert to seconds
  int time = int(75 - (millis() / 1000));
  
  //set up graphics as a box in the top left corner
  stroke(0);
  fill(255, 200);
  rect(0, 0, 110, 85);
  fill(0);
  textSize(14);
  text(("score: " + score), 15, 25);
  text(("pull: " + (gravForce*2)), 15, 45);
  text(("time: " + time), 15, 65);
  
  
  //if the timer (time variable) reaches zero flip the end boolean which triggers the endGame function.
  if (time == 0){
     end = true;
  }
  
}