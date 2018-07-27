public class Pipe {

    // Fields
    PVector pos = new PVector();
    PImage img = new PImage();
    int wd;
    int ht;
    PImage pipe_32 = loadImage("sprites/entities/pipes/pipe_32.png");
    PImage pipe_48 = loadImage("sprites/entities/pipes/pipe_48.png");
    PImage pipe_64 = loadImage("sprites/entities/pipes/pipe_64.png");

    public Pipe(PVector pos, int width, int height) {
        this.pos = pos;
        this.wd = width;
        this.ht = height;
        if (height == 32) img = pipe_32;
        if (height == 48) img = pipe_48;
        if (height == 64) img = pipe_64;
    }

    void display() {
        image(img,pos.x, pos.y);
    }
    
    void move(float xAdd, float yAdd) {
        pos.x += xAdd;
        pos.y += yAdd;
    }
    
    Rectangle_2D getBounds() {
        return new Rectangle_2D(pos.x + 1, pos.y - 1, wd - 2, ht - 2);
    }
}