import java.io.*;
import java.util.*;

boolean keyUp, keyDown, keyLeft, keyRight;
Player theplayer = new Player(100, 100);
void setup() {
  size(800, 500);
}

void draw() {
  background(255);
  if(keyUp){
    theplayer.sety(theplayer.gety() - 5);
  }
  if(keyDown){
    theplayer.sety(theplayer.gety() + 5);
  }
  if(keyLeft){
    theplayer.setx(theplayer.getx() - 5);
  }
  if(keyRight){
    theplayer.setx(theplayer.getx() + 5);
  }
  rect(theplayer.getx(), theplayer.gety(), 20, 20);
}

void keyPressed(){
  if (keyCode == 38){
    keyUp = true;
  }
  if (keyCode == 37){
    keyLeft = true;
  }
  if (keyCode == 39){
    keyRight = true;
  }
  if (keyCode == 40){
    keyDown = true;
  }
}

void keyReleased(){
  if (keyCode == 38){
    keyUp = false;
  }
  if (keyCode == 37){
    keyLeft = false;
  }
  if (keyCode == 39){
    keyRight = false;
  }
  if (keyCode == 40){
    keyDown = false;
  }
}
