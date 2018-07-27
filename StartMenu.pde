public class StartMenu {
	
    int currentSelection = 0;
    PImage selector = loadImage("sprites/world/menus/pointer.png");

    // Fields
    static final int numButtons = 2;
    Button[] menuButtons;
    String[] menuStrings;
    
    public StartMenu() {
        menuButtons = new Button[numButtons];
        menuStrings = new String[numButtons];
    }
    
    void createButtons() {
        menuStrings[0] = "NORMAL MODE";
        menuStrings[1] = "FAST MODE";
        menuButtons[0] = new Button(menuStrings[0], new PVector(0.20*width + (0.2*(0.4*width)),0.1*height + 0.575*height),width/height * 15,color(255),color(#FF0000));
        menuButtons[1] = new Button(menuStrings[1], new PVector(0.20*width + (0.2*(0.4*width)),0.1*height + 0.65*height),width/height * 15,color(255),color(#FF0000));
    }
    
    void display() {
        noStroke();
        for (int i = 0; i < menuButtons.length; i++) {
            menuButtons[i].drawBtns();
        }
        fill(#A7A7A7);

        // Triangles

        if (currentSelection == 0) {
        	image(selector,0.125*width + (0.2*(0.4*width)),0.1*height + 0.54*height);
        }
        else {
        	image(selector,0.125*width + (0.2*(0.4*width)),0.1*height + 0.61*height);
        }
        fill(255);
    }
}