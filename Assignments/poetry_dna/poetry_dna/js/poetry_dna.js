var s;
//create an empty string to translate array
var sTemp = '';
var geneLength;
//create an output RiString
var output = [];
//line counter
var outputNum = 0;

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
  for (i = 0; i < s.length; i++) {
    sTemp += s[i];
  }

  console.log(s[0]);

  //instantiate output strings
  output[0] = '';
  //process through rita
  processRita();


}

function processRita() {

  //create a Rita string
  var rs = RiString(sTemp);
  //analyze linguistics of the string
  var words = rs.words();
  var pos = rs.pos();
  var add = false;
  // console.log(words);
  // console.log(pos);

  //variable for noun count
  var nouns = 0;
  //calculate the number of nouns in the string
  for (var i = 0; i < pos.length; i++) {
    if (pos[i] === 'nn') {
      //add one to variable
      nouns += 1;
    }
  }

  //compile an output string based on pos, nouns will be replaced randomly (mutations)
  for (var i = 0; i < words.length; i++) {
    //create a mutation number so only a fixed number can mutate
    var mutate = random(nouns);
    var addition = random(nouns);
    //variable for line mutation
    var lineBr = random(100);
    //if the part of speech is a noun, randomize it
    if ((pos[i] === 'nn') && (addition < (nouns) / 6)) {
      //output a random adjective
      output[outputNum] += lexicon.randomWord('jj');
      //add a space
      output[outputNum] += ' ';
      //add a words from the original string back into the output
      output[outputNum] += words[i];
      //add a space
      output[outputNum] += ' ';
      //tell Rita a word has been added
      add = true;
    } else if ((pos[i] === 'nn') && (mutate < (nouns) / 3) && add == false) {
      //output a random noun
      output[outputNum] += lexicon.randomWord('nn');
      //add a space
      output[outputNum] += ' ';
    } else if (((i % 8 == 0) && (i != 0)) || (lineBr < 2) ) {

      outputNum += 1;
      output[outputNum] = '';

    } else {
      //add a words from the original string back into the output
      output[outputNum] += words[i];
      //add a space
      output[outputNum] += ' ';
    }
    // console.log(i);
  }

//outputs text with line formatting
  for (var i = 0; i < outputNum; i++) {
    text(output[i], width / 2, ((height / 2)+(i*20)), 500, 500);
  }
  // text(output[0], width / 2, height / 2, 500, 500);
  // text(output[1], width / 2, height / 2, 500, 500);
  // text(output[2], width / 2, height / 2, 500, 500);
  // text(output[3], width / 2, height / 2, 500, 500);
  saveText();

}

function saveText() {

  $.ajax({
    type: "POST",
    url: "saveToFile.php",
    data: {
      'stringData': output
    },
  });

}
//function crossOver();
//function crossOverPoem();
