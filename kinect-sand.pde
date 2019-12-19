import SimpleOpenNI.*;
import processing.serial.*;
import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;


boolean DEBUG = true; 

// The world
ArrayList<Particle> particles;
Box2DProcessing Box2d;    
Ground ground;

// The controls and Kinect
SimpleOpenNI kinect;
DebugControls debugControls;



void setup() {
  colorMode(HSB, 360, 100, 100);
  //fullScreen();
  size(640, 480); // 

  //pixelDensity(2);
  smooth();

  if (DEBUG) {
      debugControls = new DebugControls();
  } else {
      kinect = new SimpleOpenNI(this);
      kinect.enableDepth();
      kinect.enableUser();// because of the version this change
      fill(255, 0, 0);
      kinect.setMirror(false);
  }

  
  // Initialize and create the Box2d world
  Box2d = new Box2DProcessing(this);  
  Box2d.createWorld();
  Box2d.listenForCollisions();
  ground = new Ground();
  
  // Create ArrayLists
  particles = new ArrayList<Particle>();
}


void draw() {  

  // Background
  fill(0, 6, 2, 30);
  noStroke();
  rectMode(CORNER);
  rect(0, 0, width, height);
  
  tint(255, 20);

  if (DEBUG) {  
      debugControls.update();
  } else {
      kinect.update();
      pushMatrix();
      PImage depthImage = kinect.depthImage();
      scale(2);
      image(depthImage, 0, 0); //depthImage.width * 2, depthImage.height * 2);
      popMatrix();
  }
  
  
  Box2d.step();    
  
  
  if (DEBUG) {
    debugControls.update();
    debugControls.draw();
  } else {
    IntVector userList = new IntVector();
    kinect.getUsers(userList); // mutating
    println(userList.size());
    if (userList.size() > 0) {
      int userId = userList.get(0);
      //If we detect one user we have to draw it
      if (kinect.isTrackingSkeleton(userId)) {
        drawSkeleton(userId);
      }
    }
  }
  
  // Display and update all the particles
  //println(particles.size());
  for (int i = 0; i < particles.size(); i++) {
      Particle b = particles.get(i);
      b.update();
      b.display();  
  }
}


//Calibration not required
void onNewUser(SimpleOpenNI kinect, int userID) {
    println("Start skeleton tracking");
    kinect.startTrackingSkeleton(userID);
}


void keyPressed() {
    if (DEBUG) {
        debugControls.keyPressed();
    }
}


void beginContact(Contact cp) {
    Body b1 = cp.getFixtureA().getBody();
    Body b2 = cp.getFixtureB().getBody();
    
    Particle p1 = (Particle) b1.getUserData();
    Particle p2 = (Particle) b2.getUserData();
    
    Vec2 pos = Box2d.getBodyPixelCoord(b1);    


    // if one of them is fire and the other water, create smoke and 
    // delete both
    if (p1.element == Element.Fire) {
       println(p1.element);
              particles.add(new Particle(pos.x, pos.y - random(10), Element.Steam));
        particles.remove(p1);
        particles.remove(p2);
    }
    
    
}
