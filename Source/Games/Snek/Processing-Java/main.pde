ArrayList<PVector> Snek = new ArrayList<PVector>();
PVector Food;
PGraphics map;
PVector dir = new PVector(2, 0);
void setup() {
  size(1024, 512);
  map = createGraphics(128, 64);
  Food = new PVector(((int)(random(map.width)/2))*2, ((int)(random(map.height)/2))*2);
  Snek.add(new PVector(2, 2));
}

void draw() {
  println(Snek.get(0));
  map.beginDraw();
  map.background(0);
  map.noStroke();
  map.fill(255);
  Snek.get(0).add(new PVector(dir.x, dir.y));
  for (int i=Snek.size()-1; i>0; i--) {
    Snek.get(i).x = Snek.get(i-1).x;
    Snek.get(i).y = Snek.get(i-1).y;
  }
  for (PVector p : Snek) {
    map.rect(p.x, p.y, 2, 2);
  }
  map.rect(Food.x, Food.y, 2, 2);
  if (Food.x == Snek.get(0).x && Food.y == Snek.get(0).y) {
    Snek.add(new PVector(Snek.get(Snek.size()-1).x, Snek.get(Snek.size()-1).y));
  Food = new PVector(((int)(random(map.width)/2))*2, ((int)(random(map.height)/2))*2);
  }
  map.endDraw();
  image(map, 0, 0, width, height);
  delay(4);
}
void keyPressed() {
  switch(keyCode) {
  case UP:
    dir = new PVector(0, -2);
    break;
  case DOWN:
    dir = new PVector(0, 2);
    break;
  case LEFT:
    dir = new PVector(-2, 0);
    break;
  case RIGHT:
    dir = new PVector(2, 0);
    break;
  }
}
