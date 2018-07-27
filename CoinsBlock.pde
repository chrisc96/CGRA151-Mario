public class CoinsBlock extends Block {
    
    // Images
    PImage current = new PImage();
    ArrayList<PImage> normal = new ArrayList<PImage>();
    PImage hit = loadImage("sprites/entities/blocks/coin/hit.png");
    
    int startTime1 = millis();
    int anim_num = 1;
    float rand;
    int countHit = 0;
    int length = 0;
    
    public CoinsBlock(PVector pos) {
        normal.add(loadImage("sprites/entities/blocks/coin/coin_1.png"));
        normal.add(loadImage("sprites/entities/blocks/coin/coin_2.png"));
        normal.add(loadImage("sprites/entities/blocks/coin/coin_3.png"));
        rand = random(1);
        this.pos = pos;
    }
    
    void display() {
        if (!touched) {
            int numFrames = 3;
            if (anim_num == 1) {length = 250;}
            else if (anim_num == 2) {length = 500;}
            else if (anim_num == 3) {length = 750;}

            if (millis() > startTime1 + length) {
                startTime1 = millis();
                if (anim_num == 1) {current = normal.get(0);}
                else if (anim_num == 2) {current = normal.get(1);}
                else if (anim_num == 3) {current = normal.get(2);}
                image(current, pos.x, pos.y);
                anim_num = (anim_num + 1)%numFrames;
            }
            else {
                current = normal.get((anim_num+1)%numFrames);
                image(current, pos.x, pos.y);
            }
        }
        else {
            //println("Coin X: " + pos.x);
            current = hit;
            image(current, pos.x, pos.y);
            this.MushroomOrCoin();
        }
    }
    
    void MushroomOrCoin() {
        if (rand < 0.8 && countHit == 0) {
            countHit++;
            mario.numPts += 100;
            Mushroom mushroom = new Mushroom(pos, (int) (random(2)));
            mushrooms.add(mushroom);
        }
        else {
            // display coin
            if (touched && countHit == 0) {
                countHit++;
                
                Coin coin = new Coin(this);
                coinFromBlock.add(coin);
                
                mario.numCoins += 1;
                mario.numPts += 200;
            }
        }
    }
}