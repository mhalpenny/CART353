// Matthew Halpenny - 26871771
// Random Video Assignment
// CART 353 - Feburary 6, 2018


//import nessesary libraries
import processing.video.*;
import java.util.Random;

//new capture object for video use
Capture video;

//random object 
Random generator;

//video scale variable allows size of draw reolution to be changed across sketch
int videoScale = 4;
int cols, rows;

//global rgb buffers for video manipulation (detecting movement)
float rBuff[] = new float[307201];
float gBuff[] = new float[307201];
float bBuff[] = new float[307201];
float r2Buff[] = new float[307201];
float g2Buff[] = new float[307201];
float b2Buff[] = new float[307201];

//boolean for switching between frames and detecting movement
boolean previous = false;

//z variables for height manipulation via noise
float z;
float zOff = 0;


void setup() {

  //size (1280, 960, P3D);
  fullScreen(P3D);

  //start video at the highest framerate
  video = new Capture(this, Capture.list()[0]);

  //start capture process
  video.start();

  //access video option array
  printArray(Capture.list());

  generator = new Random();

  // Initialize columns and rows for scaling, allows fullscreen mode with lower resolution video input
  cols = width/videoScale;
  rows = height/videoScale;
}

//declare capture event function to refresh frame when theres new pixel information available
void captureEvent(Capture video) {
  video.read();
}

void draw() {

  //refresh background with white
  background(255);

  //call video manipulation function
  randoVid();
}

//video manipulation function
void randoVid() {

  //load pixels into memory for sketch access
  loadPixels();
  video.loadPixels();

  //uses perlin noise to adjust poisitioning of video grid
  float zGrid = map(noise(zOff), 0, 1, 0, 100);

  //plane rotation push/pop
  pushMatrix();
  //translates the sketch to the center of the screen and moves it along the z axis according to noise
  translate(0, 100, (-100+zGrid));
  //rotates grid so z changes are more visible
  rotateX(PI/4);

  //nested for loop for running through the videos pixel array
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      
      //variables that allow scaling of the grid, this will be used for the x/y coordinates of the rectangles
      int x = i*videoScale;
      int y = j*videoScale;


      //deterine color values of current pixel at the given array location
      float r, g, b;
      r = red (video.pixels[i+j*video.width]);
      g = green (video.pixels[i+j*video.width]);
      b = blue (video.pixels[i+j*video.width]); 

      //check if the previous boolean is true or false
      if (previous == true) {
        
        //if true, write rgb values to the first buffer
        rBuff[i+j*video.width] = r;
        gBuff[i+j*video.width] = g;
        bBuff[i+j*video.width] = b; 

        //calculate difference in color between the current pixel and the last frame (stored in another buffer determined by the boolean)
        float d = dist(r, g, b, r2Buff[i+j*video.width], g2Buff[i+j*video.width], b2Buff[i+j*video.width]);
        
        //filter out small variations (noise) and large jumps that might affect the whole sketch
        if (d>50 && d<150) {
          //map the difference to a z value to move the rectangles affected
          z = map(d, 0, 255, 0, 200);
        }
      } else { //if the previous boolean is false, switch arrays 
        
        //write rgb values to the second buffer
        r2Buff[i+j*video.width]  = r;
        g2Buff[i+j*video.width]  = g;
        b2Buff[i+j*video.width]  = b;   

        //calculate difference in color between the current pixel and the last frame (stored in another buffer determined by the boolean)
        float d = dist(r, g, b, rBuff[i+j*video.width], gBuff[i+j*video.width], bBuff[i+j*video.width]);
        //filter out small variations (noise) and large jumps that might affect the whole sketch
        if (d>50 && d<150) {
          //map the difference to a z value to move the rectangles affected
          z = map(d, 0, 255, 0, 200);
        }
      }

      //determine random gaussian numbers
      float h = (float) generator.nextGaussian();

      //mean and standard deviation for adjusting gaussian numbers
      float mean = 30;
      float sd = 5;

      //add sd
      h *= sd;
      //add mean
      h = h + mean;
      
      //declare a z variable for adding noise to translating pixel squares when movement is detected
      float zNoise = map(noise(zOff), 0, 1, 0, 100);

      //store pixel color as a variable taken from current rgb, added with gaussian noise, and distorted by a multiplication of 2
      color c = color(r+h, g+h, b+h)*3;

      //push matrix for individual squares
      pushMatrix();
      //raise squares when movement is detected
      translate(0, 0, (z+zNoise));
      //fill squares with new pixel color
      fill(c);
      //add black stroke for more visible squares
      stroke(0);
      //draw squares instead of pixels at given intervals
      rect(x, y, videoScale, videoScale);
      //pop back square matrix
      popMatrix();
    }
  }
  //pops back grid matrix
  popMatrix();
  
  //a z variable that increaes per loop leading to an organic perlin noise movement of the sketch grid
  zOff = zOff + 0.01;

  //flips boolean for use with previous/current frame analysis
  previous ^= true;
}