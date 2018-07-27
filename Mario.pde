public class Mario {

    // Coordinates
    int groundY = 200;
    int anim_num = 0;

    // States
    boolean movingL = false;
    boolean movingR = false;
    boolean LR_ReleasedInAir = false;
    boolean jumping = false;
    boolean sliding = false;
    boolean hitBlock = false;    
    String dir = "right";
    
    //Animation booleans
    boolean firstRun = true;
    boolean collided = false;
    int count = 0;
    
    //Anmation Alpha
    float alpha = 255;

    // Sprites
    PImage marioImg;

    PImage standing_r= loadImage("sprites/entities/mario/standing/m_standing_r.png");
    PImage standing_l= loadImage("sprites/entities/mario/standing/m_standing_l.png");
    PImage jump_r = loadImage("sprites/entities/mario/jump/j_right.png");
    PImage jump_l = loadImage("sprites/entities/mario/jump/j_left.png");
    PImage dead = loadImage("sprites/entities/mario/falling/falling.png");
    PImage lives_menu = loadImage("sprites/world/menus/mario_lives.png");
    PImage pole_grab_r = loadImage("sprites/entities/mario/poleGrabRight.png");
    PImage pole_grab_l = loadImage("sprites/entities/mario/poleGrabLeft.png");

    // Sprite characteristics
    int ht;
    int wd;
    PVector pos = new PVector(100, 180);

    // Values
    int numCoins;
    int numPts;
    int lives;


    // Movement limits
    float xMaxVel = 1.6;    // maximum x velocity
    // (x acceleration needs to stop at maxVelocity

    // Physics
    float air_friction_perc = 0.90;
    PVector vel = new PVector(0, 0);
    PVector accel = new PVector(0.07, 0.3);


    // Initial creation of mario
    public Mario() {
        marioImg = standing_r;
        ht = marioImg.height;
        wd = marioImg.width;
        numCoins = 0;
        numPts = 0;
        lives = 3;
    }

    // creation of mario when he has died before so we can create mario again.
    public Mario(int numLives, int numPts, int numCoins) {
        marioImg = standing_r;
        ht = marioImg.height;
        wd = marioImg.width;
        this.lives = numLives;
        this.numPts = numPts;
        this.numCoins = numCoins;
    }

    // called from moveRight, moveLeft (horizontal movements) AND
    // called from jumpRight, jumpLeft
    void speedUpHorizontal() {
        if (!jumping) {
            if (vel.x <= xMaxVel) {
                vel.x += accel.x;
            }
        }
        // Only changes x-velocity if your jumping and moving left or right
        // thus doesn't move to the side when you just click up
        else if (jumping && (movingR || movingL)) {
            if (vel.x <= xMaxVel) {
                vel.x = xMaxVel;
            }
        }
    }

    void slowDownHorizontal() {
        if (!movingR || !movingL) {
            vel.x -= 0.2*vel.x;
            if (vel.x >= 0 && dir.equalsIgnoreCase("right") && pos.x >= 100) {
                if (pos.x + wd + vel.x < width - 1) {
                    world.moveBG(-vel.x, 0);
                    this.moveMasks();
                }
            } 
            else if (vel.x >= 0 && dir.equalsIgnoreCase("left")) {
                if (pos.x - vel.x >= 1) {
                    move(-vel.x/2, 0);
                }
            }
            if (vel.x <= 0.1) {
                vel.x = 0;
                sliding = false;
                if (dir.equalsIgnoreCase("right")) {
                    movingR = false;
                    LR_ReleasedInAir = false;
                } else {
                    movingL = false;
                    LR_ReleasedInAir = false;
                }
            }
        }
    }

    void display() {
        //println("onBlock: " + onBlock() + "          moving Right: " + movingR + "                moving Left: " + movingL + "                  jumping: " + jumping + "            inAir: " + inAir + "             Sliding:" + sliding);
        //println("moving right: " + movingR + "           vel x: " + vel.x + "       LRReleased: " + LR_ReleasedInAir + "             Sliding:" + sliding);
        //println("posX: " + pos.x + "      posY: " + pos.y + "                 velX: " + vel.x + "       velY: " + vel.y + "              accelX: " + accel.x + "        accelY: " + accel.y);
            
        // If alive
        if (!isDead()) {
            collisionDetection();
            
            if(status == Game_Status.END) {
                endDisplay();    
                return;
            }
            
            if (status == Game_Status.DEAD) {
                return;
            }
            
            // if up arrow been pressed
            if (jumping) {
                
                if (onGround() || onBlock()) {
                    vel.y = -6.7; // lower value - lower jump, higher value - higher jump
                }
                
                // change y velocity by acceleration for jumping
                vel.y += accel.y;

                // if right arrow was pushed after pressing up arrow, jump right and up too
                if (movingR) {
                    this.jumpRight();
                }

                if (movingL) {
                    this.jumpLeft();
                }

                // standing still
                if (!movingR && !movingL) {
                    if (dir.equalsIgnoreCase("right")) {
                        this.jumpRight();
                    } else {
                        this.jumpLeft();
                    }
                }
            }

            // Landing on ground from jump
            if (onGround()) {
                inAir = true;
                jumping = false;
                pos.y = groundY - ht;
                vel.y = 0;
                if (LR_ReleasedInAir) {
                    sliding = true;
                }
            }

            // Landing on block/tiles
            if (onBlock()) {
                inAir = true;
                jumping = false;
                if (LR_ReleasedInAir) {
                    sliding = true;
                }
            }

            // falling from block
            if (!onBlock() && !onGround() && !jumping) {
                vel.y += 0.5; // 0.5 is gravity
                // need to decrease x velocity to arc curve
                if (dir.equalsIgnoreCase("right")) {
                    this.fallRight();
                } else {
                    this.fallLeft();
                }
            }

            if ((onGround() || onBlock()) && !jumping) {
                // If not jumping (i.e on ground or block) but right key being pressed, move right
                if (movingR) {
                    this.moveRight();
                } else if (movingL) {
                    this.moveLeft();
                }
            }

            // standing still on ground or block
            if ((onGround() || onBlock()) && !movingR && !movingL && !jumping && !LR_ReleasedInAir) {
                vel.y = 0;
                sliding = false;
                hitBlock = false;
            }

            // Standing still
            if (dir.equalsIgnoreCase("right") && !isMoving() && !hitBlock && (onGround() || onBlock())) {
                marioImg = standing_r;
                image(marioImg, pos.x, pos.y);
            } else if (dir.equalsIgnoreCase("left") && !isMoving() && !hitBlock && (onGround() || onBlock())) {
                marioImg = standing_l;
                image(marioImg, pos.x, pos.y);
            }
        }

        // If dead
        else {
            status = Game_Status.DEAD;
        }
    }


    // State checking

    boolean isMoving() {
        return vel.x != 0 || vel.y != 0;
    }
    
    boolean onGround() {
        for (FloorTile tile : floorTiles) {
            if (getBoundsBottom().intersects(tile.getBounds())) {
                return true;
            }
        }
        return false;
    }

    boolean onBlock() {
        int count = 0;
        for (Block block : blocks) {
            if (getBoundsBottom().intersects(block.getBounds())) {
                count++;
            }
        }
        for (Pipe pipe : pipes) {
            if (getBoundsBottom().intersects(pipe.getBounds())) {
                count++;
            }
        }
        if (count != 0) return true;
        else {
            return false;
        }
    }

    boolean isDead() {
        for (Goomba goomba : goombas) {
            if (getBoundsBottom().intersects(goomba.getBoundsTop())) return false;
            else if (getBoundsRight().intersects(goomba.getBoundsLeft()) || 
                getBoundsLeft().intersects(goomba.getBoundsRight()) ||
                getBoundsTop().intersects(goomba.getBoundsBottom())) {
                    return true;
            }
        }
        for (FallTile ft : fallTiles) {
            if (getBoundsLeft().intersects(ft.getBounds()) || getBoundsRight().intersects(ft.getBounds())) {
                return true;
            }
        }
        for (Flower flower : flowers) {
            if (getBounds().intersects(flower.getBounds())) {
                return true;
            }
        }
        
        if (pos.y > height) {
            return true;
        }
        return false;
    }

    // Movement/Infinite Scrolling code

    void move(float vel_x_add, float vel_y_add) {
        this.pos.x += vel_x_add;
        this.pos.y += vel_y_add;
    }

    void marioEdgeCase() {
        if (pos.x - vel.x >= 0 && !movingR) {
            this.move(-vel.x, 0);
        } else if (world.x > -world.wd + width + vel.x && pos.x >= 100 && movingR) {
            this.moveMasks();
        } else {
            // move mario right until he hits edge of image (3392px ish)
            if (pos.x + wd + vel.x <= width && movingR) {
                this.move(vel.x, 0);
            }
        }
    }

    // Loading sprites/animations
    void moveLeft() {
        if (!sliding) {
            speedUpHorizontal();
        }
        else {
            this.slowDownHorizontal();
        }
        marioLeftEdgeCase();
        int numFrames = 4;
        if (millis() > Game.startTime + 150) {
            Game.startTime = millis();
            anim_num = (anim_num + 1)%numFrames;
            marioImg = loadImage("sprites/entities/mario/moving/left/l_" + anim_num + ".png");
        }
        image(marioImg, pos.x, pos.y);
    }

    void marioLeftEdgeCase() {            
        // while mario is to the right of the left of the window
        // then move him to the left by his velocity
        if (pos.x - vel.x >= 0) { 
            this.move(-vel.x, 0);
        }
    }

    void moveRight() {
        if (!sliding) {
            speedUpHorizontal();
        } else {
            this.slowDownHorizontal();
        }
        marioRightEdgeCase();
        int numFrames = 4;
        if (millis() > Game.startTime + 150) {
            Game.startTime = millis();
            anim_num = (anim_num + 1)%numFrames;
            marioImg = loadImage("sprites/entities/mario/moving/right/r_" + anim_num + ".png");
        }
        image(marioImg, pos.x, pos.y);
    }

    void marioRightEdgeCase() {
        // move background image to the left if mario is not at far right of world
        if (world.x > -world.wd + width + vel.x && pos.x >= 100 && movingR) {
            world.moveBG(-vel.x, 0);
            this.moveMasks();
        } else {
            // move mario right until he hits edge of image (3392px ish)
            if (pos.x + wd + vel.x <= width && movingR) {
                this.move(vel.x, 0);
            }
        }
    }

    void jumpRight() {
        marioRightEdgeCase();
        speedUpHorizontal();
        marioImg = jump_r;
        move(0, vel.y);
        image(marioImg, pos.x, pos.y);
    }

    void jumpLeft() {
        marioLeftEdgeCase();
        speedUpHorizontal();
        marioImg = jump_l;
        move(0, vel.y);
        image(marioImg, pos.x, pos.y);
    }

    void jumpUp() {
        move(0, vel.y);
        image(marioImg, pos.x, pos.y);
    }

    void fallRight() {
        marioRightEdgeCase();
        marioImg = jump_r;
        move(0, vel.y);
        image(marioImg, pos.x, pos.y);
    }

    void fallLeft() {
        marioLeftEdgeCase();
        marioImg = jump_l;
        move(0, vel.y);
        image(marioImg, pos.x, pos.y);
    }

    void deadFall() {
        marioImg = dead;
        if (pos.y < height) {
            vel.y = 4.5;
            move(0, vel.y);
            image(marioImg, pos.x, pos.y);
        }
        else {
            resetGame();
            if (lives > 1) {
                livesTimer = millis();
                mario = new Mario(lives-1, numPts, numCoins);
                status = Game_Status.LIVES;
            }
            else {
                gameOverTimer = millis();
                if (numPts > highscore) highscore = numPts;
                status = Game_Status.GAME_OVER;
            }
        }
    }

    void moveMasks() {
        // Moving objects/masks to the left when right arrow pressed
        for (Block block : blocks) {
            block.move(-vel.x, 0);
        }
        for (FloorTile tile : floorTiles) {
            tile.move(-vel.x, 0);
        }
        for (FallTile fall : fallTiles) {
            fall.move(-vel.x, 0);
        }
        for (Mushroom mush : mushrooms) {
            mush.move(-vel.x, 0);
        }
        for (Coin coin: coinFromBlock) {
            coin.move(-vel.x, 0);
        }
        for (Pipe pipe : pipes) {
            pipe.move(-vel.x, 0);
        }
        for (Flower flower : flowers) {
            flower.move(-vel.x, 0);
        }
        for (Goomba goomba : goombas) {
            goomba.move(-vel.x,0);
        }
    }

    void collisionDetection() {
        for (CoinsBlock coin : coinBlocks) {
            if (getBoundsTop().intersects(coin.getBounds())) {
                vel.y = 0;
                hitBlock = true;
                coin.touched = true;
                pos.y = coin.pos.y + coin.ht + vel.y;
            } 
            else if (getBoundsBottom().intersects(coin.getBounds())) {
                vel.y = 0;
                hitBlock = true;
                pos.y = coin.pos.y - ht;
            }
            else if (getBoundsLeft().intersects(coin.getBounds())) {
                vel.x = 0;
                hitBlock = true;
                pos.x = coin.pos.x + coin.wd;
            } 
            else if (getBoundsRight().intersects(coin.getBounds())) {
                vel.x = 0;
                hitBlock = true;
                pos.x = coin.pos.x - wd;
            }
        }

        for (BrickBlock brick : brickBlocks) {
            if (getBoundsTop().intersects(brick.getBounds())) {
                //println("top of mario");
                vel.y = 0;
                hitBlock = true;
                brick.touched = true;
                pos.y = brick.pos.y + brick.ht;
            }
            if (getBoundsBottom().intersects(brick.getBounds())) {
                //println("bottom of mario");
                vel.y = 0;
                hitBlock = true;
                brick.touched = true;
                pos.y = brick.pos.y - ht;
            }
            if (getBoundsLeft().intersects(brick.getBounds())) {
                //println("left of mario");
                vel.x = 0;
                hitBlock = true;
                brick.touched = true;
                pos.x = brick.pos.x + brick.wd;
            }
            if (getBoundsRight().intersects(brick.getBounds())) {
                //println("right of mario");
                vel.x = 0;
                hitBlock = true;
                brick.touched = true;
                pos.x = brick.pos.x - wd;
            }
        }

        for (StepBlock step : stepBlocks) {
            if (getBoundsBottom().intersects(step.getBounds())) {
                //println("bottom of mario");
                vel.y = 0;
                hitBlock = true;
                pos.y = step.pos.y - ht;
            }
            if (getBoundsLeft().intersects(step.getBounds())) {
                //println("left of mario");
                vel.x = 0;
                hitBlock = true;
                pos.x = step.pos.x + step.wd;
            }
            if (getBoundsRight().intersects(step.getBounds())) {
                //println("right of mario");
                vel.x = 0;
                hitBlock = true;
                pos.x = step.pos.x - wd;
            }
        }
        for (Pipe pipe : pipes) {
            if (getBoundsBottom().intersects(pipe.getBounds())) {
                //println("bottom of mario");
                vel.y = 0;
                hitBlock = true;
                pos.y = pipe.pos.y - ht;
            }
            if (getBoundsLeft().intersects(pipe.getBounds())) {
                //println("left of mario");
                vel.x = 0;
                hitBlock = true;
                pos.x = pipe.pos.x + pipe.wd;
            }
            if (getBoundsRight().intersects(pipe.getBounds())) {
                //println("right of mario");
                vel.x = 0;
                hitBlock = true;
                pos.x = pipe.pos.x - wd;
            }
        }
        
        for (Mushroom mush : mushrooms) {
            if (getBounds().intersects(mush.getBounds())) {
                if (mush.count == 0) {
                    mush.remove = true;
                    mush.mushTimer = millis();
                    numPts += 1000;
                    mush.count++;
                }
            }
        }
        
        if(-world.x >= 3064) status = Game_Status.END;
    }


    Rectangle_2D getBounds() {
        //rect(pos.x + vel.x, pos.y + vel.y, wd, ht);
        return new Rectangle_2D(pos.x + vel.x + accel.x, pos.y + vel.y + accel.y, wd, ht);
    }

    // Fix these at some point, not accurate
    Rectangle_2D getBoundsTop() {
        //rect(pos.x + 2, pos.y, wd - 4, 2);
        return new Rectangle_2D(pos.x + 2 + vel.x, pos.y + vel.y + accel.y, wd - 4, 2);
    }

    // Good
    Rectangle_2D getBoundsBottom() {
        //rect(pos.x + 1 + vel.x, pos.y + ht + vel.y + accel.y - 1, wd - 2, 1);
        return new Rectangle_2D(pos.x + 1 + vel.x, pos.y + ht + vel.y + accel.y - 1, wd - 2, 1);
    }

    Rectangle_2D getBoundsLeft() {
        //rect(pos.x, pos.y + 1, 2, ht - 2);
        return new Rectangle_2D(pos.x + vel.x + accel.x, pos.y + 1 + vel.y, 2, ht - 2);
    }

    Rectangle_2D getBoundsRight() {
        //rect(pos.x + wd - 2, pos.y + 1, 2, ht - 2);
        return new Rectangle_2D(pos.x + wd - 2 + vel.x + accel.x, pos.y + 1 + vel.y, 2, ht - 2);
    }

    void endAnim(){
        if(firstRun){
            status = Game_Status.END;
            mario.movingR = false;
            marioImg = pole_grab_r;
            vel.x = 0;
            vel.y = 1.2;
            firstRun = false;
        }
        else if(getBoundsBottom().intersects(stepBlocks.get(stepBlocks.size()-1).getBounds()) && !collided){
            // Not currently working
            collided = true;
            pos.x += 16;
            marioImg = pole_grab_l;
            image(marioImg, pos.x, pos.y);
            delay(800);
            vel.x = 0.8;
            vel.y = 0;
            mario.movingR = true;
        } 
        else if(-world.x < world.wd && collided) {
                vel.y += accel.y;
                if(onGround()) vel.y = 0;
                
                if(-world.x + pos.x >= 3263) {
                    vel.x = 0;
                    
                    alpha -=5;
                    if(alpha <= 0) {
                        resetGame();
                        if (numPts > highscore) highscore = numPts;
                        mario.numPts = 0;
                        mario.numCoins = 0;
                        status = Game_Status.MAIN_MENU;
                    }
                    int numFrames = 2;
                    if (millis() > Game.startTime + 150) {
                        Game.startTime = millis();
                        anim_num = (anim_num + 1)%numFrames;
                        marioImg = loadImage("sprites/entities/mario/walkAway" + anim_num + ".png");
                    }
                    tint(255, 255, 255, alpha);
                    image(marioImg, pos.x, pos.y);
                    noTint();
                }
                else{                    
                    moveRight();
                    mario.movingR = true;
                }
        }
        this.move(vel.x, vel.y);
    }
    
    void endDisplay(){
        this.endAnim();
        if(!movingR) image(marioImg, pos.x, pos.y);
    }
}