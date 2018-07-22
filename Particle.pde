//class for each particle in the window
public class Particle {
  
  //variables for the particle
  //variable that holds the atomic number of the particle - the atomic number is an important part of the program
  int atomicNumber;
  //variable that holds the atomic mass of a particle - this can be predicted based on the atomic number
  double atomicMass;
  //variable that holds the mass of the particle - this can be predicted based on the atomic mass
  double mass;
  //variable that holds the atomic radius - this can be predicted based on the atomic number
  double atomicRadius;
  //variable that holds the draw radius - this is for drawing purposes
  double drawRadius;
  //variable that holds the energy of a particle - energy can be lost in a collision
  double kineticEnergy;
  //variable that holds the velocity of the particle
  double velocity;
  //the variable that holds the x-component of the velocity
  double velocityX;
  //the variable that holds the y-component of the velocity
  double velocityY;
  //the variable that holds the momentum of the particle
  double momentum;
  //the variable that holds the angle the particle makes with respect to the horizontal
  float angle;
  //the x and y coordinates of the particle
  int x, y;
  //the tag of a particle - this is based on the atomic number. Differenet numbers have different tags
  //the tag is the atomic symbol 
  String tag;
  //every particle has its own color - color is based on the atomic number
  //the array holds the RGB value of the particle
  int particleColor[];
  
  //constructor function for the particle class - gets an atomic number
  public Particle(int x, int y, int atomicNumber, double intVelocity) {
    
    //x and y coordinates of the particle 
    this.x = x;
    this.y = y;
    
    //the initial velocity is set to the particles velocity
    velocity = intVelocity;
    
    //sets the argument to the class variables
    this.atomicNumber = atomicNumber;
    
    particleStats();
  }
  
  //calculates the energy of the particle based on its velocity
  public void calcEnergy() {  
    //calculates the energy with the kinetic energy equation
    this.kineticEnergy = 0.5 * this.atomicNumber * this.velocity * this.velocity; 
  }
  //calculates stats with a line of best fit 
  public void particleStats() {
    //line of best fit for the atomic radius based on the atomic number
    atomicRadius = (double)28.066 * (log(atomicNumber)/log((float)Math.E)) + 18.239;
    //drawRadius is based on the atomic radius multiplied by a factor for drawing purposes
    drawRadius = atomicRadius * 1/4;
    //the atomic mass is based on the atomic number and is estimated by the equation
    atomicMass = ((0.0064)*degree(2) + (2.0949 * atomicNumber) - 1.0889);
    //calls the function to calculated the energy of the particle based on the given velocity
    calcEnergy();
    //sets up the array for the color of the particle
    particleColor = new int[3];
    //calls the color function
    getColor();
    calcVelComp();
    momentum = atomicNumber * velocity;
  }
  //calculates the velocity of the particle based on its energy
  public void calcVelocity(int energy) {
    //decreased the kinetic energy by the energy loss
    //kineticEnergy -= energy; 
    //calculates the velocity with the kinetic energy equation 
    this.velocity = (int)sqrt((float)(2*kineticEnergy)/(float)atomicNumber);   
  }
  
  //calculates the velocity components based on the angle
  public void calcVelComp() {
    //x component of the velocity equation
    velocityX = this.velocity * cos(angle);
    //y component of the velocity equation
    velocityY = this.velocity * sin(angle);
  }
  
  //sets the angle of the particle to the given argument
  public void setAngle(float angle) {
    //sets the argument to the angle
    this.angle = angle;
  }
  
  //multiples the atomic number by it self n times - input an n value
  private int degree(int n) {
    //value holder 
    int d = 0; 
    //for loop that multiples atomic number by it self n times
    for (int i = 0; i <= n; i ++) {
      if (i == 0) {
        d = 1;
      }
      else {
        d = d * atomicNumber;
      }   
    }  
    //returns the value 
    return d;   
  }
  
  //every atomic number for nonmetals have different colors and a different tag
  //the particle color array holds the RGB value of the particle and the tag is the atomic symbol      
  private void getColor() {
   
    //red - Hydrogen
    if (atomicNumber == 1) {
      particleColor[0] = 255;
      particleColor[1] = 0;
      particleColor[2] = 0;
      
      tag = "H";
    }
    //Blue - Helium
    else if (atomicNumber == 2) {
      particleColor[0] = 0;
      particleColor[1] = 0;
      particleColor[2] = 255; 
      
      tag = "He";
    }
    //Black - Carbon
    else if (atomicNumber == 6) {
      particleColor[0] = 0;
      particleColor[1] = 0;
      particleColor[2] = 0;  
      
      tag = "C";
    }
    //Light Blue - Nitrogen
    else if (atomicNumber == 7) {
      particleColor[0] = 88;
      particleColor[1] = 254;
      particleColor[2] = 252; 
      
      tag = "N";
    }
    //Orange - Oxygen
    else if (atomicNumber == 8) {
      particleColor[0] = 239;
      particleColor[1] = 178;
      particleColor[2] = 0;  
      
      tag = "O";
    }
    //Green - Flourine
    else if (atomicNumber == 9) {
      particleColor[0] = 0;
      particleColor[1] = 255;
      particleColor[2] = 0; 
      
      tag = "F";
    }
    //Neon Green - Neon
    else if (atomicNumber == 10) {
      particleColor[0] = 41;
      particleColor[1] = 206;
      particleColor[2] = 0;  
      
      tag = "Ne";
    }
    //Dark Purple - Phsohorus
    else if (atomicNumber == 15) {
      particleColor[0] = 155;
      particleColor[1] = 0;
      particleColor[2] = 209;  
      
      tag = "P";
    }
    //Yellow - Sulfur
    else if (atomicNumber == 16) {
      particleColor[0] = 247;
      particleColor[1] = 245;
      particleColor[2] = 59;  
      
      tag = "S";
    }
    //White - Chlorine
    else if (atomicNumber == 17) {
      particleColor[0] = 255;
      particleColor[1] = 255;
      particleColor[2] = 255; 
      
      tag = "Cl";
    }
    //Light Purple - Argon
    else if (atomicNumber == 18) {
      particleColor[0] = 215;
      particleColor[1] = 31;
      particleColor[2] = 255;  
      
      tag = "Ar";
    }
    //Pink - Selenium
    else if (atomicNumber == 34) {
      particleColor[0] = 255;
      particleColor[1] = 119;
      particleColor[2] = 58;  
      
      tag = "Se";
    }
    //Brown - Bromine
    else if (atomicNumber == 35) {
      particleColor[0] = 177;
      particleColor[1] = 119;
      particleColor[2] = 58; 
      
      tag = "Br";
    }
    //Grey - Krypton
    else if (atomicNumber == 36) {
      particleColor[0] = 95;
      particleColor[1] = 96;
      particleColor[2] = 91;
      
      tag = "Kr";
    }
    //Light Grey - Iodine
    else if (atomicNumber == 53) {
      particleColor[0] = 244;
      particleColor[1] = 244;
      particleColor[2] = 244;  
      
      tag = "I";
    }
    //Hot Pink - Xeon
    else if (atomicNumber == 54) {
      particleColor[0] = 255;
      particleColor[1] = 0;
      particleColor[2] = 157;
      
      tag = "Xe";
    }
    //Some kind of light purple-blue - for any other atomicNumber
    else {
      particleColor[0] = 216;
      particleColor[1] = 188;
      particleColor[2] = 255;
      
      tag = "Unk";
    }
  }

}