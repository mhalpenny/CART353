//Poetry.dna alpha testing
//m halpenny


//--VARIABLES-----------------------------

//stores string results in variable as array
var result;
var alt;

//---------------------------------------

//before loading the page execute this function...
function preload() {
  //load string array from text file
  result = loadStrings('assets/test.txt');
  alt = loadStrings('assets/alt.txt');
}

function setup() {
createCanvas(windowWidth, windowHeight);
background(0);

//text properties...
fill(255);
textSize(24);
textAlign(CENTER);
//text box draw mode
rectMode(CENTER);

//run through poem array and output data
for(i=0;i<result.length;i++){
  
  if (i<4){
  text(result[i], width/2, height/2, 500, 200);
  }else{
   text(alt[i], width/2, height/2, 500, 200);
  }
}

////run through the alt array and output data
//for(i=0;i<alt.length;i++){
//  print(alt[i]);
//}

}

function draw() {

}

//function windowResized() {
//  resizeCanvas(windowWidth, windowHeight, [noRedraw]);
//}