class RedBloodCell {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float size;
  float r;
  float maxforce;    
  float maxspeed;

  RedBloodCell(PVector t) {
    velocity = new PVector(random(0, 4), 0);
    acceleration = new PVector(random(0, 1), 0);
    location = t.copy();
    size = random(width/100, width/50);
    //r = 12;
    //maxspeed = 3;
    //maxforce = 1;
  }

  void run() {
    update();
    display();
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void update() {
    velocity.add(acceleration);
    velocity.x = constrain(velocity.x, 0, 4);
    velocity.y = constrain(velocity.y, 0, 0);
    location.add(velocity);
    acceleration.mult(.9);
  }

  void display() {
    //asteroid = loadImage("asteroid.png");
    fill(255, 0, 0);
    ellipse(location.x, location.y, size, size);
    fill(255, 110, 110);
    ellipse(location.x, location.y, size/2, size/2);
  }
}
