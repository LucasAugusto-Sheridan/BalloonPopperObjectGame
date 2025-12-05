class Particle {
  PVector pos;
  PVector vel; //velocity
  float lifespan;

  Particle(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector(random(-2, 2), random(-2, 2));
    //makes all the particles burst out with random levels of velocity
    lifespan = 255;
  }

  void update() {
    pos.add(vel);
    vel.mult(0.95); //makes the particles slow down
    lifespan -= 4; //makes the particles fade out
  }

  void display() {
    noStroke();
    fill(255, lifespan);
    ellipse(pos.x, pos.y, 5, 5);
  }
}
