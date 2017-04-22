import shiffman.box2d.*; //<>// //<>//
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

Box2DProcessing box2d;
ArrayList<Boundary> boundaries;
ArrayList<Brick> bricks;
Sphere sphere;

float angle = PI/4;
boolean shot = false;

float boundaryWidth = 10;
float brickWidth = 38;
float brickHeight = 18;
float brickOffsetX = 40;
float brickOffsetY = 20;

//Spring spring;
void setup() {
  // Initialize screen size
  size(480, 640);

  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.listenForCollisions();

  // Add a bunch of fixed boundaries
  boundaries = new ArrayList<Boundary>();
  boundaries.add(new Boundary(width/2, height-(boundaryWidth/2), width, boundaryWidth, 0));
  boundaries.add(new Boundary(width/2, (boundaryWidth/2), width, boundaryWidth, 0));
  boundaries.add(new Boundary(width-(boundaryWidth/2), height/2, boundaryWidth, height, 0));
  boundaries.add(new Boundary((boundaryWidth/2), height/2, boundaryWidth, height, 0));

  // Make bricks
  bricks = new ArrayList<Brick>();
  for (int row = 0; row < 5; row++) {
    for (int column = 0; column < 10; column++) {
      float xOffset = (width - (brickOffsetX * 10)) / 2 + (brickWidth / 2);
      float yOffset = boundaryWidth + (brickHeight / 2) + 30;
      float x = column * brickOffsetX + xOffset;
      float y = row * brickOffsetY + yOffset;
      bricks.add(new Brick(x, y, brickWidth, brickHeight, 0));
    }
  }

  sphere = new Sphere(width / 2, (height / 10) * 9, 10);
}

void mouseReleased() {
}

void mousePressed() {
}

void draw() {
  background(255);

  box2d.step();

  sphere.update();

  for (Boundary boundary : boundaries) {
    boundary.display();
  }

  for (Brick brick : bricks) {
    brick.display();
  }

  sphere.display();

  for (int i = bricks.size()-1; i >= 0; i--) {
    Brick brick = bricks.get(i);
    if (brick.done()) {
      bricks.remove(brick);
    }
  }
}

void beginContact(Contact cp) {
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();

  Body b1 = f1.getBody();
  Body b2 = f2.getBody();

  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();

  if (o1.getClass() == Sphere.class) {
    if (o2.getClass() == Brick.class) {
      Brick brick = (Brick) o2;
      brick.requestDestroy();
    }
  }
  if (o2.getClass() == Sphere.class) {
    if (o1.getClass() == Brick.class) {
      Brick brick = (Brick) o1;
      brick.requestDestroy();
    }
  }
  if (o1.getClass() == Boundary.class) {
    Sphere p = (Sphere) o2;
    p.change();
  } else if (o2.getClass() == Boundary.class) {
    Sphere p = (Sphere) o1;
    p.change();
  }
}

void endContact(Contact cp) {
}

void keyPressed() {
  if (key == ' ') {
    shot = true;
    PVector force = PVector.fromAngle(angle);
    Vec2 velocity = new Vec2(force.x, force.y);
    sphere.applyVelocity(velocity);
  }
}