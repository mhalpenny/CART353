class Image {
  
  //class variables
  PImage img;
  String imgName;
 
  //constructor
  Image (String imgName){
    
    //load image into PImage variable using decalres name in setup
    img = loadImage(imgName);
  }
  
 //load pixels into processing memory 
  void load(){

    loadPixels();
    img.loadPixels();
   
   for (int x=0; x<width; x++){
     for (int y=0; y<height; y++){
       int loc = x+y*width;
      
       // runs through the pixel array and writes the Pimage pixels to the screen w/o updating
       pixels[loc] = img.pixels[loc];
     }}
  }
  
  //function that controls pixel manipulation/remixing of both images
    void customFilter(){
   
      //loops through pixel matrix for use in buffer variables below
   for (int x=0; x<width; x++){
     for (int y=0; y<height; y++){
       int loc = x+y*width;

     //mapping values for pixel manipulation via mouse movement across the screen
     float swap1 = map(mouseX, 0,  width, 0, 1);
     float swap2 = map(mouseX, 0, width, 1, 0);
     float fade1 = map(mouseY, 0, height, 0, 1);
     float fade2 = map(mouseY, 0, height, 1, 0);
     
     //if space bar is pressed add to an integer for manipulation ("scan lines")
     if (keyPressed){
       if (key == ' ') {
       space += 10;
     } 
      }

     // variables that make it easier to do a clean pixel manipulation below
     // as loop passes through pixel matrix it will grab the rgb buffer values and assign them to the color integer
     // swap and fade integers directly manipulate buffered rgb values before passing to the screen
     // swap buffer muliplies both image colors togehter depending on mouse position
     // fade buffer controls how trasparent each image is in output based on mouse values
     color swapBuff = color(rBuff[loc]*swap1, gBuff[loc]*swap1, bBuff[loc]*swap1) * color(rBuff[loc]*swap2, g2Buff[loc]*swap2, b2Buff[loc]*swap2);
     color fadeBuff = color(rBuff[loc]*fade1, gBuff[loc]*fade1, bBuff[loc]*fade1) + color(rBuff[loc]*fade2, g2Buff[loc]*fade2, b2Buff[loc]*fade2);
     
     //manipulate and draw pixels to the screen, can be rearranged for different outcomes
       pixels[loc] =  ((swapBuff+space) + fadeBuff) / 2;
   
       
      }
    }
        //updates pixels on the display window after the above manipulation.
        updatePixels();
    }
    

    
  void buffer1(){
    loadPixels();
    img.loadPixels();
   
   for (int x=0; x<width; x++){
     for (int y=0; y<height; y++){
       int loc = x+y*width;
       
      float r = red(img.pixels[loc]);
      float g = green(img.pixels[loc]);
      float b = blue(img.pixels[loc]);
       
       rBuff[loc] = r;
       gBuff[loc] = g;
       bBuff[loc] = b;
        
     }
   }
  }
    void buffer2(){
    loadPixels();
    img.loadPixels();
   
   for (int x=0; x<width; x++){
     for (int y=0; y<height; y++){
       int loc = x+y*width;
       
      float r = red(img.pixels[loc]);
      float g = green(img.pixels[loc]);
      float b = blue(img.pixels[loc]);
       
       r2Buff[loc] = r;
       g2Buff[loc] = g;
       b2Buff[loc] = b;
      
        
     }
   }
  }
  
}