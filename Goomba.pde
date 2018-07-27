public class Goomba  {

	int groundY = 200;

	PVector pos = new PVector();
	PVector vel = new PVector(0.8, 0.0);
  	PVector accel = new PVector(0, 0);
  	String dir = "left";

	boolean remove = false;
	int count = 0;

  	int goombaTimer = millis();
    int lngth = 250;
  	int anim_num = 0;

	ArrayList<PImage> images = new ArrayList<PImage>();
	PImage current = new PImage();
    int ht;
    int wd;

	public Goomba(PVector pos) {
		images.add(loadImage("sprites/entities/enemies/goomba_r.png"));
        ht = images.get(0).height;
        wd = images.get(0).width;
		images.add(loadImage("sprites/entities/enemies/goomba_l.png"));
		this.pos = pos;
	}

	void display() {
        
        //println("posX: " + pos.x + "      posY: " + pos.y + "                 velX: " + vel.x + "       velY: " + vel.y + "              accelX: " + accel.x + "        accelY: " + accel.y);
        //println("OnGround: " + onGround() + "          onBlock: " + onBlock());
		collisionDetection();
		if (onBlock() || onGround()) {
            if (onGround()) { 
                pos.y = groundY - ht;
            }
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
		this.animation();
	}

	void animation() {
		int numFrames = 2;
		if (millis() > goombaTimer + lngth) {
			goombaTimer = millis();
			anim_num = (anim_num + 1)%numFrames;
		}
		if (anim_num == 0) current = images.get(0);
		else if (anim_num == 1) current = images.get(1);
		image(current, pos.x, pos.y);
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
		if (mario.getBounds().intersects(getBoundsTop())) {
            if (count == 0) {
                displayMsg = true;
                HitTimer = millis();
                remove = true;
                mario.numPts += 500;
                count++;
		    }
            return true;
        }
        else if (mario.getBoundsLeft().intersects(getBoundsRight()) || mario.getBoundsRight().intersects(getBoundsLeft()) || mario.getBoundsTop().intersects(getBoundsBottom())) {return false;}
        
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

	// Movement that shifts his position based upon Mario's movement
	void move(float xAdd, float yAdd) {
		pos.x += xAdd;
		pos.y += yAdd;
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

	// Bounding boxes
	Rectangle_2D getBounds() {
		return new Rectangle_2D(pos.x,pos.y,wd,ht);
	}

	// Fix these at some point, not accurate
	Rectangle_2D getBoundsTop() {
        //rect(pos.x+2, pos.y - 2, wd-4, 1);
		return new Rectangle_2D(pos.x+2, pos.y - 2, wd-4, 1);
	}

	// Good
	Rectangle_2D getBoundsBottom() {
        //rect(pos.x, pos.y + ht - 2, wd, 2);
		return new Rectangle_2D(pos.x, pos.y + ht - 2, wd, 2);
	}

	Rectangle_2D getBoundsLeft() {
        //rect(pos.x, pos.y, 2, ht);
		return new Rectangle_2D(pos.x, pos.y, 2, ht);
	}

	Rectangle_2D getBoundsRight() {
        //rect(pos.x + wd - 2, pos.y, 2, ht);
		return new Rectangle_2D(pos.x + wd - 2, pos.y, 2, ht);
	}
}