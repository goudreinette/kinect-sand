

class Particle {
  //  Instead of any of the usual variables, we will store a reference to a Particle2D Body
  Body body;      

  float w,h;
  Element element;

  Particle(float x, float y, Element element) {
    w = 10;
    h = 10;
    this.element = element;

    // Build Body
    BodyDef bd = new BodyDef();      
    bd.type = BodyType.DYNAMIC;
    bd.position.set(Box2d.coordPixelsToWorld(x,y));
    body = Box2d.createBody(bd);
    body.setUserData(this);

   // Define a polygon (this is what we use for a rectangle)
    CircleShape cs = new CircleShape();
    cs.m_radius = Box2d.scalarPixelsToWorld(2);
          
    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    // Parameters that affect physics
    fd.density = 2;
    fd.friction = 0.99;
    fd.restitution = 0.5;

    // Attach Fixture to Body               
    body.createFixture(fd);
  }

  void display() {
    // We need the Body’s location and angle
    Vec2 pos = Box2d.getBodyPixelCoord(body);    
    float a = body.getAngle();

    pushMatrix();
    translate(pos.x,pos.y);    // Using the Vec2 position and float angle to
    rotate(-a);              // translate and rotate the rectangle
    fill(fillForElement());
    noStroke();
    rectMode(CENTER);
    ellipse(0,0,w,w);
    popMatrix();
  }
  
  color fillForElement() {
      if (element == Element.Water) {
          return color(195, 45, 75 + random(-10,10));
      }
      
      if (element == Element.Fire) {
          return color(0, 100, 50 + random(-10,10));
      }
      
      if (element == Element.Sand) {
          return color(44, 57, 79 + random(-10,10));
      }
      
      if (element == Element.Steam) {
          return color(200, 50, 100);
      }
      
      if (element == Element.Smoke) {
          return color(44, 0, 10 + random(-10,10));
      }
      
      // Sand is default
      return color(206, 191, 148);
  }
  
  
  void update() {
      if (Box2d.getBodyPixelCoord(body).y > height) {
          particles.remove(this);
      }       
  }
}
