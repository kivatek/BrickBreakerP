class Brick {

  // A boundary is a simple rectangle with x,y,width,and height
  float x;
  float y;
  float w;
  float h;
  // But we also have to make a body for box2d to know about it
  Body body;

  boolean reqDestroy;

  Brick(float x_, float y_, float w_, float h_, float a) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    reqDestroy = false;

    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    sd.setAsBox(box2dW, box2dH);

    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.angle = a;
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    body = box2d.createBody(bd);

    body.createFixture(sd, 1);

    body.setUserData(this);
  }

  boolean done() {
    if (reqDestroy) {
      box2d.destroyBody(body);
      return true;
    }
    return false;
  }

  void requestDestroy() {
    reqDestroy = true;
  }

  void display() {
    noFill();
    stroke(127);
    fill(127);
    strokeWeight(1);
    rectMode(CENTER);

    float a = body.getAngle();

    pushMatrix();
    translate(x, y);
    rotate(-a);
    rect(0, 0, w, h);
    popMatrix();
  }
}