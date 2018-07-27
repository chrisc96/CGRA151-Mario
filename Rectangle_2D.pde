public class Rectangle_2D {

    PVector pos = new PVector();
    float wd;
    float ht;
    
    public Rectangle_2D(float pos_x, float pos_y, float wd, float ht) {
        this.pos.x = pos_x;
        this.pos.y = pos_y;
        this.wd = wd;
        this.ht = ht;
    }
    
    boolean intersects(Rectangle_2D obj) {
        double x0 = this.pos.x;
        double y0 = this.pos.y;
 
        return (obj.pos.x + obj.wd > x0 && obj.pos.y + obj.ht > y0 && obj.pos.x < x0 + wd && obj.pos.y < y0 + ht);
    }
}