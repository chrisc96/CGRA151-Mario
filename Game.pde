import java.util.*;

public static float speedMode;

PFont pauseFont;
PImage logo;
int highscore = 0;
int textSize = 32;

public boolean displayMsg = false;
public int HitTimer;

// Lists of collision items
public ArrayList<Block> blocks = new ArrayList();
public ArrayList<CoinsBlock> coinBlocks = new ArrayList();
public ArrayList<BrickBlock> brickBlocks = new ArrayList();
public ArrayList<StepBlock> stepBlocks = new ArrayList();
public ArrayList<FloorTile> floorTiles = new ArrayList();
public ArrayList<FallTile> fallTiles = new ArrayList();
public ArrayList<Pipe> pipes = new ArrayList();
public ArrayList<Mushroom> mushrooms = new ArrayList();
public ArrayList<Coin> coinFromBlock = new ArrayList();
public ArrayList<Flower> flowers = new ArrayList();
public ArrayList<Goomba> goombas = new ArrayList();

public PVector[] spawners = new PVector[7];

public ArrayList removeArr = new ArrayList();

public static final int WIDTH = 256;
public static final int HEIGHT = (int)(WIDTH / 1.147982062780269);
public static final int SCALE = 2;

// Animation/Game Timers
public static int countdownTimer;
public static int startTime;
public static int livesTimer;
public static int gameOverTimer;

public static int deadTimer;
boolean first = true;

// Objects
Debugger debugger;
World world;
Mario mario;
PauseMenu pauseMenu;
TopBar topBar;
StartMenu mainMenu;
Game_Status status;

void settings() {
    size(WIDTH, HEIGHT);
}

void setup() {
    // Importing custom fonts
    pauseFont = createFont("fonts/SuperMarioBros.ttf", textSize);
    textFont(pauseFont);
    logo = loadImage("sprites/world/menus/title.png");

    mario = new Mario();

    this.initialiseGame();

    // Custom timers for animations / game timer
    startTime = millis();
    countdownTimer = millis();
}

void resetGame() {
    this.removeCollisionMasks();
    this.initialiseGame();
}

void initialiseGame() {
    // Creating objects
    this.generateCollisionMasks();

    debugger = new Debugger();
    world = new World();
    pauseMenu = new PauseMenu();
    topBar = new TopBar();
    mainMenu = new StartMenu();

    // Generate Menu Buttons
    this.createMenus();

    status = Game_Status.MAIN_MENU;
}

void draw() {

    switch(status) {
    case MAIN_MENU:
        this.startMenu();
        break;
    case PLAYING:
        this.playing();
        break;
    case TIME_UP:
        this.timesUp();
        break;
    case GAME_OVER:
        this.gameOver();
        break;
    case LIVES:
        this.livesMenu();
        break;
    case PAUSE:
        pauseMenu.display();
        break;
    case END:
        this.playing();
        break;
    case DEAD:
        this.dead();
        break;
    }
}

void startMenu() {
    mario = null;
    mario = new Mario();

    world.display();
    topBar.display();
    image(logo, 0 + ((width - logo.width)/2), height/5);
    mainMenu.display();
    text(String.format("TOP- %06d", highscore), width/3.7, height/1.15);
}

void livesMenu() {
    background(0);
    topBar.display();
    if (millis() > livesTimer + 1500) {
        status = Game_Status.PLAYING;
    }
    this.drawLives();
}
void gameOver() {
    background(0);
    topBar.display();
    float posX = 0 + (width - mario.lives_menu.width)/2 - 35;
    float posY = height/1.9;
    text("GAME OVER", posX, posY);
    if (millis() > gameOverTimer + 2500) {
        mario.numPts = 0;
        mario.numCoins = 0;
        status = Game_Status.MAIN_MENU;
    }
}

void timesUp() {
    background(0);
    topBar.display();
    float posX = 0 + (width - mario.lives_menu.width)/2 - 25;
    float posY = height/1.9;
    text("TIME UP", posX, posY);
    if (millis() > gameOverTimer + 2500) {
        if (mario.lives == 1) {
            if (mario.numPts > highscore) highscore = mario.numPts;
            mario.numPts = 0;
            mario.numCoins = 0;
            status = Game_Status.MAIN_MENU;
        } else {
            mario.lives--;
            livesTimer = millis();
            status = Game_Status.LIVES;
        }
    }
}

void dead() {
    background(255);
    world.display();
    this.drawPowerups();
    this.drawAnimatedBlocks();
    topBar.display();
    mario.deadFall();
}

void playing() {
    frameRate(45);
    background(255);
    world.display();
    mario.display();
    this.drawPowerups();
    this.drawAnimatedBlocks();
    topBar.display();
    // Debugging
    debugger.fpsCounter();
    //debugger.drawCollisionMasks();
}

void drawLives() {
    float posX = 0 + (width - mario.lives_menu.width)/2 - 30;
    float posY = 0 + (height - mario.lives_menu.height)/2;

    image(mario.lives_menu, posX, posY);

    float textX = posX + mario.lives_menu.width * 2;
    float textY = posY + mario.lives_menu.height;
    text("x", textX, textY);

    float livesX = textX + textSize / 1.4;
    float livesY = textY;
    textSize(14);
    text(mario.lives, livesX, livesY);
    textSize = 32;
}

void createMenus() {
    pauseMenu.createButtons();
    mainMenu.createButtons();
}

void drawPowerups() {
    for (Goomba goomba : goombas) {
        if (!goomba.toRemove()) {
            if (PVector.dist(mario.pos, goomba.pos) < 250) {
                goomba.display();
            }
        }
        else {
            removeArr.add(goomba);
        }
        if (displayMsg) {
            text("500", mario.pos.x - mario.wd/1.5, mario.pos.y - mario.ht/4);
            if (millis() - HitTimer > 250) displayMsg = false;
        }
    }
    goombas.removeAll(removeArr);
    
    for (Mushroom mush : mushrooms) {
        if (!mush.remove) {
            mush.display();
        }
        else {
            text("1000", mario.pos.x - mario.wd/1.5, mario.pos.y - mario.ht/4);
            if (millis() > mush.mushTimer + 250) removeArr.add(mush);
        }
    }
    mushrooms.removeAll(removeArr);

    for (Coin coin : coinFromBlock) {
        if (!coin.remove) {
            coin.display();
        } 
        else {
            text("200", coin.pos.x - coin.block.wd/2, coin.pos.y);
            if (millis() > coin.startTime1 + 250) removeArr.add(coin);
        }
    }
    coinFromBlock.removeAll(removeArr);
}


void drawAnimatedBlocks() {
    for (CoinsBlock coin : coinBlocks) {
        coin.display();
    }
    for (BrickBlock brick : brickBlocks) {
        brick.display();
    }
    for (Flower flower : flowers) {
        flower.display();
    }
    for (Pipe pipe : pipes) {
        pipe.display();
    }
}

void generateCollisionMasks() {
    this.generateCB();
    this.generateBB();
    this.generateSB();
    this.generateFloorT();
    this.generateFallT();
    this.generatePipes();
    this.generateFlowers();
    this.generateSpawners();
}

void removeCollisionMasks() {
    blocks.clear();
    coinBlocks.clear();
    brickBlocks.clear();
    stepBlocks.clear();
    floorTiles.clear();
    fallTiles.clear();
    pipes.clear();
    mushrooms.clear();
    coinFromBlock.clear();
    flowers.clear();
    goombas.clear();
}