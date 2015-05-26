import java.io.*;
import java.util.*;
boolean keyUp, keyDown, keyLeft, keyRight;//for movement of the player
boolean canUp, canDown, canLeft, canRight;//if the player can move in that direction
ArrayList<Mob> currentmobs;//the mobs that will be spawned
ArrayList<Terrain> theterrain; //the terrain
Player theplayer = new Player(100, 350);//player
boolean onfloor;
int spd = 0;
void setup() {
  onfloor = false;
  size(800, 500);
  rectMode(CENTER);
  currentmobs = new ArrayList<Mob>();
  theterrain = new ArrayList<Terrain>();
  generateterrain();
  currentmobs.add(new Mob());//one mob for right now
}

void draw() {
  background(255);
  displayterrain();
  enemymovements();//movement of the enemies
  playermovements();//movement of the player
}

void playermovements(){//movement of player
  /*if(keyUp && playerinteractions(0)){//up
    theplayer.sety(theplayer.gety() - 5);
  }*/
  println("spd: " + spd + ", player interaction up: " + playerinteractions(0) + ", player interaction down: " + playerinteractions(1) + ", on the floor?: " + onfloor);
  if (spd >= 0 && playerinteractions(0)== true){//jumping, going up
    onfloor = false;
    theplayer.sety(theplayer.gety() - spd);
    spd--;
  }else if (spd < 0 && playerinteractions(1) == true){//jumping, going down
    theplayer.sety(theplayer.gety() - spd);
    spd--;
  }else if (playerinteractions(0) == false && onfloor == false  ){//jumping, interactions with entities above
    spd = -1;
    theplayer.sety(theplayer.gety() - spd);
  }
  /*
  if(keyDown && playerinteractions(1)){//down
    theplayer.sety(theplayer.gety() + 5);
  }
  */
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
    for(int b = 0; b < currentmobs.size(); b++){//mobs above
      if(dist(theplayer.getx(), theplayer.gety(), currentmobs.get(b).getx(), currentmobs.get(b).gety()) <= 25 && currentmobs.get(b).gety() < theplayer.gety()){
        trigger = false;
      }
    }
    for (int b = 0; b < theterrain.size(); b++){//terrain above
      if(dist(theplayer.getx(), theplayer.gety(), theterrain.get(b).getx(), theterrain.get(b).gety()) <= 25 && theterrain.get(b).gety() < theplayer.gety()){
        trigger = false;
      }
    }
  }
  if (a == 1){//down
    for(int b = 0; b < currentmobs.size(); b++){//mobs below
      if(dist(theplayer.getx(), theplayer.gety(), currentmobs.get(b).getx(), currentmobs.get(b).gety()) <= 25 && currentmobs.get(b).gety() > theplayer.gety()){
        trigger = false;
      }
    }
    for(int b = 0; b < theterrain.size(); b++){//terrain below
      if(dist(theplayer.getx(), theplayer.gety(), theterrain.get(b).getx(), theterrain.get(b).gety()) <= 25 && theterrain.get(b).gety() > theplayer.gety()){
        trigger = false;
        onfloor = true;
      }
    }
  }
  if (a == 2){//left
    for(int b = 0; b < currentmobs.size(); b++){//mobs to the left
      if(dist(theplayer.getx(), theplayer.gety(), currentmobs.get(b).getx(), currentmobs.get(b).gety()) <= 25 && currentmobs.get(b).getx() < theplayer.getx()){
        trigger = false;
      }
    }
    
    for (int b = 0; b < theterrain.size(); b++){//terrain to the left
      if(dist(theplayer.getx(), theplayer.gety(), theterrain.get(b).getx(), theterrain.get(b).gety()) <= 20 && theterrain.get(b).getx() < theplayer.getx()){
        trigger = false;
      }
    }
    
  }
  if (a == 3){//right
    for(int b = 0; b < currentmobs.size(); b++){//mobs to the right
      if(dist(theplayer.getx(), theplayer.gety(), currentmobs.get(b).getx(), currentmobs.get(b).gety()) <= 25 && currentmobs.get(b).getx() > theplayer.getx()){
        trigger = false;
      }
    }
    
    for (int b = 0; b < theterrain.size(); b++){//terrain to the right
      if(dist(theplayer.getx(), theplayer.gety(), theterrain.get(b).getx(), theterrain.get(b).gety()) <= 20 && theterrain.get(b).getx() > theplayer.getx()){
        trigger = false;
      }
    }
    
  }
  return trigger;
}

void generateterrain(){//making the terrain
  for(float a = 0; a < width; a = a + .5){
    theterrain.add(new Terrain(a, 400));
  }
  for(float a = 300; a < 350; a = a + .5){
    theterrain.add(new Terrain(a, 300));
  }
  for(float a = 350; a < 400; a = a + .5){
    theterrain.add(new Terrain(500., a));
  }
}

void displayterrain(){//drawing the terrain
  fill(0);
  for(int a = 0; a < theterrain.size(); a++){
    rect(theterrain.get(a).getx(), theterrain.get(a).gety(), 25, 25);
  }
  fill(255);
}
void keyPressed(){
  if (keyCode == 38 && onfloor){
    keyUp = true;
    spd = 15;
    onfloor = false;
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
