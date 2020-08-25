class WhiteBloodCell {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float size;
  float r;
  float maxforce;
  float maxspeed;
  float lifespan;
  float distance;
  boolean alive;

  WhiteBloodCell(PVector z) {
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    location = z.copy();
    size = width/40;
    r = 3.0;
    maxspeed = 4;
    maxforce = 0.1;
    lifespan = 0;
  }

  void run() {
    update();
    display();
    collision();
    //seek(new PVector(mouseX,mouseY));
  }

  void collision() {
    Iterator<BlackBloodCell> bbcIterator = b.iterator(); 
    while (bbcIterator.hasNext()) { 
      BlackBloodCell currentbbc = bbcIterator.next();
      distance = PVector.dist(location, currentbbc.location);
      if (distance < 20) {
        //println("collide2");
        alive = true;
        bbcIterator.remove();
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
    lifespan = lifespan+random(0.5, 1);
  }

  void display() {
    //asteroid = loadImage("asteroid.png");
    fill(255, 255, 255, 255-lifespan);
    ellipse(location.x, location.y, size, size);
    fill(200, 200, 200, 255-lifespan);
    ellipse(location.x, location.y, size/2, size/2);
  }

  void seek(ArrayList<BlackBloodCell> b) {
    PVector target = findClosestTarget(b);
    PVector desired = PVector.sub(target, location);
    desired.normalize();
    desired.mult(maxspeed);
    applyForce(desired);
    float d = desired.mag();
  }


  PVector findClosestTarget(ArrayList<BlackBloodCell> b) {
    PVector closest = new PVector();
    float closestDistanceToCell = width * 4;
    for (BlackBloodCell bbc : b) {
      float distanceToCell = dist(location.x, location.y, bbc.location.x, bbc.location.y);
      if (distanceToCell < closestDistanceToCell) {
        closestDistanceToCell = distanceToCell;
        closest.x = bbc.location.x;
        closest.y = bbc.location.y;
      }
    }
    return closest;
  }

  boolean isDead() {
    if (lifespan > 255) {
      return true;
    } else {
      return false;
    }
  }
}
