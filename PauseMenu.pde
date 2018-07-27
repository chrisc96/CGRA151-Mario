public class PauseMenu {

    int currentSelection = 0;

    // Fields
    static final int numButtons = 2;
    Button[] menuButtons;
    String[] menuStrings;
    
    public PauseMenu() {
        menuButtons = new Button[numButtons];
        menuStrings = new String[numButtons];
    }
    
    void createButtons() {
        menuStrings[0] = "CONTINUE";
        menuStrings[1] = "QUIT";
        menuButtons[0] = new Button(menuStrings[0], new PVector(0.29*width + (0.2*(0.4*width)),0.1*height + 0.275*height),width/height * 15,color(255),color(#FF0000));
        menuButtons[1] = new Button(menuStrings[1], new PVector(0.29*width + (0.2*(0.4*width)),0.1*height + 0.40*height),width/height * 15,color(255),color(#FF0000));
    }
    
    void display() {
        noStroke();
        fill(#2C2C2C);
        rectMode(CORNERS);
        stroke(0);
        rect(0 + 0.25*width, 0 + 0.25*height, 0 + 0.75*width, 0 + 0.575*height);
        rectMode(CORNER); // setting back to default
        for (int i = 0; i < menuButtons.length; i++) {
            menuButtons[i].drawBtns();
        }
        fill(#A7A7A7);
        if (currentSelection == 0) {
            PVector p1 = new PVector(0.2*width + (0.2*(0.4*width)), 0.1*height + 0.23*height);
            PVector p2 = new PVector(p1.x, (0.1*height + 0.27*height));

            PVector p3 = new PVector(0.25*width + (0.2*(0.4*width)), (p1.y + p2.y)/2);
            triangle(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y);
        }
        else {
            PVector p1 = new PVector(0.2*width + (0.2*(0.4*width)), 0.1*height + 0.36*height);
            PVector p2 = new PVector(p1.x, (0.1*height + 0.40*height));

            PVector p3 = new PVector(0.25*width + (0.2*(0.4*width)), (p1.y + p2.y)/2);
            triangle(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y);
        }
        fill(255);
    }
}