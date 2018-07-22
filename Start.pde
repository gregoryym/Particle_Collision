//start the particle motion within the program
class Start {
  //variable that holds the background color
  int backColor = 70;
  //variable that holds the amount of particles
  int particleAmt;
  //maximum number of particles on the screen at once
  int maxParticles = 128;
  //variable for the class Tube
  Tube tube;
  //factor that is the initial factor for the motion of the particles
  final double INITIAL_FACTOR = 0.0010;
  //factor which is multipled for drawing on the screen .0055
  double factor = INITIAL_FACTOR;
  //spacing between particles that is detected when collided
  int collisionSpacing = 0;
  //variable that holds the value of the energy lost
  int energyLoss;
  //constructor function to start up the program
  public Start(int tubeX, int tubeY,int tubeLen, int tubeRadius, int particleAmt) {
    //variable to hold the class tube
    tube = new Tube(tubeX, tubeY, tubeLen, tubeRadius, particleAmt);
    //sets the argument to the particle amount variable
    this.particleAmt = particleAmt; 
  }
  
  //holds the code for each particles motion
  public void particleMotion() {
    //For loop for the motion of each particle in the window
    for (int i = 0; i < particleAmt; i++) {
      tube.findAngles();
//      tube.particles[i].particleStats(); 
      //the color of the particle is based on the atomic number - each atomic number for nonmetals has its own color
      //The RGB values for the particle is stored in the particle color array
      fill(tube.particles[i].particleColor[0], tube.particles[i].particleColor[1], tube.particles[i].particleColor[2]);  
      //each time this function is ran, the x velocity multipled by a factor (for drawing purposes) is added to the x coordinate 
      tube.particles[i].x += (tube.particles[i].velocityX * factor);
      //if the particle is completely off the screen then its going to teleport to (5,5)
      if (tube.particles[i].x < 15 || tube.particles[i].x > 490) {
         if (tube.particles[i].y < 10 || tube.particles[i].y > 240) {
           //changes the x position to 5
           tube.particles[i].x = 250;
           //changes the y position to 5
           tube.particles[i].y = 125;
           tube.particles[i].particleStats(); 
           //if the x velocity is negative then its going to be positive
           if (tube.particles[i].velocityX < 0) {
             //multiplies the x velocity by -1
              tube.particles[i].velocityX *= -1; 
           }
           //if the y velocity is negative then its going to be positive
           if (tube.particles[i].velocityY < 0) {
             //multiples the y velocity by -1
              tube.particles[i].velocityY *= -1; 
           }
         }
      }
      //if the particle is at the edge of the screen then the velocity is negated so the particle will go in the opposite direction
      //left and right of the screen
      if (tube.particles[i].x >= 475 || tube.particles[i].x <= 0) {
        //the velocity is negated so the particle will move in the opposite direction
        tube.particles[i].velocityX = tube.particles[i].velocityX * -1;
      }
      //each time this function is ran, the y velocity multipled by a factor (for drawing purposes) is added to the y coordinate 
      tube.particles[i].y += (tube.particles[i].velocityY * factor);
      //if the particle is at the edge of the screen the velocity is negated so the particle will move in the oppposite direction
      //top and bottom of the screen
      if (tube.particles[i].y >= 250 || tube.particles[i].y <= 0) {
        //the velocity is negated so the particle will move in the opposite direction
        tube.particles[i].velocityY = -tube.particles[i].velocityY;
      }
      
      checkCollision(i);
      
      //a circle is drawn at the x and y position of the particle and has a radius based on the atomic radius 
      ellipse(tube.particles[i].x,tube.particles[i].y,(int)tube.particles[i].drawRadius, (int)tube.particles[i].drawRadius);
      //if the particle has a dark color then the text will be white
      if (tube.particles[i].atomicNumber == 6 || tube.particles[i].atomicNumber == 36) {
        //the color white
        fill(255); 
      }
      //if the particle has a light color then text will be black
      else {
        //the color black
        fill(0);
      }
      //font size 15 for the tag
      textSize(11); 
      //stroke size of 10 
      stroke(10);
      //the text is the particles tag - the tag is based on the atomic Number
      //the tag is the atomic symbol
      text(tube.particles[i].tag, tube.particles[i].x - 5, tube.particles[i].y + 5);
    }   
    
    stats(); 
    
  }
  
