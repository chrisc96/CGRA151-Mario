public class BrickBlock extends Block{
    
    PImage normal = loadImage("sprites/entities/blocks/brick/brick.png");
    
    public BrickBlock(PVector pos) {
    	normal.resize(normal.width * SCALE, normal.height* SCALE);
        this.pos = pos;
    }
    
    void display() {
        image(normal, pos.x, pos.y);
    }
}