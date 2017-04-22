import shiffman.box2d.*;
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
  //box = new Box(width/2,height/2);

  // Make the spring (it doesn't really get initialized until the mouse is clicked)
  //spring = new Spring();
}

void mouseReleased() {
}

void mousePressed() {
}

void draw() {
  background(255);

  // We must always step through time!
  box2d.step();

  // Always alert the spring to the new mouse position
  //spring.update(mouseX,mouseY);

  // Draw the boundaries
  for (Boundary boundary : boundaries) {
    boundary.display();
  }

  for (Brick brick : bricks) {
    brick.display();
  }

  //// Draw the box
  //box.display();
  //// Draw the spring (it only appears when active)
  //spring.display();
}

void beginContact(Contact cp) {
}

void endContact(Contact cp) {
}