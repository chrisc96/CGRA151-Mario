boolean inAir = false; // true
boolean inPause = false;

void mousePressed() {
    if (status == Game_Status.PAUSE) {
        if (pauseMenu.menuButtons[0].containsMouse()) {
            // continue button
            status = Game_Status.PLAYING;
            loop();
        }
        else if (pauseMenu.menuButtons[1].containsMouse()) {
            // quit button
            delay(100);
            exit();
        }
    }
    else if (status == Game_Status.MAIN_MENU) {
        if (mainMenu.menuButtons[0].containsMouse()) {
            // continue button
            speedMode = 1;
            status = Game_Status.LIVES;
            livesTimer = millis();
            loop();
        }
        else if (mainMenu.menuButtons[1].containsMouse()) {
            // get round to doing fast mode
            speedMode = 1.75;
            status = Game_Status.LIVES;
            livesTimer = millis();
            loop();
        }
    }
}

void keyPressed() {
    
    // Pause Menu Handling
    if (keyCode == 'P') {
        if (status == Game_Status.PLAYING) {
            status = Game_Status.PAUSE;
        }
        else if (status == Game_Status.PAUSE) {
            status = Game_Status.PLAYING;
        }
    }
    
    if (status == Game_Status.PLAYING) {
        if (keyCode == RIGHT) {
            mario.sliding = false;
            mario.movingR = true;
            mario.movingL = false;
            mario.dir = "right";
        }
        else if (keyCode == LEFT) {
            // In mario you cannot go back, thus it only moves mario backwards
            // to the edge of the window
            mario.dir = "left";
            mario.sliding = false;
            mario.movingL = true;
            mario.movingR = false;
        }
        else if (keyCode == UP) {
            if (inAir) {
                mario.jumping = true;
            }
        }
    }
    
    else if (status == Game_Status.PAUSE) {
        if (keyCode == DOWN) {
            pauseMenu.currentSelection = 1;
        }
        else if (keyCode == UP) {
            pauseMenu.currentSelection = 0;
        }

        else if (keyCode == ENTER) {
            if (pauseMenu.currentSelection == 0) {
                // continue button
                status = Game_Status.PLAYING;
                loop();
            }
            else {
                // quit button
                delay(100);
                exit();
            }
        }
    }

    else if (status == Game_Status.MAIN_MENU) {
        if (keyCode == DOWN) {
            mainMenu.currentSelection = 1;
        }
        else if (keyCode == UP) {
            mainMenu.currentSelection = 0;
        }

        else if (keyCode == ENTER) {
            if (mainMenu.currentSelection == 0) {
                // continue button
                speedMode = 1;
                status = Game_Status.LIVES;
                livesTimer = millis();
                loop();
            }
            else {
                // get round to doing fast mode
                speedMode = 1.75;
                status = Game_Status.LIVES;
                livesTimer = millis();
                loop();
            }
        }
    }
}

void keyReleased() {
    mario.anim_num = 0;
    
    if (keyCode == LEFT) {
        if (mario.onGround() || mario.onBlock()) {
            mario.sliding = true;
        }
        // released left key in the air (as in not on ground or on a block)
        else {
          mario.LR_ReleasedInAir = true;
          mario.sliding = true;
        }
    }
    if (keyCode == RIGHT) {
        if (mario.onGround() || mario.onBlock()) {
            mario.sliding = true;
        }
        // released right key in the air (as in not on ground)
        else {
          mario.LR_ReleasedInAir = true;
          mario.sliding = true;
        }
    }
    
    if (keyCode == UP) {
        if (inAir) {
            if (mario.vel.y < 0) {
                mario.vel.y = 0;
            }
            inAir = false;
        }
    }
}