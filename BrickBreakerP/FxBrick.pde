class FxBrick {

  float x;
  float y;
  float w;
  float h;
  float angle;

  boolean reqDestroy;

  FxBrick(float x_, float y_, float w_, float h_, float a_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    angle = a_;
    reqDestroy = false;
  }

  boolean done() {
    if (reqDestroy) {
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
    fill(240);
    strokeWeight(1);
    rectMode(CENTER);

    pushMatrix();
    translate(x, y);
    rotate(-angle);
    rect(0, 0, w, h);
    popMatrix();
  }
}