public class Debugger {

    public Debugger() {
    }

    void fpsCounter() {
      surface.setTitle("FPS: " + frameRate);
    }


    void drawCollisionMasks() {
	    for (Block block : blocks) {
	        noStroke();
	        rect(block.pos.x, block.pos.y, block.wd, block.ht);
	    }
	    for (FloorTile tile : floorTiles) {
	        noStroke();
	        rect(tile.pos.x, tile.pos.y, tile.wd, tile.ht);
	    }
	    for (FallTile tile : fallTiles) {
	        noStroke();
	        rect(tile.pos.x, tile.pos.y, tile.wd, tile.ht);
	    }
	    for (Mushroom mush : mushrooms) {
	        noStroke();    
	        rect(mush.pos.x, mush.pos.y, mush.wd, mush.ht);   
	    }
	}
}