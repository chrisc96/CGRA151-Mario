public class Flower {

	ArrayList<PImage> flowers = new ArrayList<PImage>();
	PImage current = new PImage();

	PVector origin_pos;
	PVector pos = new PVector();
	PVector vel = new PVector(0,-0.3);

	int flowerTimer = millis();
	int lngth = 250;
	int count = 0;
	int delayAtBot = 300;
	int anim_num = 1;

	public Flower(PVector pos) {
		flowers.add(loadImage("sprites/entities/enemies/flower_1.png"));
		flowers.add(loadImage("sprites/entities/enemies/flower_2.png"));
		this.origin_pos = new PVector(pos.x,pos.y);
		this.pos = pos;
	}

	void display() {
		pos.y += vel.y * speedMode;

		if (pos.y < origin_pos.y - current.height || pos.y >= origin_pos.y + current.height/4) {
			vel.y *= -1;
		}
		this.animation();
	}

	void animation() {
		int numFrames = 2;
	    if (millis() > flowerTimer + lngth) {
	        flowerTimer = millis();
	        anim_num = (anim_num + 1)%numFrames;
	    }
        if (anim_num == 0) current = flowers.get(0);
        else if (anim_num == 1) current = flowers.get(1);
	    image(current, pos.x, pos.y);
	}

	void move(float xAdd, float yAdd) {
		pos.x += xAdd;
		pos.y += yAdd;
	}

	Rectangle_2D getBounds() {
    	return new Rectangle_2D(pos.x, pos.y, current.width, current.height);
  	}
}