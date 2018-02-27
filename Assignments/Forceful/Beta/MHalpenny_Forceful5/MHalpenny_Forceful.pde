//Matthew Halpenny
//Forceful for CART 353
//All images used under CC - credits to Ana María Lora Macias & Marek Polakovic

//The user controls the ball with their mouse, it will be pulled towards the mouse position. The ball
//responds to physical propeties such as velocity and acceleration which will affect how the game is played. 
//The goal is to amass as much text as possible, doing so will increase the balls mass (density in this case) and 
//create a growing field around the ball. The balls density will affect it within the tar traps, so it is crucial to 
//avoid these while large as the player will get immobilized. As the ball becomes denser is will become easier for text
//to seperate from the ball, meaning you can lose points. This is based off atomic properties where larger elements lose
//eletrons more easily due to distance from the electromagnetic core. To avoid this the blue power ups will grant a 
//stronger pull on the text. Magnets will also attempt to pull away text, they are to be avoided. 


//----------------------------------------------------------------------------------------------------------------


//class variables for objects used inside sketch
//ball object is the main rolling "player" object
Body ball;
//letters are the text scattered around the sketch that may be amassed
Text[] letters = new Text[100];
//powerUp objects increase the balls physics powers, such as increased pull on letters
Power[] powerUp = new Power[2];
//magnet objects will attempt to pull away letters from the ball object
Pole[] magnet = new Pole[15];
//Trap objects slow down or speed up the ball
Trap[] sand = new Trap[3];
Trap[] oil = new Trap[2];

//variables that are nested in loops across the skecth, allows a global change in value
int letterCount = 100;
int magnetCount = 15;
//global variable that adjusts friction on the ball object. must be accessed across classes and should not be a property of the ball.
float frictionVal;
//global variable that adjusts the magnitude of acceleration the ball exerts of letters. amplitude is not an accessible property otherwise
float gravForce = 0.5;

//a boolean array to check if the letters are currently orbiting the ball, used in mass calculation in Body class
boolean[] follow = new boolean[100];
//ends the game is true
boolean end = false;


void setup(){
  size(1000, 700);
  background(255);

 //instantiate all objects
  ball = new Body();
  for(int i=0; i< letterCount; i++){
  letters[i] = new Text();
  }
  for(int i=0; i< letterCount; i++){
  follow[i] = false;
  }
   for(int i=0; i< magnetCount; i++){
  magnet[i] = new Pole();
  }
  for(int i=0; i< 3; i++){
  sand[i] = new Trap();
  oil[i] = new Trap();
  }
   for(int i=0; i< 2; i++){
  powerUp[i] = new Power();
  }
}


void draw(){
 
  //if the game isnt over...
  //the end boolean is controlled by a timer in the endGame() method
 if (end == false){
  
  //redraw background every frame
  background(255);
  
  //call function that controls amassing of letters
  ball.amass();
 
 //display magnet objects
 for(int i=0; i< magnetCount; i++){
   magnet[i].display();
   }
   
   //display sand objects and check if the are colliding with the ball (friction)
    for(int i=0; i< 5; i++){
   sand[i].display();
   //sand[i].checkForce();
   }
   
   //display powerUp objects and if collision with the ball increase "pull" force
   for(int i=0; i< 2; i++){
   powerUp[i].display();
   powerUp[i].increase();
   }
  
  //recalculate ball physics
  ball.update();
  //exert friction on ball
  ball.friction();
  //draw ball
  ball.display();
  
  //display and calculate physics on letters
  for(int i=0; i< letterCount; i++){
  letters[i].display();
  letters[i].pull();
   }
   
   //show score and game attributes
   updateScore();
   
 }else { //when the time is up switch to the mode...
   
   //terminate the previous if loop, which is the game, and just display an end message
   endGame();
    
 }
 
}



 