class DebugControls {
  Element currentElement = Element.Sand;
  
  
  DebugControls() {
  
  }
  
  void update() {
      if (mousePressed) {
          Particle p = new Particle(mouseX, mouseY, currentElement);
          particles.add(p);
      }  
  }
  
  
  void draw() {
      ellipse(mouseX, mouseY, 5, 5);
  }
  
  void keyPressed() {
      int converted = int(key) - 48; // weird way to get it from numeric char to int 
      println(converted);
      currentElement = elementForUserId(converted);
  }
}
