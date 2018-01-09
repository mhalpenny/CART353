class SquareWhite {

  int x;
  int y;
  int size;
  int col;
  float food;

  boolean white;

  SquareWhite(int x, int y, int size, boolean white) {
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

    // if it is a white square, otherwise skip
    if (this.white) {
    this.col = 255;
    fill(col);
    rect(this.x * size, this.y * size, size, size);
    } else{
      noFill();
    }
  }

  //void update() {
  //  if(!this.white && this.food > 0) {
  //    this.food--;
  //  }
  //}

  //void feed() {
  //  if (!this.white && this.food < 1000) {
  //    this.food += 10;
      
  //  }
  
}