  //checks to see if there is a collision between two collision
  public void checkCollision(int i) {
    
    //interates throught the list of particles
      for (int j = 0; j < particleAmt; j++) {
        //checks to see if there is a particle in that index
        if (tube.particles[j] != null) {
          //this if statement checks to see if the index of i is not equal to the index of j
          //index i is one index in the array and j is another index in the array
          //if they are equal they are the same particle
          if (i != j) {
            //energy loss for a particle
            energyLoss = 0;
            //colliding from the left side
            if (tube.particles[i].x + tube.particles[i].drawRadius <= tube.particles[j].x && tube.particles[i].x + tube.particles[i].drawRadius >= tube.particles[j].x - tube.particles[j].drawRadius - collisionSpacing) {
                //colliding from the top
                if (tube.particles[i].y + tube.particles[i].drawRadius <= tube.particles[j].y && tube.particles[i].y + tube.particles[i].drawRadius >= tube.particles[j].y - tube.particles[j].drawRadius - collisionSpacing) {
                  //variable that holds the total energy loss for a given j particle
                  energyLoss = tube.systemEnergy(tube.particles[i].atomicNumber, (int)tube.particles[j].kineticEnergy);
                  //calls the function to check if there was energy loss
                  checkEnergy(i, j); 
                }
                //colliding from the bottom
                else if (tube.particles[i].y - tube.particles[i].drawRadius >= tube.particles[j].y && tube.particles[i].y - tube.particles[i].drawRadius <= tube.particles[j].y + tube.particles[j].drawRadius + collisionSpacing) {
                  //variable that holds the total energy loss for a given j particle
                  energyLoss = tube.systemEnergy(tube.particles[i].atomicNumber, (int)tube.particles[j].kineticEnergy);
                  //calls the function to check if there was energy loss
                  checkEnergy(i, j);
                }
                //straight from the left side
                else if (tube.particles[i].y == tube.particles[j].y) {
                  //variable that holds the total energy loss for a given j particle
                  energyLoss = tube.systemEnergy(tube.particles[i].atomicNumber, (int)tube.particles[j].kineticEnergy);
                  //calls the function to check if there was energy loss
                  checkEnergy(i, j);
                }
            }
            //colliding from the right side
            if (tube.particles[i].x - tube.particles[i].drawRadius >= tube.particles[j].x && tube.particles[i].x - tube.particles[i].drawRadius <= tube.particles[j].x + tube.particles[j].drawRadius + collisionSpacing) {
                //colliding from the top
                if (tube.particles[i].y + tube.particles[i].drawRadius <= tube.particles[j].y && tube.particles[i].y + tube.particles[i].drawRadius >= tube.particles[j].y - tube.particles[j].drawRadius - collisionSpacing) {
                  //variable that holds the total energy loss for a given j particle
                  energyLoss = tube.systemEnergy(tube.particles[i].atomicNumber, (int)tube.particles[j].kineticEnergy);
                  //calls the function to check if there was energy loss
                  checkEnergy(i, j);
                }
                //colliding from the bottom
                else if (tube.particles[i].y - tube.particles[i].drawRadius >= tube.particles[j].y && tube.particles[i].y - tube.particles[i].drawRadius <= tube.particles[j].y + tube.particles[j].drawRadius + collisionSpacing) {
                  //variable that holds the total energy loss for a given j particle
                  energyLoss = tube.systemEnergy(tube.particles[i].atomicNumber, (int)tube.particles[j].kineticEnergy);
                  //calls the function to check if there was energy loss
                  checkEnergy(i, j);
                }
                //straight from the right side
                else if (tube.particles[i].y == tube.particles[j].y) {
                  //variable that holds the total energy loss for a given j particle
                  energyLoss = tube.systemEnergy(tube.particles[i].atomicNumber, (int)tube.particles[j].kineticEnergy);
                  //calls the function to check if there was energy loss
                  checkEnergy(i, j);
                }
            }
         }
       }
    }
  }

