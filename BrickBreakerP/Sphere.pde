// based on :
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Sphere {

  Body body;
  float radius;
  color col;

  Sphere(float x, float y, float r_) {
    radius = r_;
    body = makeBody(x, y, radius);
    body.setUserData(this);
    col = color(175);

  }

  void killBody() {
    box2d.destroyBody(body);
  }

  void change() {
    col = color(255, 0, 0);
  }

  boolean done() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if (pos.y > height+radius*2) {
      killBody();
      return true;
    }
    return false;
  }

  void applyVelocity(Vec2 velocity) {
    velocity.normalize();
    velocity = velocity.mul(50);
    body.setLinearVelocity(velocity);
  }

  void update() {
  }

  // 
  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    fill(col);
    stroke(0);
    strokeWeight(1);
    ellipse(0, 0, radius*2, radius*2);
    line(0, 0, radius, 0);
    popMatrix();
  }

  // Here's our function that adds the particle to the Box2D world
  Body makeBody(float x, float y, float r) {
    // Define a body
    BodyDef bd = new BodyDef();
    // Set its position
    bd.position = box2d.coordPixelsToWorld(x, y);
    bd.type = BodyType.DYNAMIC;
    bd.gravityScale = 0;
    Body body = box2d.createBody(bd);

    // Make the body's shape a circle
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);

    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0;
    fd.restitution = 1;  // この値を1より小さくすると衝突時に減衰する

    // Attach fixture to body
    body.createFixture(fd);

    //body.setAngularVelocity(random(-10, 10));

    return body;
  }
}