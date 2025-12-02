class Balloon {
  PVector pos;
  PVector vel; //velocity
  PVector acc; //acceleration
  float size;
  color c;
  
  Balloon() {
   size = random(40, 60);
   pos = new PVector(random(size, width-size), height + size);
   vel = new PVector(0, random(-2, -4)); //speed rising upwards
   acc = new PVector(0, 0);
   c = color(random(100,255), random(100,255), random(100,255)); //random balloon colour
  }
  
  void update() { //update balloon
   acc.x = map(noise(frameCount * 0.01 + pos.x), 0, 1, -0.05, 0.05); //slight sway back and forth
   vel.add(acc);
   pos.add(vel);
   pos.x = constrain(pos.x, 20, width-20); //limit how much it can drift back and forth
  }
  
  void display() {
   noStroke(); //fills balloons with colour and adjusts size to be more balloon shape
   fill(c);
   ellipse(pos.x, pos.y, size, size * 1.2);
  }
}
  
