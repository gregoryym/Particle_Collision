//Class that makes the menu
public class Menu {
  
  //initial amount of particles
  int initialAmount = 2;
  //the particle count variable - initial set to the variable above
  int particleAmt = initialAmount;
  //motion of the particles true or false. The motion is set to true at first
  //this variable is for playing and pausing
  boolean motion = true;
  //starts the motion of the particles with the start class
  Start start = new Start(0, 0, 500, 250, particleAmt);
  
  //variable that holds the windows width and height
  int totalWidth, totalHeight;
  //variable that holds each boxes width and height
  int boxWidth, boxHeight;
  //number of boxes in the menu
  int boxNum = 6;
  //variable that holds a value that tells the program which window is open
  //0 - main screen
  //1 - stats window
  //2 - particles
  //3 - for all stats
  //4 - for individual stats
  int windowNum = 0;
  //number that was created by the user
  int number;
  
  //constructor function for the menu class
  public Menu(int WIDTH, int HEIGHT) {   
     
     //box width depends on the total width divided by the box number
     this.boxWidth = WIDTH / boxNum;
     //the box height is set to 90 
     this.boxHeight = 90;
     
     //The total width and height is set to the given arguement         
     totalWidth = WIDTH;
     totalHeight = HEIGHT;
     
  }
  
  public void showWindow() {
    //if 0 then the main screen will show 
    if (menu.windowNum == 0) {
      drawMain();
    }
    //if 1 then the stats window will be opened
    else if (windowNum == 1) {
      drawStats();
    }
    //if 2 then the particle list will be opened
    else if (windowNum == 2) {
      
    }
    //if 3 then its changing the stats for all the particles
    else if (windowNum == 3) {
      drawStatsAll();
    }
  }
  
  //function that draws the menu
  private void drawMain() { 
    clear();
    //fixes a glitch that changes the color of the background
    if (start.backColor != 70) {
      start.backColor = 70;
    }
    //color of the background 
    background(start.backColor);
    //particle amount is set the particle count function is the start class
    particleAmt = start.particleCount();
    //text for the particle count
    fill(255);
    //particle count text at the top left corner
    text("Particle Count: " + particleAmt, 5, 10);
    //starts the motion of the particles
    start.particleMotion();
    
    //for loop that creates each box in the menu 
    for (int i = 0; i < boxNum; i++) {
      //color of the menu
      fill(150);
      //resets the text Size
      textSize(11);
      //draws each box in the menu
      rect(boxWidth * i, 260, boxWidth, boxHeight);
      //if the box is number 1 then it will be the play button
      if (i == 0) {
        //color of the text that says play
        fill(0);
        //writes the text play
        text("PLAY", boxWidth/2 - 15, 260 + boxHeight / 2);
      }
      //if the box is number 2 then it will be the pause button
      else if (i == 1) {
        //color of the text that says pause
       fill(0);
       //writes the text pause 
       text("PAUSE", 3 * boxWidth/2 - 15, 260 + boxHeight/ 2);
      }
      //if the box is number 3 then it will be the change motion speed button
      else if (i == 2) {
        //color of the text that says change stats
       fill(0);
       //writes the text change stats
       text("SLOW MOTION", 5 * boxWidth/2 - 37, 260 + boxHeight/ 2);
      }
      //if the box is number 4 then it will be the change stats button
      else if (i == 3) {
        //color of the text that says change stats
       fill(0);
       //writes the text change stats
       text("RESTART", 7 * boxWidth/2 - 22, 260 + boxHeight/ 2);
      }
      //if the box is number 5 then it will be the list of particles button
      else if (i == 4) {
       //color of the text that says list of particles
       fill(0);
       //writes the text list of particles
       text("PARTICLES", 9 * boxWidth/2 - 25, 260 + boxHeight/ 2);
      }
      //if the box is number 6 then it will be the restart button
      else if (i == 5) {
        //color of the text
       fill(0);
       //writes the text restart
       text("STATS", 11 * boxWidth/2 - 18, 260 + boxHeight/ 2);
      }
    }
    
    //if the mouse is pressed on the box
    if (mousePressed == true) {
      //if the mouse is in the menu box area
       if (mouseY > 250) {
         
         //if the mouse is on the play button
         if (mouseX > 0 && mouseX < boxWidth) {
           //if the motion is not already true
           if (motion != true || start.factor != start.INITIAL_FACTOR){
             //interates through the array of particles
             for (int i = 0; i < particleAmt; i ++) {
              //starts the motion of the particle
               start.tube.particles[i].calcVelComp();
             }
             //sets the motion to true
             motion = true;
             //sets the drawing factor for motion back to the initial amount
             start.factor = start.INITIAL_FACTOR;
           }
         }
         //if the mouse is on the pause button
         else if (mouseX > boxWidth && mouseX < 2 * boxWidth) {
           //if the motion is not already false
           if (motion != false){
             //iterates through the array of particles 
             for (int i = 0; i < particleAmt; i ++) {
               //stops the motion of the particle
               start.tube.particles[i].velocityX = 0;
               start.tube.particles[i].velocityY = 0;
             }
             //sets the motion to false
             motion = false;
           }
         }
         //if the mouse is on the slow motion button
         else if (mouseX > 2 * boxWidth && mouseX < 3 * boxWidth) {
           //decreases the motion of the particles
           start.factor /= 10;
         }
         //if the mouse is on the change stats button 
         else if (mouseX > 3 * boxWidth && mouseX < 4 * boxWidth) {
           //sets the particles back to the original amount
           particleAmt = initialAmount; 
           //sets a new start class
           start = new Start(0, 0, 500, 250, particleAmt);
           //sets the motion to true
           motion = true;
         }
         //if the mouse is on the list of particles button
         else if (mouseX > 4 * boxWidth && mouseX < 5 * boxWidth) {
           windowNum = 0;
           print("5");
         }
         //if the mouse is on the restart button
         else if (mouseX > 5 * boxWidth && mouseX < 6 * boxWidth) {
           windowNum = 1;
           drawStats();
         }
       }
    }
    
  } 
  
