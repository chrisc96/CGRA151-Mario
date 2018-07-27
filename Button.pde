public class Button {
    
    // Fields
    PVector pos;
    color textColour, hoverColour;
    float size, tWidth;
    int numChars;
    String text;
    
    Button(String text, PVector pos, float size, color textColour, color hoverColour) {
        this.pos = pos;
        this.textColour = textColour;
        this.hoverColour = hoverColour;
        this.size = size;
        this.text = text;
        textSize(size);
        tWidth = textWidth(text);
    }
    
    boolean containsMouse() {
        // If mouse is inbetween the box surrounding the text itself
        if (mouseX >= pos.x && mouseX < pos.x + tWidth && mouseY > pos.y - size && mouseY < pos.y ) {
          return true;
        }
        else return false;
    }
  
    void drawBtns() {
        // Colour
        if (containsMouse()) {
            fill(hoverColour);
        }
        else {
            stroke(0);
            fill(textColour);
        }
        textAlign(LEFT);
        text(text, pos.x, pos.y);
    }
}