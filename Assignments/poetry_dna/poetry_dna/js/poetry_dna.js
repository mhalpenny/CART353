var s;
//create an empty string to translate array
var sTemp = '';

//before loading the page execute this function...
function preload() {
  //load string array from text file
  s = loadStrings('poem.txt');

}

function setup() {
  createCanvas(windowWidth, windowHeight);
  background(0);

  //text properties...
  fill(255);
  textSize(18);
  textAlign(CENTER);
  //text box draw mode
  rectMode(CENTER);

  lexicon = new RiLexicon();

  //starting string
  // s = "Now mind is clear as a cloudless sky. Time then to make a home in wilderness.";

  //run through poem array and compile string data for Rita
  for(i=0;i<s.length;i++){
    sTemp += s[i];
  }

  console.log(s[0]);

  //process through rita
  processRita();

}

function processRita() {

  //create a Rita string
  var rs = RiString(sTemp);
  //analyze linguistics of the string
  var words = rs.words();
  var pos = rs.pos();
  // console.log(words);
  // console.log(pos);

  //create an output RiString
  var output = '';
  //variable for noun count
  var nouns = 0;
  //calculate the number of nouns in the string
  for (var i = 0; i < pos.length; i++){
    if (pos[i] === 'nn') {
      //add one to variable
       nouns += 1;
    }
  }

  //compile an output string based on pos, nouns will be replaced randomly (mutations)
  for (var i = 0; i < words.length; i++) {
    //create a mutation number so only a fixed number can mutate
    var mutate = random(nouns);
    //if the part of speech is a noun, randomize it
    if ((pos[i] === 'nn') && (mutate < (nouns)/6)) {
      //output a random noun
      output += lexicon.randomWord('nn');
      //add a space
      output += ' ';
    } else {
      //add a words from the original string back into the output
      output += words[i];
      //add a space
      output += ' ';
    }
    // console.log(i);
  }

  text(output, width / 2, height / 2);

$.ajax({
type: "POST",
url: "saveToFile.php",
 data : {'stringData':output},
success: function(resultData){
          alert("Save Complete");
      }
});
}
