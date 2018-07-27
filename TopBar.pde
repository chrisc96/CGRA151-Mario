public class TopBar {
	
    ArrayList<PImage> coins = new ArrayList<PImage>();
    PImage coin;

    int timer = 150;
    int startTime2 = millis();
    int anim_num = 0;
    int length = 0;

    public TopBar() {
        coins.add(loadImage("sprites/entities/coin/coin_1.png"));
        coins.add(loadImage("sprites/entities/coin/coin_2.png"));
        coins.add(loadImage("sprites/entities/coin/coin_3.png"));
    }

    void display() {
        this.drawNumCoins();
        this.drawNumPts();
        this.drawTitle();
        this.drawTimer();
    }

    void drawNumCoins() {
        int numFrames = 3;

        if (anim_num == 0) {length = 750;}
        else if (anim_num == 1) {length = 500;}
        else if (anim_num == 2) {length = 250;}

        if (millis() > startTime2 + length) {
            startTime2 = millis();
            anim_num = (anim_num + 1)%numFrames;
        }

        if (anim_num < 3) {
            image(coins.get(anim_num), width/2.75 - 15, 30 - coins.get(0).height);
        }
        else {
            image(coins.get(anim_num-1), width/2.75 - 15, 30 - coins.get(0).height);
        }


        textSize(width/30);
        text("x",width/2.75,30);
        textSize(width/20);
        if (mario.numCoins < 10) {
            text("0" + mario.numCoins, width/2.75 + 10,30);
        }
        else {
            text(mario.numCoins, width/2.75 + 10, 30);
        }
    }

    void drawNumPts() {
        text("MARIO", width/30, 17.5);
        text(String.format("%06d", mario.numPts), width/30, 30);
    }

    void drawTitle() {
        text(world.name, width/1.9, 17.5);
        text(world.level, width/1.9, 30);
    }

    void drawTimer() {
        text("TIME", width/1.3, 17.5);

        if (status == Game_Status.PLAYING) {
            if (millis() - Game.countdownTimer >= 1000 && timer >= 0) {
                Game.countdownTimer = millis();
                timer -= 1;
            }
            else if (timer == 0) {
                resetGame();
                gameOverTimer = millis();
                status = Game_Status.TIME_UP;
            }

            text("" + String.valueOf(timer), width/1.3, 30);
        }else if (status == Game_Status.END){
            
            text("" + String.valueOf(timer), width/1.3, 30);
        }
    }
}