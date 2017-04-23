class FxBrick {

  float x;
  float y;
  float w;
  float h;
  float angle;
  color col;

  boolean reqDestroy;
  int fxStartedAt;
  int elapsed;
  int fadeTime = 480;

  FxBrick(float x_, float y_, float w_, float h_, float a_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    angle = a_;
    reqDestroy = false;
    fxStartedAt = millis();
    elapsed = 0;
  }

  void update() {
    int current = millis();
    elapsed = min(fadeTime, elapsed + (current - fxStartedAt));
    if (elapsed >= fadeTime) {
      requestDestroy();
    }
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
    float alpha = min(255, (float) max(0, (fadeTime - elapsed)) / fadeTime * 255);

    noFill();
    stroke(0);
    fill(175, 175, 175, alpha);
    strokeWeight(1);
    rectMode(CENTER);

    pushMatrix();
    translate(x, y);
    rotate(-angle);
    rect(0, 0, w, h);
    popMatrix();
  }
}