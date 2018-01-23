//seperate tab because its not object oriented but an auxillary function
 
 void saveImage(){
      
  if (keyPressed) {
    if (key == 'm' || key == 'M') {
      save("remix"+save+".jpg");
      save++;
    } 
  }
    
  }