  //this function shows the stats and properties of a certain particle
  public void stats() {
    
    //holds the index for the particle
    int index = 0;
    
    //this for loop finds the index of the particle the mouse is hovering over
    for (int i = 0; i < particleAmt; i++) {
      
      //if the mouse has the same x and y coordinates as a particle in the array then the index variable is set to that particle
      //mouse has equal x coordinate to the particles x
      if (mouseX >= tube.particles[i].x - tube.particles[i].drawRadius && mouseX <= tube.particles[i].x + tube.particles[i].drawRadius) {
        //mouse has equal y coordinate to the particles y
        if (mouseY >= tube.particles[i].y - tube.particles[i].drawRadius && mouseY <= tube.particles[i].y + tube.particles[i].drawRadius) {       
          //the index is set to the particle in the array
          index = i;   
        }
      }  
    }
    
    //if the mouse is hovering over a particle then the if statement will run
    //mouse has to be equal to the particles x coordinate
    if (mouseX >= tube.particles[index].x - tube.particles[index].drawRadius && mouseX <= tube.particles[index].x + tube.particles[index].drawRadius) {
      //mouse has to be equal to the particles y coordinate
      if (mouseY >= tube.particles[index].y - tube.particles[index].drawRadius && mouseY <= tube.particles[index].y + tube.particles[index].drawRadius) {
         //the background will clear 
         clear();
         //the color of the background
         background(backColor);
         //only the particle the mouse is hovering over will appear
         //the color of the particle the mouse is hovering over
         fill(tube.particles[index].particleColor[0], tube.particles[index].particleColor[1], tube.particles[index].particleColor[2]);
         //only the particle the mouse is hovering over will be drawn
         ellipse((float)tube.particles[index].x, (float)tube.particles[index].y, (float)tube.particles[index].drawRadius, (float)tube.particles[index].drawRadius);
         //if the color of the particle is dark then the if statement will run
         if (tube.particles[index].atomicNumber == 6 || tube.particles[index].atomicNumber == 36) {
           //the color white
           fill(255); 
         }
        //if the particle has a light color then text will be black
        else {
          //the color black
          fill(0);
        }
        //font size 15 for the tag
        textSize(11); 
        //stroke size of 10 
        stroke(10);
        //the text is the particles tag - the tag is based on the atomic Number
        //the tag is the atomic symbol
        text(tube.particles[index].tag, tube.particles[index].x - 5, tube.particles[index].y + 5);
        
        //this if statement checks to see if the particle has a x coordinate greater than x coordinate of the center of the tube
        if (tube.particles[index].x >= tube.Cx) {
          //this if statement checks to see if the particle has a y coordinate greater than y coordinate of the center of the tube
          if (tube.particles[index].y >= tube.Cy) { 
            drawStatsBox(1, index);
          }
          //this if statement checks to see if the particles y coordinate is less than the y coordinate of the center of the tube
          else if (tube.particles[index].y <= tube.Cy) {
            drawStatsBox(0, index);
          }
        }
        //this if statement checks to see if the particles x is less than the x coordinate of the center of the tube
        else if (tube.particles[index].x <= tube.Cx) {
          //this if statement checks to see if the particles y is greater than the y coordinate of the center of the tube
          if (tube.particles[index].y >= tube.Cy) {          
            drawStatsBox(1, index);
          }
          //this if statement checks to see if the particles y is less than the y coordinate of the center of the tube
          else if (tube.particles[index].y <= tube.Cy) {
            drawStatsBox(1, index);
          }
        }
           
     }
   }
   
  }
  
