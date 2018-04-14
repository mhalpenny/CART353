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
  data = loadStrings('poems.txt');
  // alt = loadStrings('assets/alt.txt');
}

function setup() {
createCanvas(windowWidth, (windowHeight));
background(0);

//text properties...
fill(255);
textSize(16);
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

var rm = new RiMarkov(5);
rm.loadText(data.join(' '));
var sentences = rm.generateSentences(10);

console.log(sentences);

var offsetY = 0;
for(var i = 0; i<sentences.length; i++){
text(sentences[i], width/2, (height/2)+(300+offsetY), 1200, 1000);
offsetY += 20;
}

}

function draw() {

}

//function windowResized() {
//  resizeCanvas(windowWidth, windowHeight, [noRedraw]);
//}
