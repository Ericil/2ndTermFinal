import java.io.*;
import java.util.*;
boolean keyUp, keyDown, keyLeft, keyRight;//for movement of the player
boolean canUp, canDown, canLeft, canRight;//if the player can move in that direction
ArrayList<Mob> currentmobs;//the mobs that will be spawned
ArrayList<Integer> startx, endx, starty, endy;
Player theplayer = new Player(100, 350);//player
boolean onfloor;
int spd = 0;
void setup() {
  startx = new ArrayList<Integer>();
  endx = new ArrayList<Integer>();
  starty = new ArrayList<Integer>();
  endy =  new ArrayList<Integer>();
  onfloor = true;
  size(800, 500);
  rectMode(CENTER);
  currentmobs = new ArrayList<Mob>();
  generateterrain();
  currentmobs.add(new Mob());//one mob for right now
}

void draw() {
  println("\nCycle");
  background(255);
  displayterrain();
  enemymovements();//movement of the enemies
  playermovements();//movement of the player
}

void playermovements() {//movement of player
  println("0: " + playerinteractions(0) + ", 1: " + playerinteractions(1) + ", " + spd + " ,playerx: " + theplayer.getx() + " ,playery: " + theplayer.gety());
  if (spd >= 0 && playerinteractions(0) == "no terrain") {//jumping, going up
    println("up");
    onfloor = false;
    theplayer.sety(theplayer.gety() - spd);
    spd--;
  }else if (spd < 0 && playerinteractions(1) == "no terrain") {//jumping, going down
    println("down");
    theplayer.sety(theplayer.gety() - spd);
    spd--;
    println("going down\t");
  }else if (playerinteractions(0) == "terrain" && onfloor == false) {//jumping, interactions with entities above
    println("up collison");
    theplayer.sety(theplayer.gety() - spd);
        spd = -1;
        println("hit\t");
  }else if (playerinteractions(1) == "terrain"){
    println("down collison");
    onfloor = true;
    spd = 0;
    settingy();
  }
  if (keyLeft && playerinteractions(2) == "no terrain") {//left
    theplayer.setx(theplayer.getx() - 5);
  }
  if (keyRight && playerinteractions(3) == "no terrain") {//right
    theplayer.setx(theplayer.getx() + 5);
  }
  rect(theplayer.getx(), theplayer.gety(), 20, 20);//drawing the player
}

void enemymovements() {// this is for one mob right now, later on,
  //will store the boundaries of a mob's movement somewhere and access it here, this is just code to have something working
  for (int a = 0; a < currentmobs.size (); a++) {
    rect(currentmobs.get(a).getx(), currentmobs.get(a).gety(), 20, 20);
  }
  for (int a = 0; a < currentmobs.size (); a++) {
    if (currentmobs.get(a).getx() == 300) {
      currentmobs.get(a).setmovement(true);
    }
    if (currentmobs.get(a).getx() == 100) {
      currentmobs.get(a).setmovement(false);
    }
    if (currentmobs.get(a).getmovement() && mobinteractions(a, 2)) {
      currentmobs.get(a).setx(currentmobs.get(a).getx()-1);
    } else if (mobinteractions(a, 3)) {
      currentmobs.get(a).setx(currentmobs.get(a).getx()+1);
    }
  }
}

