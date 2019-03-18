PGraphics map;
PVector pos;
ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
String Mode = "GAME";
boolean up, down, left, right, space, nu;
void setup() {
  size(1024, 512);
  map = createGraphics(128, 64);
  pos = new PVector(15, map.height/2);
}

void draw() {
  frameRate(5);
  if (Mode == "GAME") {
    if (up)
      pos.y--;
    if (down)
      pos.y++;
    if (left)
      pos.x--;
    if (right)
      pos.x++;
    if (space&&frameCount%4 == 0) {
      bullets.add(new Bullet(new PVector(pos.x, pos.y)));
    }
    pos.x = constrain(pos.x, 0, map.width);
    pos.y = constrain(pos.y, 0, map.height);
    map.beginDraw();
    map.noStroke();
    map.background(0);
    map.fill(255);
    if (frameCount % 10 == 0) {
      asteroids.add(new Asteroid(new PVector(map.width + 5, random(map.height)), random(7, 25), (int)random(5)));
    }
    map.rectMode(CENTER);
    map.rect(pos.x, pos.y, 14, 7);
    for (int i=asteroids.size()-1; i>=0; i--) {
      asteroids.get(i).move();
      asteroids.get(i).show();
      if (asteroids.get(i).pos.x<-asteroids.get(i).size/4) {
        asteroids.remove(i);
      }
    }
    for (int i=bullets.size()-1; i>=0; i--) {
      bullets.get(i).move();
      bullets.get(i).show();
      boolean n = false;
      if (bullets.get(i).pos.y>map.width + 5) {
        bullets.remove(i);
        n=true;
      }
      if (!n) {
        for (int j=asteroids.size()-1; j>=0; j--) {
          if (dist(bullets.get(i).pos.x, bullets.get(i).pos.y, 
          asteroids.get(j).pos.x, asteroids.get(j).pos.y)<asteroids.get(j).size/2 + 4) {
            bullets.remove(i);
            asteroids.remove(j);
          }
        }
      }
    }
    if(nu){
      bullets.add(new Bullet(new PVector(pos.x, pos.y)));
      nu = false;
    }
    map.endDraw();
    image(map, 0, 0, width, height);
    for (Asteroid a : asteroids) {
      if (dist(pos.x, pos.y, a.pos.x, a.pos.y) < a.size/2 + 7) {
        Mode = "END";
      }
    }
  } else if (Mode == "END") {
    map.beginDraw();
    map.background(0);
    map.textAlign(CENTER, CENTER);
    map.text("GAME OVER\n\nPLAY AGAIN?\nY       N", map.width/2, map.height/2);
    map.endDraw();
    image(map, 0, 0, width, height);
  }
}
class Bullet {
  PVector pos;
  Bullet(PVector p) {
    pos = p;
  }
  void show() {
    map.rect(pos.x, pos.y, 8, 3);
  }
  void move() {
    pos.x+=3;
  }
}
class Asteroid {
  PVector pos;
  float size;
  int type;
  Asteroid(PVector p, float s, int t) {
    pos = p;
    size = s;
    type = t;
  }
  void show() {
    map.ellipse(pos.x, pos.y, size, size);
  }
  void move() {
    pos.x--;
  }
}
void keyPressed() {
  switch(keyCode) {
  case UP:
    up = true;
    break;
  case DOWN:
    down = true;
    break;
  case LEFT:
    left = true;
    break;
  case RIGHT:
    right = true;
    break;
  }
  if (key==' ') {
    if (!space) {
      nu = true;
    }
    space = true;
  }
  if (Mode == "END") {
    if (key=='y') {
      bullets.clear();
      asteroids.clear();
      pos = new PVector(15, map.height/2);
      Mode = "GAME";
    }
    if(key=='n'){
      exit();
    }
  }
}
void keyReleased() {
  switch(keyCode) {
  case UP:
    up = false;
    break;
  case DOWN:
    down = false;
    break;
  case LEFT:
    left = false;
    break;
  case RIGHT:
    right = false;
    break;
  }
  if (key == ' ') {
    space = false;
  }
}
