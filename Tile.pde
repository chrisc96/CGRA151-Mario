public class Tile {

    PVector pos;
    int wd;
    int ht;

    void move(float xAdd, float yAdd) {
        pos.x += xAdd;
        pos.y += yAdd;
    }
    
    Rectangle_2D getBounds() {
        return new Rectangle_2D(pos.x, pos.y, wd, ht);
    }
    
    Rectangle_2D getBoundsBottom() {
    //rect(pos.x, pos.y + ht, wd, 2);
    return new Rectangle_2D(pos.x, pos.y + ht, wd, 2);
  }
}