import java.io.*;
import java.util.*;
boolean keyUp, keyDown, keyLeft, keyRight;//for movement of the player
boolean canUp, canDown, canLeft, canRight;//if the player can move in that direction
ArrayList<Mob> currentmobs;//the mobs that will be spawned
Player theplayer = new Player(100, 400);//player
int floor = 400;
int spd = 0;
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
  /*if(keyUp && playerinteractions(0)){//up
    theplayer.sety(theplayer.gety() - 5);
  }*/
  if (spd > 0 || theplayer.gety() < floor){
    theplayer.sety(theplayer.gety() - spd);
    spd--;
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
    if(currentmobs.get(a).getmovement() && mobinteractions(a, 2)){
      currentmobs.get(a).setx(currentmobs.get(a).getx()-1);
    }else if(mobinteractions(a, 3)){
      currentmobs.get(a).setx(currentmobs.get(a).getx()+1);
    }
  }
}

boolean mobinteractions(int a, int b){
  boolean trigger = true;
  if (b == 0){//up
    if(dist(currentmobs.get(a).getx(), currentmobs.get(a).gety(), theplayer.getx(), theplayer.gety()) <= 25 && currentmobs.get(a).gety() < theplayer.gety()){
      trigger = false;
    }
  }
  if (b == 1){//down
    if(dist(currentmobs.get(a).getx(), currentmobs.get(a).gety(), theplayer.getx(), theplayer.gety()) <= 25 && currentmobs.get(a).gety() > theplayer.gety()){
      trigger = false;
    }
  }
  if (b == 2){//left
    if(dist(currentmobs.get(a).getx(), currentmobs.get(a).gety(), theplayer.getx(), theplayer.gety()) <= 25 && currentmobs.get(a).getx() > theplayer.getx()){
      trigger = false;
    }
  }
  if (b == 3){//right
    if(dist(currentmobs.get(a).getx(), currentmobs.get(a).gety(), theplayer.getx(), theplayer.gety()) <= 25 && currentmobs.get(a).getx() < theplayer.getx()){
      trigger = false;
    }
  }
  return trigger;
}
boolean playerinteractions(int a){
  boolean trigger = true;
  if (a == 0){//up
    for(int b = 0; b < currentmobs.size(); b++){
      if(dist(theplayer.getx(), theplayer.gety(), currentmobs.get(b).getx(), currentmobs.get(b).gety()) <= 25 && currentmobs.get(b).gety() < theplayer.gety()){
        trigger = false;
      }
    }
  }
  if (a == 1){//down
    for(int b = 0; b < currentmobs.size(); b++){
      if(dist(theplayer.getx(), theplayer.gety(), currentmobs.get(b).getx(), currentmobs.get(b).gety()) <= 25 && currentmobs.get(b).gety() > theplayer.gety()){
        trigger = false;
      }
    }
  }
  if (a == 2){//left
    for(int b = 0; b < currentmobs.size(); b++){
      if(dist(theplayer.getx(), theplayer.gety(), currentmobs.get(b).getx(), currentmobs.get(b).gety()) <= 25 && currentmobs.get(b).getx() < theplayer.getx()){
        trigger = false;
      }
    }
  }
  if (a == 3){//right
    for(int b = 0; b < currentmobs.size(); b++){
      if(dist(theplayer.getx(), theplayer.gety(), currentmobs.get(b).getx(), currentmobs.get(b).gety()) <= 25 && currentmobs.get(b).getx() > theplayer.getx()){
        trigger = false;
      }
    }
  }
  return trigger;
}

void keyPressed(){
  if (keyCode == 38 && theplayer.gety() >= floor){
    //keyUp = true;
    spd = 15;
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