  //function that draws the stats box for a given particle
  public void drawStatsBox(int value, int index) { 
    //if value = 0 then the box will be in the bottom right corner
    if (value == 0) {
      //rect is black
            fill(0);
            //draws a rect in the bottom right corner
            rect(tube.len - 205, (float)tube.radius - 110, 200, 100);
            //text is white
            fill(255);
            //prints text within the drawn rect in the bottom right corner
            text("Atomic Number: " + tube.particles[index].atomicNumber, tube.len - 200, 150);
            text("Atomic Radius: " + (float)tube.particles[index].atomicRadius, tube.len - 200, 170);
            text("Atomic Mass: " + (float)tube.particles[index].atomicMass, tube.len - 200, 190);
            text("Velocity: " + tube.particles[index].velocity, tube.len - 200, 210);
            text("Momentum: " + tube.particles[index].momentum, tube.len - 200, 230);     
    }  
    //if the value = 1 then the box will be in the top right corner
    else if (value == 1) {
     //the rectangle is black
            fill(0);
            //draws a rectangle in the top right corner of the tube
            rect(tube.len - 205, 5, 200, 100);
            //the text is white
            fill(255);
            //print text within the drawn rectangle in the top right corner
            text("Atomic Number: " + tube.particles[index].atomicNumber, tube.len - 200, 20);
            text("Atomic Radius: " + (float)tube.particles[index].atomicRadius, tube.len - 200, 40);
            text("Atomic Mass: " + (float)tube.particles[index].atomicMass, tube.len - 200, 60);
            text("Velocity: " + tube.particles[index].velocity, tube.len - 200, 80);
            text("Momentum: " + tube.particles[index].momentum, tube.len - 200, 100); 
    }
  }
 
  //a function that returns the particle count
  public int particleCount() {
    return particleAmt; 
  }

  public void checkEnergy(int i, int j) {
    //if the lost energy is not equal to zero the if statement will run
    if (energyLoss != 0) {
                    //changes the atomic number
                    tube.particles[i].atomicNumber = tube.newAtomicNum(tube.particles[i].atomicNumber);
                    tube.particles[j].atomicNumber = tube.newAtomicNum(tube.particles[j].atomicNumber);
                    //increases the particle amount
                    particleAmt += 2;
                    tube.particleAmt += 2;
                    //changes the stats of the particle
                    tube.particles[i].particleStats();
                    tube.particles[j].particleStats(); 
                    //if statement will run if the particle amount is less than 128 because thats the max number of particles on the screen at once
                    if (particleAmt <= maxParticles) { 
                      tube.particles[particleAmt - 2] = new Particle(tube.particles[j].x, tube.particles[j].y, tube.particles[j].atomicNumber, tube.particles[j].velocity);
                      //changes particlesStats
                      tube.particles[particleAmt - 2].particleStats();
                      //subtracts the energy that is lost
//                      tube.particles[i].kineticEnergy -= energyLoss;
                      //calculates the new velocity based on the energy
                      tube.particles[i].calcVelocity(energyLoss);
                      //subtracts the energy that is lost
//                      tube.particles[j].kineticEnergy -= energyLoss;
                      //calculates the new velocity based on the energy
                      tube.particles[j].calcVelocity(energyLoss);
                      //creates a new particle in the new index 
                      tube.particles[particleAmt - 1] = new Particle(tube.particles[i].x, tube.particles[i].y, tube.particles[i].atomicNumber, tube.particles[i].velocity);
                      //changes particlesStats
                      tube.particles[particleAmt - 1].particleStats();
                      tube.particles[particleAmt - 1].velocityY *= -1;
                    } 
                  }
                  else {
                     tube.particles[i].velocityX *= -1;
                     tube.particles[i].velocityY *= -1;
                  } 
  }
  
  
  
  
  
}