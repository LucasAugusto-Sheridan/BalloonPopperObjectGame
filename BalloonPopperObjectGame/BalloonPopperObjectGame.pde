ArrayList<Balloon> balloons; //array for balloons

int lives = 3;
int score = 0;
boolean playing = true; //game state

void setup() {
  size(500, 600);
  balloons = new ArrayList<Balloon>();
}

void draw() {
  background(30, 40, 90);

  if (playing) {
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

void mousePressed() {
  if (!playing) { //restart the game
    balloons.clear();
    lives = 3;
    score = 0;
    playing = true;
    return;
  }

  for (int i = balloons.size()-1; i >= 0; i--) { //if the player clicked a balloon
    Balloon b = balloons.get(i);

    if (dist(mouseX, mouseY, b.pos.x, b.pos.y) < b.size/2) { //check hit
      score++; 

      balloons.remove(i);
      break;
    }
  }
}
