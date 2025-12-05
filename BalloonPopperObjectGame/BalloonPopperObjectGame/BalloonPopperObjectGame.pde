ArrayList<Balloon> balloons; //array for balloons
ArrayList<Particle> particles; //array for particles
ArrayList<PVector> clouds; //array of clouds in background

int lives = 3;
int score = 0;
boolean playing = true; //game state

void setup() {
  size(500, 600); //canvas size
  balloons = new ArrayList<Balloon>();
  particles = new ArrayList<Particle>();
  clouds = new ArrayList<PVector>();
  for (int i = 0; i < 8; i++) {
    clouds.add(new PVector(random(width), random(50, 250)));
  }
}

void draw() {
  drawSkyBackground();

  if (playing) { //check game state
    playGame();
  } else {
    gameOverScreen();
  }
}

void playGame() {
  if (frameCount % 40 == 0) { //spawns balloons
    balloons.add(new Balloon());
  }

  for (int i = balloons.size()-1; i >= 0; i--) { //update display balloons
    Balloon b = balloons.get(i);
    b.update();
    b.display();

    if (b.pos.y + b.size < 0) { //lose a live when the balloon reaches the top
      balloons.remove(i);
      lives--;
      if (lives <= 0) playing = false;
    }
  }
  for (int i = particles.size()-1; i >= 0; i--) { //update display particles
    Particle p = particles.get(i);
    p.update();
    p.display();
    if (p.lifespan <= 0) particles.remove(i); //remove particles when lifespan is 0 or less
  }

  fill(255); //score and lives text
  textSize(20);
  text("Score: " + score + "   Lives: " + lives, 30, 25);
}

void gameOverScreen() {
  fill(255);
  textAlign(CENTER);
  textSize(32);
  text("GAME OVER\nClick to Restart", width/2, height/2); //i remember \n from highschool im glad i could use it effectively :)
}

void drawSkyBackground() {

  for (int y = 0; y < height; y++) { //creates a gradient for the sky
    float inter = map(y, 0, height, 0, 1);
    color c1 = color(80, 140, 255);
    color c2 = color(180, 220, 255);
    stroke(lerpColor(c1, c2, inter));
    line(0, y, width, y);
  }

  noStroke();
  fill(255, 255, 180, 200); //sun
  ellipse(width * 0.85, height * 0.2, 120, 120);

  fill(100, 100, 110); //mountains in background
  beginShape();
  vertex(0, height*0.65);
  vertex(width*0.2, height*0.55);
  vertex(width*0.4, height*0.65);
  vertex(width*0.6, height*0.5);
  vertex(width*0.8, height*0.65);
  vertex(width, height*0.55);
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);

  fill(140, 140, 160); //mountains in foreground
  beginShape();
  vertex(0, height*0.75);
  vertex(width*0.25, height*0.6);
  vertex(width*0.5, height*0.75);
  vertex(width*0.75, height*0.58);
  vertex(width, height*0.7);
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);

  fill(255, 255, 255, 180); //clouds
  for (PVector c : clouds) {
    ellipse(c.x, c.y, 80, 50);
    ellipse(c.x + 25, c.y + 10, 60, 40);
    ellipse(c.x - 25, c.y + 10, 60, 40);

    c.x += 0.9; //clouds moving
    if (c.x > width + 50) c.x = -50;
  }
}

void mousePressed() {
  if (!playing) { //restart the game, resets balloons, particles, lives, score, and game state
    balloons.clear();
    particles.clear();
    lives = 3;
    score = 0;
    playing = true;
  }

  for (int i = balloons.size()-1; i >= 0; i--) { //if the player clicked a balloon
    Balloon b = balloons.get(i);

    if (dist(mouseX, mouseY, b.pos.x, b.pos.y) < b.size/2) { //check hit
      score++;
      for (int j = 0; j < 20; j++) { //create pop particles
        particles.add(new Particle(b.pos.x, b.pos.y));
      }
      balloons.remove(i);
      break;
    }
  }
}
