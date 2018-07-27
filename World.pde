public class World {

    PImage worldName;
    String name = "WORLD";
    String level = "1 - 1";
    float x, y;
    float wd, ht;


    public World() {
        worldName = loadImage("sprites/world/background/world-1-1_edit.png");
        this.x = 0;
        this.y = 0;
        this.wd = worldName.width;
        this.ht = worldName.height;
    }

    void display() {
        image(worldName, x, y);
    }

    void moveBG(float xAdd, float yAdd) {
        this.x += xAdd;
        this.y += yAdd;
    }
}