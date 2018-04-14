//--VARIABLES-----------------------------
//the original string will be stored here
var s;
//create an empty string to translate array
var sTemp = '';
//create an output array for each line of of the displayed text
var output = [];
//line counter to subvert the need to map i to lines
var outputNum = 0;
var lineCount = 0;
//language analysis variables
var words, pos, add, nouns, rs, markov, undef;
var arrayFromPhp = [];


//--PRELOAD-----------------------------

//before loading the page execute this function...
function preload() {
  //load previous iteration of poem
  s = loadStrings('poem.txt');

  receiveData();
  //load training poems for markov generation
  sm = loadStrings('poems.txt');
  //font
  myFont = loadFont('assets/PitchTest-Regular.otf');
}

//--SETUP-----------------------------

function setup() {
  //create canvas, black background
  createCanvas(windowWidth, (windowHeight * 2));
  background(0);

  //text properties...
  fill(255);
  textFont(myFont);
  textSize(18);
  textAlign(CENTER);
  //text box draw mode
  rectMode(CENTER);

  //instantiate RiTa objects
  lexicon = new RiLexicon();
  //arguement represents n-grades and may be changed here
  markovSen = new RiMarkov(4);
  markovWor = new RiMarkov(3);

  //the training text to use in markov chains
  markovSen.loadText(sm.join(' '));
  markovWor.loadText(sm.join(' '));

  //run through poem array and compile string data for RiTa
  for (i = 0; i < s.length; i++) {
    //turns array into single string
    sTemp += s[i];
  }

  //instantiate the first output string for processing
  output[0] = '';

  //processes string for word and pos utility
  processRita();
  //creates mutations within the poem
  autopoesis();

}

//--ANALYSIS-----------------------------

function processRita() {

  //create a Rita string
  rs = RiString(sTemp);
  //analyze linguistics of the string
  words = rs.words();
  pos = rs.pos();

  //variable for noun counting
  //nouns = 0;

}


//--MUTATIONS-----------------------------

function autopoesis() {

  //compile an output string based on pos, nouns will be replaced randomly (mutations)
  for (var i = 0; i < words.length; i++) {
    //create a mutation number so only a fixed number can mutate
    var mutate = random(100);
    var addition = random(100);
    //variable for line mutation
    var lineBr = random(100);
    add = false;

    //if the part of speech is a noun, randomize an adjective addition
    if ((pos[i] === 'nn') && (addition <= 40)) {
      //output a random adjective
      output[outputNum] += lexicon.randomWord('jj');
      //add a space
      output[outputNum] += ' ';
      //add a words from the original string back into the output, after adjective
      output[outputNum] += words[i];
      //add a space
      output[outputNum] += ' ';
      //tell Rita a word has been added to avoid additional mutations on this word
      add = true;

    }
    // if the pos is a noun attempt to swap in a contextually appropriate word
    else if ((pos[i] === 'nn') && (mutate <= 90) && add == false) {

      //analyze the word and search for related tokens
      result = markovWor.getCompletions([words[i - 1]], [words[i + 1]]);
      if (result != null) {
        //choose a random from the array
        var rand = int(result.length / 2);

        console.log("1: " + result);
        console.log("2: " + result[rand]);

        if (result[rand] == undefined || result[rand] == " " || result[rand] == ",") {
          result = lexicon.randomWord('nn');
          console.log("3: " + result);
          //output the generated word
          //markers have been temporarily added for debugging
          output[outputNum] += "GENN ";
          output[outputNum] += result;
          output[outputNum] += " END";
          //add a space
          output[outputNum] += ' ';
        } else {
          //output the generated word
          //markers have been temporarily added for debugging
          output[outputNum] += "GENW ";
          output[outputNum] += result[rand];
          output[outputNum] += " END";
          //add a space
          output[outputNum] += ' ';
        }
      }
      // console.log("2: " + result.toString());
      //if null, return a random noun
      else {
        result = lexicon.randomWord('nn');
        console.log("4: " + result);
        //output the generated word
        //markers have been temporarily added for debugging
        // output[outputNum] += "GENN ";
        output[outputNum] += result;
        // output[outputNum] += " END";
        //add a space
        output[outputNum] += ' ';
      }
    }
    // if no mutations occur, reoutput the original word/article
    else {

      //add a words from the original string back into the output
      output[outputNum] += words[i];
      //add a space
      output[outputNum] += ' ';

    }
    //seperates line via mutation probability and possibly adds a markov sentence
    if (((i % 8 == 0) && (i != 0)) || (lineBr < 2)) {

      //increase output line count
      outputNum += 1;
      //instantiate new line
      output[outputNum] = '';

      //sentence probability
      var addSen = random(10);
      // if triggered, add a new markov sentence
      if (addSen < 2) {

        //generate a new markov sentence
        var sen = markovSen.generateSentence();
        //analyze generated string to get a word count for approx. length
        var riSen = RiString(sen);
        var senWords = riSen.words();


        //clip length if it exceeds the text box
        while (senWords.length >= 14) {
          //generate a new markov sentence
          sen = markovSen.generateSentence();
          //reanalyze the sentence while the loop is running
          //the loop will only break when the word count is sufficiently small
          riSen = RiString(sen);
          senWords = riSen.words();
          // console.log("M: " + senWords);
        }

        //output generated sentence with temporary markers
        output[outputNum] += "GEN ";
        output[outputNum] += sen;
        //increment line count
        outputNum += 1;
        //instantiate new line
        output[outputNum] = '';
      }
    }
  }

  //before exiting the mutation function, output the text
  //outputs text with line formatting using lineCount and looping
  for (var i = 0; i <= outputNum; i++) {

    //probability for a deletion mutation
    var delMut = random(20);
    if (delMut < 2) {

    } else {

      text(output[i], width / 2, (((height / 2) - 100) + (lineCount * 30)), 1000, 1000);
      lineCount++;
    }
  }

  //save rebuilt poem into the storage text file
  saveText();

}

//--SAVE-----------------------------

function saveText() {

  $.ajax({
  type: "POST",
  url: "saveToFile.php",
   data : {'stringData':output},
  success: function(resultData)
  {
    console.log("success");
  }
    });

}

//--LOAD-----------------------------

/**** function to retrieve data FROM  the appropriate json file:*/
function receiveData(){
  console.log("data incoming");
  var fileName = 'theContents.json';
  $.ajax({
    cache: false,
    url:fileName,
    success: function(data) {
        // do something now that the data is loaded
        $.each( data, function (index, value) {
          //debug
          console.log(value);
          // put each value into an array
          arrayFromPhp.push(value);
         	});
          console.log("done");
    }
   //this function will only run if we have an error
  });
}

//--TO IMPLEMENT-----------------------------
//function crossOver();
//function crossOverPoem();

// //passes text without modification
// function passPrev() {
//
//   //add a words from the original string back into the output
//   output[outputNum] += words[i];
//   //add a space
//   output[outputNum] += ' ';
//
// }
