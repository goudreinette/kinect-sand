class Ground {
  
  Body body;
  float w, h;
  
  Ground() {
     w = width;
     h = 3;
     
     
    // Build Body
    BodyDef bd = new BodyDef();      
    bd.type = BodyType.STATIC;
    bd.position.set(Box2d.coordPixelsToWorld(0, height-h));
    body = Box2d.createBody(bd);

   // Define a polygon (this is what we use for a rectangle)
    PolygonShape sd = new PolygonShape();
    float Box2dW = Box2d.scalarPixelsToWorld(w);
    float Box2dH = Box2d.scalarPixelsToWorld(h);  // Particle2D considers the width and height of a
    sd.setAsBox(Box2dW, Box2dH);            // rectangle to be the distance from the
                           // center to the edge (so half of what we
                          // normally think of as width or height.) 
    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;

    // Attach Fixture to Body               
    body.createFixture(fd);
  }
  
  
  void update() {
  
  
  }
  
  
  void draw() {
  
  
  }
}
