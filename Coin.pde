public class Coin {

	ArrayList<PImage> coins = new ArrayList<PImage>();
	PImage current = new PImage();

	PVector pos = new PVector();
	CoinsBlock block;
	PVector coinXY = new PVector();
	PVector vel = new PVector(0,-5.8);
	PVector accel = new PVector(0,0.22);

    int startTime1 = millis();
    int anim_num = 1;
    int length = 100;

    boolean remove = false;
    boolean first = true;

	public Coin(CoinsBlock block) {
		coins.add(loadImage("sprites/entities/powerups/coin_1.png"));
		coins.add(loadImage("sprites/entities/powerups/coin_2.png"));
		coins.add(loadImage("sprites/entities/powerups/coin_3.png"));
		this.pos.y = block.pos.y;
		this.pos.x = block.pos.x + block.wd/2 - (coins.get(0).width/2);
		this.block = block;
		this.coinXY = block.pos;
	}

	void display() {
		if (first) {
			if (vel.y >= 0) {
				first = false;
			}
		}
		else {
			if (pos.y >= coinXY.y - block.ht * 2) {
				vel.y = 0;
				accel.y = 0;
				remove = true;
			}
		}
		vel.y += accel.y;
		pos.y += vel.y;
		this.animation();
	}

	void animation() {
		int numFrames = 3;
        if (millis() > startTime1 + length) {
            startTime1 = millis();
            anim_num = (anim_num + 1)%numFrames;
            if (anim_num == 1) current = coins.get(0);
            else if (anim_num == 2) current = coins.get(1);
            else if (anim_num == 3) current = coins.get(2);
        }
        image(current, pos.x, pos.y);
	}

	// Movement that shifts his position based upon Mario's movement
	void move(float xAdd, float yAdd) {
		pos.x += xAdd;
		pos.y += yAdd;
	}

}