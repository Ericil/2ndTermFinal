import java.io.*;
import java.util.*;
boolean keyUp, keyDown, keyLeft, keyRight;//for movement of the player
ArrayList<Mob> currentmobs;//the mobs that will be spawned
Player theplayer = new Player(100, 100);//player
void setup() {
  size(800, 500);
  rectMode(CENTER);
  currentmobs = new ArrayList<Mob>();
  currentmobs.add(new Mob());//one mob for right now
}

void draw() {
  background(255);
  enemymovements();//movement of the enemies
  playermovements();//movement of the player
}

void playermovements(){//movement of player
  if(keyUp && playerinteractions(0)){//up
    theplayer.sety(theplayer.gety() - 5);
  }
  if(keyDown && playerinteractions(1)){//down
    theplayer.sety(theplayer.gety() + 5);
  }
  if(keyLeft && playerinteractions(2)){//left
    theplayer.setx(theplayer.getx() - 5);
  }
  if(keyRight && playerinteractions(3)){//right
    theplayer.setx(theplayer.getx() + 5);
  }
  rect(theplayer.getx(), theplayer.gety(), 20, 20);//drawing the player
}

void enemymovements(){// this is for one mob right now, later on,
//will store the boundaries of a mob's movement somewhere and access it here, this is just code to have something working
  for(int a = 0; a < currentmobs.size(); a++){
    rect(currentmobs.get(a).getx(), currentmobs.get(a).gety(), 20, 20);
  }
  for(int a = 0; a < currentmobs.size(); a++){
    if (currentmobs.get(a).getx() == 300){
      currentmobs.get(a).setmovement(true);
    }
    if (currentmobs.get(a).getx() == 100){
      currentmobs.get(a).setmovement(false);
    }
    print(currentmobs.get(a).getx() + " ");
    if(currentmobs.get(a).getmovement() == true){
      currentmobs.get(a).setx(currentmobs.get(a).getx()-1);
    }else{
      currentmobs.get(a).setx(currentmobs.get(a).getx()+1);
    }
  }
}
boolean playerinteractions(int a){//interaction of the player and other objects
  boolean trigger = true;
  if(a == 0){
    for(int b = 0; b < currentmobs.size(); b++){
      if(dist(theplayer.getx(), theplayer.gety(), currentmobs.get(b).getx(), currentmobs.get(b).gety()) <= 25){
        trigger = false;
      }
    }
  }
  if(a == 1){
    for(int b = 0; b < currentmobs.size(); b++){
      if(dist(theplayer.getx(), theplayer.gety(), currentmobs.get(b).getx(), currentmobs.get(b).gety()) <= 25){
        trigger = false;
      }
    }
  }
  if(a == 2){
    for(int b = 0; b < currentmobs.size(); b++){
      if(dist(theplayer.getx(), theplayer.gety(), currentmobs.get(b).getx(), currentmobs.get(b).gety()) <= 25){
        trigger = false;
      }
    }
  }
  if(a == 3){
    for(int b = 0; b < currentmobs.size(); b++){
      if(dist(theplayer.getx(), theplayer.gety(), currentmobs.get(b).getx(), currentmobs.get(b).gety()) <= 25){
        trigger = false;
      }
    }
  }
  
  
  return trigger;
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
