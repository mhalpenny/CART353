 // Matthew Halpenny
 // CART 353 - Creative Computation II
 // January 22, 2017
 
 //image objects - see Image tab
 Image imageA;
 Image imageB;
 
 // ideally there would be a function to retrieve pixel count, but I couldn't 
 // get that function to work so since theres a fixed 500x500 grid im using a fixed pixel count 
 float rBuff[] = new float[250000];
 float gBuff[] = new float[250000];
 float bBuff[] = new float[250000];
 float r2Buff[] = new float[250000];
 float g2Buff[] = new float[250000];
 float b2Buff[] = new float[250000];

//global save variable
int save = 1;
int space;
 
 void setup(){
   size(500, 500);
   
   //initialize classes, allows images to be changed across entire sketch
   imageA = new Image("crystal.jpg");
   imageB = new Image("arch.jpg");
   
 }
 
 
 void draw(){
   
   //loads pixels into memory
   imageA.load();
   imageB.load();
   //sends rgb values to a global buffer for post-loop manipulation (see functions)
   imageA.buffer1();
   imageB.buffer2();
   //mix effect one
   imageA.customFilter();
   //scans for save prompt
   saveImage();
   
   
   
   
   
   
 }