boolean white;
//seperated classes
SquareBlack[][] Bgrid;
SquareWhite[][] Wgrid;
int rows;
int cols;
int gridSquareSize;
int press = 0;

void setup() {

  size(400, 400);
  noStroke();
  rows = 8;
  cols = 8;
  gridSquareSize = 50;

  Bgrid = new SquareBlack[cols][rows];
  Wgrid = new SquareWhite[cols][rows];
  
  // do a double for loop to run through the grid 2D array
  // creating new alternating black and white GridSquare objects
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      Bgrid[i][j] = new SquareBlack(i, j, gridSquareSize, white);
      Wgrid[i][j] = new SquareWhite(i, j, gridSquareSize, white);
      white = !white;
    }
    white = !white;
  }
}

void draw() {
  
  // every time daw runs, we want to go through the grid 2d array and update and render each GridSquare object
  // update represents getting hungry
  // render takes care of drawing
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      //updated to black
      Bgrid[i][j].update();
      Bgrid[i][j].render();
      //added white squares
      Wgrid[i][j].render();
    }
  }
  
  // determine which gid slot mouse is over
  int currentHorizSquare = mouseX / 50;
  int currentVertSquare = mouseY / 50;

  // do mouseOver-based feeding only on **valid** grid slots
  if (currentHorizSquare >= 0 && currentHorizSquare <= 7 && currentVertSquare >= 0 && currentVertSquare <= 7) {
    //updated to black
      Bgrid[currentHorizSquare][currentVertSquare].feed();
  }
  
  if (press == 1){
     for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
    Bgrid[i][j].feed();
    }
  }
  }
}

void keyPressed(){
  press = 1;
}

void keyReleased(){
 press = 0; 
}