boolean mobinteractions(int a, int b) {
  boolean trigger = true;
  if (b == 0) {//up
    if (dist(currentmobs.get(a).getx(), currentmobs.get(a).gety(), theplayer.getx(), theplayer.gety()) <= 25 && currentmobs.get(a).gety() < theplayer.gety()) {
      trigger = false;
    }
  }
  if (b == 1) {//down
    if (dist(currentmobs.get(a).getx(), currentmobs.get(a).gety(), theplayer.getx(), theplayer.gety()) <= 25 && currentmobs.get(a).gety() > theplayer.gety()) {
      trigger = false;
    }
  }
  if (b == 2) {//left
    if (dist(currentmobs.get(a).getx(), currentmobs.get(a).gety(), theplayer.getx(), theplayer.gety()) <= 25 && currentmobs.get(a).getx() > theplayer.getx()) {
      trigger = false;
    }
  }
  if (b == 3) {//right
    if (dist(currentmobs.get(a).getx(), currentmobs.get(a).gety(), theplayer.getx(), theplayer.gety()) <= 25 && currentmobs.get(a).getx() < theplayer.getx()) {
      trigger = false;
    }
  }
  return trigger;
}
String playerinteractions(int a) {
  String trigger = "no terrain";
  if (a == 0) {//up
    for (int b = 0; b < currentmobs.size (); b++) {//mobs above
      if (dist(theplayer.getx(), theplayer.gety(), currentmobs.get(b).getx(), currentmobs.get(b).gety()) <= 25 && currentmobs.get(b).gety() < theplayer.gety()) {
        trigger = "terrain";
      }
    }
    if(terrainint(0) == "terrain"){
      trigger = "terrain";
    }
  }
  if (a == 1) {//down
    for (int b = 0; b < currentmobs.size (); b++) {//mobs below
      if (dist(theplayer.getx(), theplayer.gety(), currentmobs.get(b).getx(), currentmobs.get(b).gety()) <= 25 && currentmobs.get(b).gety() > theplayer.gety()) {
        trigger = "terrain";
      }
    }
    if(terrainint(1) == "terrain"){
      trigger = "terrain";
    }
  }
  if (a == 2) {//left
    for (int b = 0; b < currentmobs.size (); b++) {//mobs to the left
      if (dist(theplayer.getx(), theplayer.gety(), currentmobs.get(b).getx(), currentmobs.get(b).gety()) <= 25 && currentmobs.get(b).getx() < theplayer.getx()) {
        trigger = "terrain";
      }
    }
    if(terrainint(2) == "terrain"){
      trigger = "terrain";
    }
  }
  if (a == 3) {//right
    for (int b = 0; b < currentmobs.size (); b++) {//mobs to the right
      if (dist(theplayer.getx(), theplayer.gety(), currentmobs.get(b).getx(), currentmobs.get(b).gety()) <= 25 && currentmobs.get(b).getx() > theplayer.getx()) {
        trigger = "terrain";
      }
    }
    if(terrainint(3) == "terrain"){
      trigger = "terrain";
    }
  }
  return trigger;
}

void generateterrain() {//making the terrain
  helpergenterrain(0, width, 400, 400);
  helpergenterrain(300, 350, 300, 300);
  helpergenterrain(500, 500, 350, 400);
}

void helpergenterrain(int a, int b, int c, int d){
  startx.add(a);
  endx.add(b);
  starty.add(c);
  endy.add(d);
}
void displayterrain() {
  //drawing the terrain
  
  fill(0);
  for (int a = 0; a < startx.size(); a++) {
    if(endy.get(a).equals(starty.get(a))){
      rect((endx.get(a)+startx.get(a))/2, endy.get(a), endx.get(a)-startx.get(a), 20);
    }else{
      rect(endx.get(a), (endy.get(a)+starty.get(a))/2, 20, endy.get(a)-starty.get(a));
    }
  }
  fill(255);
}
void keyPressed() {
  if (keyCode == 38 && onfloor) {
        println("up pressed");
    keyUp = true;
    spd = 15;
    onfloor = false;
  }
  if (keyCode == 37) {
    keyLeft = true;
  }
  if (keyCode == 39) {
    keyRight = true;
  }
  if (keyCode == 40) {
    keyDown = true;
  }
}

void keyReleased() {
  if (keyCode == 38) {
    keyUp = false;
  }
  if (keyCode == 37) {
    keyLeft = false;
  }
  if (keyCode == 39) {
    keyRight = false;
  }
  if (keyCode == 40) {
    keyDown = false;
  }
}
void settingy(){
  int holdx = theplayer.getx();
  int holdy = theplayer.gety();
    if ((holdx >= 0 && holdx <= 300) || (holdx >= 350 && holdx <= 490) || (holdx >= 510 && holdx <= 800)){
      theplayer.sety(380);
    }
    if ((holdx >= 300 && holdx <= 350)){
      println("undercover");
      if(holdy <= 280){
        theplayer.sety(280);
      }
      if(holdy >= 300 && holdy <= 400){
        println("trigger");
        theplayer.sety(380);
      }
    }
}
String terrainint(int a){
  String trigger = "no terrain";
  int holdx = theplayer.getx();
  int holdy = theplayer.gety();
  if(a == 0){
    if (holdx >= 300 && holdx <= 350){
      if (holdy == 300){
        trigger = "terrain";
      }
    }
  }
  if(a == 1){
    println("Down: triggering");
    println(holdx);
    println(holdx >= 0 && holdx <= 490);
    if ((holdx >= 0 && holdx <= 300) || (holdx >= 350 && holdx <= 490) || (holdx >= 510 && holdx <= 800)){
      if (holdy + spd >= 370){
        println("triggering 2");
        trigger = "terrain";
      }
    }
    if ((holdx >= 300 && holdx <= 350)){
      if(holdy <= 280){
        trigger = "terrain";
      }
      if(holdy >= 300 && holdy <= 400){
        trigger = "terrain";
      }
    }
    if ((holdx >= 490 && holdx <= 510)){
      if (holdy == 350){
        trigger = "terrain";
      }
    }
  }
  return trigger;
}
