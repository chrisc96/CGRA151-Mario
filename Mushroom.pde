public class Mushroom {

  int groundY = 200;
  ArrayList<Mushroom> removeArr = new ArrayList();

  // Animations
  int count = 0;
  boolean remove = false;

  // Sprites
  PImage mushroom = loadImage("sprites/entities/powerups/mushroom.png");
  int ht = mushroom.height;
  int wd = mushroom.width;

    int mushTimer;

  // States
  boolean spawning = true;

  // Movement
  PVector coinXY =  new PVector();
  PVector pos = new PVector();
  PVector vel = new PVector(1.3, 0.0);
  PVector accel = new PVector(0, 0);
  String dir;

  public Mushroom(PVector pos, int dir) {
    // 0 = right, 1 = left
    this.dir = (dir == 0) ? "right" : "left";

    this.coinXY.x = pos.x;
    this.coinXY.y = pos.y;
    this.pos.x = pos.x;
    this.pos.y = pos.y;
  }

  void display() {
    
    if (spawning) {
      this.spawn_animation();
    }
    else {
      // Mushroom AI should now occur
      collisionDetection();

      if (onBlock() || onGround()) {
        if (onGround()) pos.y = groundY - ht;
        vel.y = 0;
        accel.y = 0;
        // Move horizontally in current direction
        if (dir.equals("left")) {
          pos.x -= vel.x * speedMode;
          pos.y -= vel.y * speedMode;
        } 
        else if (dir.equals("right")) {
          pos.x += vel.x * speedMode;
          pos.y += vel.y * speedMode;
        }
      }
      else {
        //must be falling
        accel.y = -0.5;

        if (dir.equals("left")) {
          pos.x -= vel.x * speedMode;
          pos.y -= vel.y * speedMode;
        } 
        else if (dir.equals("right")) {
          pos.x += vel.x * speedMode;
          pos.y -= vel.y * speedMode;
        }
        vel.y += accel.y;
      }
    }
    image(mushroom, pos.x, pos.y + world.y);
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
    if (count != 0) return true;
    else {
      return false;
    }
  }

  boolean isFalling() {
    if (!onBlock() && !onGround()) {
      return true;
    }
    return false;
  }


  boolean toRemove() {
    if (mario.getBounds().intersects(getBounds())) {
        return true;
    }
    
    for (FallTile falling : fallTiles) {
      if (isFalling() && getBoundsTop().intersects(falling.getBoundsBottom())) {
        return true;
      }
    }
    if (this.pos.x + wd <= 0) {
      return true;
    }
    return false;
  }

  void collisionDetection() {
    for (Pipe pipe : pipes) {
      if (getBoundsBottom().intersects(pipe.getBounds())) {
        pos.y = pipe.pos.y - ht;
      }
      if (getBoundsRight().intersects(pipe.getBounds())) {
        dir = "left";
      }
      if (getBoundsLeft().intersects(pipe.getBounds())) {
        dir = "right";
      }
    }    
    for (StepBlock step : stepBlocks) {
      if (getBoundsBottom().intersects(step.getBounds())) {
        pos.y = step.pos.y - ht;
      }
      if (getBoundsRight().intersects(step.getBounds())) {
        dir = "left";
      }
      if (getBoundsLeft().intersects(step.getBounds())) {
        dir = "right";
      }
    }
  }

  // Movement that shifts his position based upon Mario's movement
  void move(float xAdd, float yAdd) {
    pos.x += xAdd;
    pos.y += yAdd;
  }

  void spawn_animation() {
    if (pos.y >= coinXY.y - ht + 1) {
      vel.y = 0.5;
      pos.y -= vel.y;
    } 
    else {
      vel.y = 0;
      spawning = false;
    }
  }


  // Bounding boxes
  Rectangle_2D getBounds() {
    return new Rectangle_2D(pos.x, pos.y, wd, ht);
  }

  // Fix these at some point, not accurate
  Rectangle_2D getBoundsTop() {
    //rect(pos.x + 2, pos.y, wd - 4, 2);
    return new Rectangle_2D(pos.x + 2, pos.y, wd - 4, 2);
  }

  // Good
  Rectangle_2D getBoundsBottom() {
    //rect(pos.x, pos.y + ht, wd, 2);
    return new Rectangle_2D(pos.x, pos.y + ht, wd, 2);
  }

  Rectangle_2D getBoundsLeft() {
    //rect(pos.x, pos.y + 1, 2, ht - 2);
    return new Rectangle_2D(pos.x, pos.y + 1, 2, ht - 2);
  }

  Rectangle_2D getBoundsRight() {
    //rect(pos.x + wd - 2, pos.y + 1, 2, ht - 2);
    return new Rectangle_2D(pos.x + wd - 2, pos.y + 1, 2, ht - 2);
  }
}