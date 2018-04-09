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
  data = loadStrings('nervous.txt');
  // alt = loadStrings('assets/alt.txt');
}

function setup() {
createCanvas(windowWidth, (windowHeight*2));
background(0);

//text properties...
fill(255);
textSize(18);
textAlign(CENTER);
//text box draw mode
rectMode(CENTER);

//run through poem array and output data
// for(i=0;i<result.length;i++){
//
//   if (i<4){
//   text(result[i], width/2, height/2, 500, 200);
//   }else{
//    text(alt[i], width/2, height/2, 500, 200);
//   }
// }

var rm = new RiMarkov(2);
rm.loadText(data.join(' '));
var sentences = rm.generateSentences(8);

text(sentences, width/2, (height/2 - 100), 800, 600);


}

function draw() {

}

//function windowResized() {
//  resizeCanvas(windowWidth, windowHeight, [noRedraw]);
//}