  //draws the stats window to change the initial stats of the particles
  private void drawStats() {
    //clears the background from before
    clear();
    //makes the background the backColor again
    background(start.backColor);
    
    //draws the buttons for the stats window 
    fill(51);
    //for all particles button
    rect(100, 50, 300, 100);
    //individual particle button
    rect(100, 200, 300, 100);
    //back button
    rect(15, 15, 40, 20);
    
    //draws text on the buttons draw
    fill(255);
    text("CHANGE STATS FOR ALL PARTICLES", 150, 100);
    text("CHANGE STATS FOR INDIVIDUAL PARTICLES", 130, 250);
    text("BACK", 20, 30);
    
    if (mousePressed == true) {
      
      //if the if statement is true then the mouse is in the back button area
      if (mouseY > 15 && mouseY < 35) {
        if (mouseX > 15 && mouseX < 55) {
          //changes the window back to the main screen
          windowNum = 0;
        }
      }
      
      //if the if statement is true then the mouse is in the change stats for all
      if (mouseY > 50 && mouseY < 150) {
        if (mouseX > 100 && mouseX < 400) {
          windowNum = 1;
        }
      }
      
      //if the if statement is true then the mouse is in the change stats for individual
      if (mouseY > 200 && mouseY < 300) {
        if (mouseX > 100 && mouseX < 400) {
          //print("32");
        }
      }
     }
  } 
  
  private void drawStatsAll() {
    clear();
    background(start.backColor);
    NumPad();
    
    //color for buttons
    fill(51);
    //back button box 
    rect(75, 300, 150, 25);
    //apply button box
    rect(275, 300, 150, 25);
    //color of the text in the box
    fill(225);
    //text within the boxes
    text("BACK", 135, 318);
    text("APPLY", 340, 318);
    
    //if the if statement is true then the mouse is in the button area
      if (mousePressed == true) { 
        if (mouseY > 300 && mouseY < 325) {
          if (mouseX > 75 && mouseX < 225) {
            //changes the window back to the main screen
            windowNum =   1;
          }
          else if (mouseX > 275 && mouseX < 425) {
            //applies the given settings
            
          }
        }
      }
      
      
  }
  
  //draws an on screen number pad save space on the right side of the screen
  private void NumPad() {
    //inputted number
    int number = -1;
    //variables that draws the boxes for the x value
    int drawingXCounter = 475;
    //each box has a width of 58
    int drawingXSpacing = 58;
    //multiplier to change the location in the x direction
    int drawingXMultiplier = 4;
    
    //variables that draws the boxes for the y value
    int drawingYCounter = 275;
    //each box has a height of 56
    int drawingYSpacing = 56;
    //multiplier to change the location in the y direction
    int drawingYMultiplier = 4;
    
    //for loop that draws each box in the num pad
    for (int i = 12; i > 0; i--) {
      //subtracts from the multiplier to change where the box is located in the x direction
      drawingXMultiplier -= 1;
      //if its the last box in the row, a new row will be made
      if (drawingXMultiplier == 0) {
        //changes the multiplier for the location of the row
        drawingYMultiplier -= 1;
        //resets the x multiplier to start in the beginning of the row
        drawingXMultiplier = 3;
      }
      if (i == 3 || i == 1) {
        //nothing will show up in the bottom corner boxes
      }
      else {
        strokeWeight(1);
        fill(51);
        //draws a box with the given inputs
        rect(drawingXCounter - (drawingXMultiplier * drawingXSpacing), drawingYCounter - (drawingYMultiplier * drawingYSpacing), drawingXSpacing, drawingYSpacing);
        fill(255);
        //math im using gets negative one instead of zero
        if (i - 3 != -1) {
          //draws the number in the box 
          text(i - 3, drawingXCounter - (drawingXMultiplier * drawingXSpacing) + 29, drawingYCounter - (drawingYMultiplier * drawingYSpacing) + 28);
        }
        else {
          //instead of zero you get negative 1
          //this changes it to zero
          text(0, drawingXCounter - (drawingXMultiplier * drawingXSpacing) + 29, drawingYCounter - (drawingYMultiplier * drawingYSpacing) + 28);
        } 
      }    
    }
    
    //mouse locations and corresponding number on the num pad
    if (mousePressed) {
      if (mouseY > 51 && mouseY < 107) {
        if (mouseX > 301 && mouseX < 359) {
          number = 9;
        }
        else if (mouseX > 359 && mouseX < 417) {
          number = 8;
        }
        else if (mouseX > 417 && mouseX < 475) {
          number = 7;
        }
      }
      else if (mouseY > 107 && mouseY < 163) {
        if (mouseX > 301 && mouseX < 359) {
          number = 6;
        }
        else if (mouseX > 359 && mouseX < 417) {
          number = 5;
        }
        else if (mouseX > 417 && mouseX < 475) {
          number = 4;
        }
      }
      else if (mouseY > 163 && mouseY < 219) {
        if (mouseX > 301 && mouseX < 359) {
          number = 3;
        }
        else if (mouseX > 359 && mouseX < 417) {
          number = 2;
        }
        else if (mouseX > 417 && mouseX < 475) {
          number = 1;
        }
      }
      else if (mouseY > 219 && mouseY < 275) {
        if (mouseX > 359 && mouseX < 417) {
          number = 0;
        }
      }
    }
    
  }
  
}