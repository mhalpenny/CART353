// Matthew Halpenny - 26871771
// Random Video Assignment
// CART 353 - Feburary 6, 2018


//import necessary libraries for video and random number generation (Gaussian)
import processing.video.*;
import java.util.Random;

//new capture object for webcam use
Capture video;

//random object for Gaussian numbers
Random generator;

// the videoScale variable allows global resizing of the square grid in which the video is mapped to - cols, rows will be used in the mathematics of scaling.
int videoScale = 4;
int cols, rows;

//These are global RGB buffers for use is video manipulation.
//A section of the code in randoVid() uses a boolean to switch between storing values in these two buffers.
//They are then compared with each other to detect if a threshold has been passed in the color differences of the pixels, which detects movement.
float rBuff[] = new float[307201];
float gBuff[] = new float[307201];
float bBuff[] = new float[307201];
float r2Buff[] = new float[307201];
float g2Buff[] = new float[307201];
float b2Buff[] = new float[307201];

//the boolean previous is used for comparing video frames.
//The variable switchs every frame and sends pixel values into different buffers for movement detection
boolean previous = false;

//z variables for height manipulation
//z will be used with the movemetn detection code
float z;
//zOff is used with Perlin noise to create a dynamic canvas
float zOff = 0;


void setup() {

  //initialize size at fullscreen
  fullScreen(P3D);

  //instatiate the capture object with a capture.list() function
  //starts the video at the highest resolution & framerate
  video = new Capture(this, Capture.list()[0]);

  //start capture process
  video.start();

  //access video option array
  printArray(Capture.list());

  //instantiates random object for Gaussian noise
  generator = new Random();

  // Initialize columns and rows for scaling, allows fullscreen mode with lower resolution video input
  cols = width/videoScale;
  rows = height/videoScale;
}

//declare capture event function to refresh frame when theres new pixel information available
//ensures processing power isnt overused when new frames arent ready
void captureEvent(Capture video) {
  video.read();
}

void draw() {

  //refresh background with white color
  background(255);

  //call video manipulation function
  randoVid();
}

//video manipulation function
void randoVid() {

  //load pixels into memory for sketch access
  loadPixels();
  video.loadPixels();

  //generates perlin noise for use in adjust poisitioning of 3D video grid
  float zGrid = map(noise(zOff), 0, 1, 0, 100);

  //plane rotation push/pop to draw 3D grid
  pushMatrix();
  //translates the sketch to the center of the screen and moves it along the z axis according to noise
  translate(0, 100, (-100+zGrid));
  //rotates grid so z changes are more visible
  rotateX(PI/4);

  //nested for loop for running through the videos pixel array
  //uses cols and rows to determine how often to grab pixel colors, which is dependent on the sketch scale
  //allows faster processing and a wider canvas when resolution is limited
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {

      //variables that allow scaling of the grid, this will be used for the x/y coordinates of the rectangles
      int x = i*videoScale;
      int y = j*videoScale;


      //deterine RGB color values of current pixel at the given pixel array location
      //declare local color variables
      float r, g, b;
      //access pixel array at [i+j*video.width] - function for 1D array position
      r = red (video.pixels[i+j*video.width]);
      g = green (video.pixels[i+j*video.width]);
      b = blue (video.pixels[i+j*video.width]); 

      //check if the previous boolean is true or false
      if (previous == true) {

        //if true, write rgb values to the first RGB buffer array
        //these will be used to detect motion
        rBuff[i+j*video.width] = r;
        gBuff[i+j*video.width] = g;
        bBuff[i+j*video.width] = b; 

        //calculate difference in color between the current pixel and the pixels within the last frame (stored in another buffer determined by the boolean)
        //uses the dist function to calculate the differences of all the rgb values and outputs a general score
        float d = dist(r, g, b, r2Buff[i+j*video.width], g2Buff[i+j*video.width], b2Buff[i+j*video.width]);

        //use the above variable d's score to map a z value for height
        //filter out small variations (noise) and large jumps that might affect the whole sketch
        if (d>50 && d<150) {
          //map the difference value to a z value that will move the rectangles affected
          z = map(d, 0, 255, 0, 200);
        }
      } else { //if the previous boolean is false, switch arrays 

        //if false, write rgb values to the second RGB buffer array
        //these will be compared for detect motion
        r2Buff[i+j*video.width]  = r;
        g2Buff[i+j*video.width]  = g;
        b2Buff[i+j*video.width]  = b;   

        //calculate difference in color between the current pixel and the pixels within the last frame (stored in another buffer determined by the boolean)
        //uses the dist function to calculate the differences of all the rgb values and outputs a general score
        float d = dist(r, g, b, rBuff[i+j*video.width], gBuff[i+j*video.width], bBuff[i+j*video.width]);
       
        //use the above variable d's score to map a z value for height
        //filter out small variations (noise) and large jumps that might affect the whole sketch
        if (d>50 && d<150) {
          //map the difference value to a z value that will move the rectangles affected
          z = map(d, 0, 255, 0, 200);
        }
      }

      //determine random gaussian numbers using the generator object and assign them to a float, h
      float h = (float) generator.nextGaussian();

      //mean and standard deviation for adjusting gaussian numbers
      float mean = 30;
      float sd = 5;

      //since the gaussian object will output values between -1 and 1, so it must be multiplied by the stadard deviation so it will deviate by -sd to sd
      h *= sd;
      //add the mean to whatever is outputted by the sd, this will bump up the number to the desired range (0 -> new mean +- sd).
      h = h + mean;

      //declare a z variable for adding noise to the translated pixel squares when movement is detected
      //the Perlin noise will cause the squares to float up and down slightly making it look as if they were disturbed.
      float zNoise = map(noise(zOff), 0, 1, 0, 100);

      //store pixel color as a variable taken from the videos current rgb value and manipulate it 
      // it is manipulated by adding gaussian noise for a static effect
      //the color range is distorted by a multiplication of 3 to make the squares appear more ugly / pop-arty depedning on the input
      color c = color(r+h, g+h, b+h)*3;

      //push matrix for individual squares within the grid
      pushMatrix();
      //raise squares when movement is detected
      //the z perlin noise is added to the movement value for organic rising and falling
      translate(0, 0, (z+zNoise));
      //fill squares with the new pixel color stored in c
      fill(c);
      //add black stroke for more visible squares
      stroke(0);
      //draw squares instead of pixels at given intervals (x,y) determined by scale
      //squares allow larger canvas use and allocates more processing power to manipulating the video
      rect(x, y, videoScale, videoScale);
      //pop back individual square matrix
      popMatrix();
    }
  }
  //pops back 3D grid matrix
  popMatrix();

  //a z variable that increaes per loop leading to an organic perlin noise movement of the 3D grid matrix
  zOff = zOff + 0.01;

  //flips boolean for use with previous/current frame analysis in movement detection algorithmn
  previous ^= true;
}