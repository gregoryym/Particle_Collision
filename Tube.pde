

//This class holds the particles
public class Tube {
 //this variable was created so i dont have to dig deep into the code to change the atomic number and velocity
 double velocity = 8000;
 int atomicNumber = 54;
 
 //this is constant, based on the width of the window
 int len;
 //variables to calculate the volume
 double radius;
 double volume;
 
 //position on the window - for drawing
 int tubeX, tubeY;
 
 //coordinates for the center of the tube
 int Cx, Cy;
 
 //variable for the amount of particles 
 int particleAmt;
 
 //array of particles
 Particle particles[];
 
 //array of the angles for the particles
 double angle[];
 
 //constructor function - input a given radius for tube and how many particles are in the tube
 public Tube(int x, int y, int len, int radius, int particleAmt) {
  
   this.len = len;
   
   this.tubeX = x;
   this.tubeY = y;
   
   //center coordinates of the tube 
   Cx = len / 2;
   Cy = 250 / 2;

   //the value given in the argument is set to the variable
   this.radius = radius;
   this.particleAmt = particleAmt;
   
   //setting a given amount of particles to the array
   particles = new Particle[128];
   
   //setting the array for how many particles there are
   angle = new double[particleAmt];
   
   //calculates the volume of the tube
   volume = 2 * Math.PI * this.radius * this.radius * len;
   
   //change the argument if the window size changes
   int a;
   int b;
  
   //for loop to set each particle
   for (int i = 0; i < particleAmt; i++) { 
       
       a = (int)random(500);
       b = (int)random(250);
       
           
       //sets a particle class to the index i in the array
       particles[i] = new Particle(a, b, atomicNumber, velocity);
       particles[i].calcEnergy(); 
   }
          //finds the angle of the particle with respect to the horizontal
          findAngles();
          
          //for loop to iterate through the particle array and calculates the components of the velocities
          for(int i = 0; i < particleAmt; i++) {           
            particles[i].calcVelComp();           
          }
 }
  
   public void changeVelocity(double velocity) {
    
     this.velocity = velocity;
     
   }
   //function that finds the angle of the particles with respect to the horizontal
   public void findAngles() {
   
     //these variables are for holding values
     float a, b;
     
     //for loop to find the angle of each particle
     for (int i = 0; i < particleAmt; i ++) {
       
       //finds the x-distance between the particle and the center
       a = (float)Math.abs(Cx - particles[i].x);
       //finds the y-distance between the particle and the center
       b = (float)Math.abs(Cy - particles[i].y);
     
       //if the x coordinate of the particle is equal to the x coordinate of the center then manually set the angle
       //to PI/2
       //the angle has to be manually set because the tangent function is undefined at PI/2
       if (particles[i].x == tubeX) {
         //manually set the angle to PI/2
         particles[i].setAngle(PI/2);
       }
       //the angle can be calculated using the tangent function. The y distance over the x distance
       else {
         //tangent function equation 
         particles[i].setAngle(atan(b/a));   
     }   
    }   
   } 
   //reduces the atomic number
   public int newAtomicNum(int atomicNumber) {
     return atomicNumber / 2;
   }
   //aN1 is for the atomic number of particle 1 when it collides with a given energy of particle 2
   public int systemEnergy(int aN1, int energy2) {
     
     //if id number = 0 then that means there was not enough energy for the given atomicNumber
     //if id number = 1 then that means there was enough energy for the given atomicNumber and the atomic will divide
     int lostEnergy = 0;
     
     if (aN1 >= 2 && aN1 <= 5) {
       //required energy is 100 mil
       if (energy2 >= 100000000) {
         lostEnergy = 100000000;
       } 
     }
     //required energy is 50 mil
     else if (aN1 >= 6 && aN1 <= 15) {
       if (energy2 >= 50000000) {
        lostEnergy = 50000000; 
       }
     }
     //required energy is 10 mil
     else if (aN1 >= 16 && aN1 <= 25) {
       if (energy2 >= 10000000) {
         lostEnergy = 10000000;
       }
     }
     //required energy is 1 mil
     else if (aN1 >= 26 && aN1 <= 35) {
       if (energy2 >= 1000000) {
         lostEnergy = 1000000;
       }
     }
     //required energy is 100 K
     else if (aN1 >= 36 && aN1 <= 45) {
       if (energy2 >= 100000) {
          lostEnergy = 100000; 
       }
     }
     //required energy is 10 K
     else if (aN1 >= 46 && aN1 <= 55) {
       if (energy2 >= 10000) {
         lostEnergy = 10000;
       }
     }
     //required energy is 1K
     else if (aN1 >= 56) {
       if (energy2 >= 1000) {
         lostEnergy = 1000;
       }
     }
     return lostEnergy;
   } 
}