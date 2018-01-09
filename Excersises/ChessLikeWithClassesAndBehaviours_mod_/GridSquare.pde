//renamed for black square classification
class SquareBlack {

  int x;
  int y;
  int size;
  int col;
  float food;

  boolean white;

  SquareBlack(int x, int y, int size, boolean white) {
    this.x = x;
    this.y = y;
    this.size = size;

    this.white = white;

    // establish a random amount of food to start with
    this.food = random(500, 1000);

    //if (white) {
    //  this.col = 255;
    //} else {
    //  this.col = 0;
    //}
  }

  void render() {

    // if it is a black square
    if (!this.white) {
    this.col = 0;
    
      // reflect the amount of food
      col = (int)map(this.food, 0, 1000, 255, 0);

    //only draw black squares, otherwise skip rect 
    fill(col, 10);
    rect(this.x * size, this.y * size, size, size);
    }else{
      noFill();
    }
  }

  void update() {
    if(!this.white && this.food > 0) {
      this.food--;
    }
  }

  void feed() {
    if (!this.white && this.food < 1000) {
      this.food += 10;
      
    }
  }
  
}