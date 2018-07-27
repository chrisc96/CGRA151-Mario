public class Block {

    // Fields
    PVector pos;
    PImage img;
    int wd = 16;
    int ht = 16;
    boolean touched;
    
    void move(float xAdd, float yAdd) {
        pos.x += xAdd;
        pos.y += yAdd;
    }
    
    Rectangle_2D getBounds() {
        return new Rectangle_2D(pos.x + 1, pos.y - 1, wd - 2, ht - 2);
    }
}