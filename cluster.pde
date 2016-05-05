ArrayList<ArrayList> collection;

void setup() {
  size(800, 600);
  collection = new ArrayList<ArrayList>();
  newBall(100, 100, "ellipse");
  newBall(100, 200, "ellipse");
} // setup

void draw() {
  background(0);  
  for (int i = 0; i < collection.size(); i++) {
    ArrayList ball = (ArrayList)collection.get(i);
    PVector loc = (PVector)ball.get(1);
    PVector vel = (PVector)ball.get(2);
    color c = (color)ball.get(3);
    int r = (int) ball.get(4);            
    String shape = (String)ball.get(5);
    for (int k = 0; k < collection.size(); k++) { // check for collisions
      ArrayList otherBall = (ArrayList)collection.get(k); // checking against this other ball
      PVector otherLoc = (PVector)otherBall.get(1); 
      float d = loc.dist(otherLoc);           
      if (d < r) { // collided // if (d == 0) continue; // self-collision
        PVector otherVel = (PVector)otherBall.get(2);
        if (shape.equals("ellipse")) { // balls stick to each other
          vel.x = (otherVel.x + vel.x)*0.5;
          vel.y = (otherVel.y + vel.y)*0.5;
          otherVel.x = vel.x;
          otherVel.y = vel.y;
        } // ellipse
        else if (shape.equals("rect")) { // squares bounce off each other at diff vel
        } //rect
      }
    } // k

    if ((loc.x+r/2 > width) || (loc.x-r/2 < 0)) {
      if (shape.equals("ellipse")) { // balls
        for (int ii = 0; ii < collection.size(); ii++) { // a ball hit a wall, check for all balls with same vel
          if (i==ii) continue;
          ArrayList _ball = (ArrayList)collection.get(ii);
          PVector _vel = (PVector)_ball.get(2);        
          if ( (vel.x == _vel.x) && (vel.y == _vel.y) ) {          
            _vel.x = -_vel.x;
            PVector _loc = (PVector)_ball.get(1);
            _loc.add(_vel);
          }
        } // ii
      } // balls bounce off walls together
      vel.x = -vel.x;
    }
    if ((loc.y+r/2 > height) || (loc.y-r/2 < 0)) {
      if (shape.equals("ellipse")) { // balls
        for (int ii = 0; ii < collection.size(); ii++) {
          if (i==ii) continue;
          ArrayList _ball = (ArrayList)collection.get(ii);
          PVector _vel = (PVector)_ball.get(2);
          if ( (vel.x == _vel.x) && (vel.y == _vel.y) ) {          
            _vel.y = -_vel.y;
            PVector _loc = (PVector)_ball.get(1);
            _loc.add(_vel);
          }
        } // ii
      } // balls bounce off walls together
      vel.y = -vel.y;
    }
    loc.add(vel); // Add vel to the loc

    stroke(c); // Display circle at loc vector
    strokeWeight(2);
    fill(c, 150);
    ellipse(loc.x, loc.y, r, r);
  } // i
} // draw


void keyPressed() {
  //if (key == CODED) {
  collection = new ArrayList<ArrayList>();
} // keyPressed


void mousePressed() {
  newBall(mouseX, mouseY, "ellipse");
} // mouse

void newBall(int x, int y, String shape) {
  ArrayList newBall = new ArrayList();  
  int num = collection.size();
  PVector loc = new PVector(x, y);
  PVector vel = new PVector( (int)random(-10, 10), (int)random(-10, 10));
  color c = color((int)random(255), (int)random(255), (int)random(255));
  int r = 48; // (int)random(20, 60);   
  newBall.add(num); // item 0 is a num index
  newBall.add(loc); // item 1 is the ball's location
  newBall.add(vel); // item 2 is the ball's velocity
  newBall.add(c); // item 3 is the ball's colour
  newBall.add(r); // item 4 is the ball's radius
  newBall.add(shape); // itesm 5 is the shape of this ball
  collection.add(newBall); // add ball to collection
}