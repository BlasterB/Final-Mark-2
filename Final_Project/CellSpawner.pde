class CellSpawner {

  ArrayList<RedBloodCell> redCells;
  ArrayList<BlackBloodCell> b;
  int numberofCells;
  int numberofR;
  float distance2;

  CellSpawner() {
    redCells = new ArrayList<RedBloodCell>();
    b = new ArrayList<BlackBloodCell>();
  }



  void applyForce(PVector force) {
    for (RedBloodCell p : redCells) {
      p.applyForce(force);
    }
  }

  void addParticle() {
    float r = random(5);
    if (r < 2) { 
      redCells.add(new RedBloodCell(new PVector(-10, random(0+height/8+10, height-height/8-10))));
    }
  }


  void run() {
    for (int i = redCells.size()-1; i >=0; i--) {
      RedBloodCell p = redCells.get(i);
      p.update();
      p.display();
      if (p.location.x > width /*|| p.location.x > width+50 || p.location.x > 0-50*/) {
        redCells.remove(i);
      }
      Iterator<BlackBloodCell> bbcIterator = b.iterator();
      while (bbcIterator.hasNext()) { 
        BlackBloodCell currentBbc = bbcIterator.next();
        distance2 = PVector.dist(p.location, currentBbc.location);
        if (distance2 < 20) {
          //bbcIterator.add();
        }
      }
    }
  }
}
