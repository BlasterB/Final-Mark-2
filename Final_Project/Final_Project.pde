import java.util.*;

CellWalls walls;
CellSpawner cs;
ArrayList<BlackBloodCell> b;
//ArrayList<RedBloodCell> rbcPopulation;
ArrayList<WhiteBloodCell> whiteppl;

void setup() {
  //rbc = new RedBloodCell(new PVector(width/2,height/2));
  cs = new CellSpawner();
  //fullScreen();
  size(1500, 800);
  b = new ArrayList<BlackBloodCell>();
  walls = new CellWalls(new PVector(0, 0));
  //rbcPopulation = new ArrayList<RedBloodCell>();
  whiteppl = new ArrayList<WhiteBloodCell>();
}

void mousePressed() {
  b.add(new BlackBloodCell(new PVector(mouseX, mouseY)));
}

void draw() {
  background(255 - b.size()*2, 200 - b.size()*2, 200 - b.size()*2);
  walls.display();
  cs.addParticle();
  cs.run();
  if (b.size() > 0) { 
    for (BlackBloodCell bbc : b) {
      bbc.run();
      bbc.seek(cs.redCells);
    }
  }


  if (b.size() > 6) {
    float r = random(5);
    if (r > 4.5) { 
      whiteppl.add(new WhiteBloodCell(new PVector(-10, random(0+height/8+10, height-height/8-10))));
    }
  }
  if (whiteppl.size() > 0) { 
    for (WhiteBloodCell wbc : whiteppl) {
      if (wbc.isDead()) {
        whiteppl.remove(wbc);
      }
      wbc.run();
      wbc.seek(b);
    }
  }
  println(whiteppl.size());
}
