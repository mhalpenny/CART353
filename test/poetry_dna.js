//--VARIABLES----------------------------
var sm, myFont, rs, words, pos, lineNum, maxLine;
var possibleStrings = ["test A", "test B", "test C", "test D", "test E", "test F", "test G", "test H"];
var arrayFromPhp = [];
var lineArrayBuffer = [];
var lineArray = [];
var mutationArray = [];
//--PRELOAD------------------------------

//before loading the page execute this function...
function preload() {
  //recieve JSON data
  receiveData();
  //load training poems for markov generation
  // sm = loadStrings('assets/poems.txt');
  //font
  myFont = loadFont('assets/PitchTest-Regular.otf');
}

//--SETUP--------------------------------

function setup() {
  //create canvas, black background
  createCanvas(windowWidth, (windowHeight * 2));
  background(0);
  frameRate(1);

  //instantiate RiTa objects
  lexicon = new RiLexicon();
  //arguement represents n-grades and may be changed here
  markovSen = new RiMarkov(4);
  markovWor = new RiMarkov(3);

}

function draw() {
  background(0);
  //text properties...
  fill(255);
  textFont(myFont);
  textSize(18);
  textAlign(CENTER);
  //text box draw mode
  rectMode(CENTER);

  lineNum = 0;
  mutationArray[0] = '';
  //analyze text through RiTa for mutations
  analysis();
  //display text
  outputText();
  // saveText();

}

//--ANALYSIS-----------------------------

function analysis() {

  for (var i = 0; i < arrayFromPhp.length; i++) {
    // each entry in the file has a label "line" - whose value is an array of strings
    lineArray = arrayFromPhp[i].line;
    // go through the array of strings and display
    for (var j = 0; j < lineArray.length; j++) {
      //temp string for rita
      var sTemp = lineArray[j];
      maxLine = lineArray.length;
      //create a Rita string
      rs = RiString(sTemp);
      console.log("RiTa " + rs);
      //analyze linguistics of the string
      words = rs.words();
      console.log("words " + words);
      pos = rs.pos();
      //mutates word array
      mutate();
    }
  }
}

//--MUTATIONS------------------------------

function mutate() {

  for (var i = 0; i < words.length; i++) {
    var mutate = random(100);
    if ((pos[i] === 'nn') && (mutate <= 40)){
      var missense = lexicon.randomWord('nn');
      mutationArray[lineNum] += missense;
      mutationArray[lineNum] += " ";
    } else{
      mutationArray[lineNum] += words[i];
      mutationArray[lineNum] += " ";
    }
    }
    lineNum++;
    // console.log(mutationArray[lineNum]);
    // console.log(lineNum + " " + mutationArray[i]);
    if (lineNum < maxLine){
      mutationArray[lineNum] = '';
    }

  }

  //--OUTPUT---------------------------------

  // function outputText() {
  //
  //   var offsetY = 0;
  //   for (var i = 0; i < arrayFromPhp.length; i++) {
  //     // each entry in the file has a label "line" - whose value is an array of strings
  //     lineArray = arrayFromPhp[i].line;
  //     // go through the array of strings and display
  //     for (var j = 0; j < lineArray.length; j++) {
  //
  //       offsetY += 20;
  //
  //       text("this is a test" + lineArray[j], width / 2, height / 2 + offsetY, 500, 500);
  //     }
  //   }
  // }

  function outputText() {

    var offsetY = 0;
    for (var i = 0; i < maxLine; i++) {

        offsetY += 20;

        text(mutationArray[i], width / 2, height / 2 + offsetY, 500, 500);
        console.log(i + " " + mutationArray[i]);
      }
      saveData();
      noLoop();
    }


  //--SAVE-----------------------------------

  // // this is just a test function to generate an array of random strings
  // function fillWithRandomStrings() {
  //   for (var i = 0; i < 4; i++) {
  //     var randomIndex = parseInt(random(0, 8));
  //     lineArrayBuffer[i] = possibleStrings[randomIndex];
  //
  //   }

  // }

  function saveData() {
    console.log("send data");
    $.ajax({
      type: "POST",
      url: "saveToFile.php",
      data: {
        'stringData': mutationArray
      },
      success: function(resultData) {
        console.log("success");
      }
    });
  }

  //--LOAD-----------------------------

  /**** function to retrieve data FROM  the appropriate json file:*/
  function receiveData() {
    console.log("data incoming");
    var fileName = 'lineFormat.json';
    $.ajax({
      cache: false,
      url: fileName,
      success: function(data) {
        // do something now that the data is loaded
        $.each(data, function(index, value) {
          //debug
          console.log(value);
          // put each value into an array
          arrayFromPhp.push(value);
        });
        console.log("done");
      }
    });
  }
