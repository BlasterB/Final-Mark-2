class BlackBloodCell {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float size;
  float r;
  float maxforce;
  float maxspeed;
  float distance;
  boolean alive;
  CellSpawner red;

  BlackBloodCell(PVector x) {
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    location = x.copy();
    size = width/50;
    r = 3.0;
    maxspeed = 4;
    maxforce = 0.1;
  }

  void run() {
    update();
    display();
    collision();
  }

  void collision() {
    Iterator<RedBloodCell> rbcIterator = cs.redCells.iterator(); 
    while (rbcIterator.hasNext()) { 
      RedBloodCell currentRbc = rbcIterator.next();
      distance = PVector.dist(location, currentRbc.location);
      if (distance < 30) {
        //println("collide");
        alive = true;
        rbcIterator.remove();
      }
    } 
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void update() {
    velocity.add(acceleration);
    velocity.x = constrain(velocity.x, -4, 4);
    velocity.y = constrain(velocity.y, -4, 4);
    location.add(velocity);
    acceleration.mult(.9);
  }

  void display() {
    fill(0, 0, 0);
    ellipse(location.x, location.y, size, size);
    fill(50, 50, 50);
    ellipse(location.x, location.y, size/2, size/2);
  }

  void seek(ArrayList<RedBloodCell> rbcPopulation) {
    PVector target = findClosestTarget(rbcPopulation);
    PVector desired = PVector.sub(target, location);
    desired.normalize();
    desired.mult(maxspeed);
    applyForce(desired);
    float d = desired.mag();
  }


  PVector findClosestTarget(ArrayList<RedBloodCell> rbcPopulation) {
    PVector closest = new PVector();
    float closestDistanceToCell = width * 4;
    for (RedBloodCell a : rbcPopulation) {
      float distanceToCell = dist(location.x, location.y, a.location.x, a.location.y);
      if (distanceToCell < closestDistanceToCell) {
        closestDistanceToCell = distanceToCell;
        closest.x = a.location.x;
        closest.y = a.location.y;
      }
    }
    return closest;
  }
}
