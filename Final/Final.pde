import java.io.*;
import java.util.*;
boolean keyUp, keyDown, keyLeft, keyRight;//for movement of the player
boolean canUp, canDown, canLeft, canRight;//if the player can move in that direction
ArrayList<Mob> currentmobs;//the mobs that will be spawned
ArrayList<Integer> startx, endx, starty, endy;
Player theplayer = new Player(100, 350);//player
boolean onfloor;
int spd = 0;
ArrayList<PImage> leftwalk, rightwalk, leftjump, rightjump;
String direction;
int leftnum, rightnum, leftjumpnum, rightjumpnum;
void setup() {
  frameRate(60);
  startx = new ArrayList<Integer>();
  endx = new ArrayList<Integer>();
  starty = new ArrayList<Integer>();
  endy =  new ArrayList<Integer>();
  leftwalk = new ArrayList<PImage>();
  rightwalk = new ArrayList<PImage>();
  leftjump = new ArrayList<PImage>();
  rightjump = new ArrayList<PImage>();
  leftnum = 0;
  rightnum = 0;
  leftjumpnum = 0;
  rightjumpnum = 0;
  direction = "right";
  onfloor = false;
  size(800, 500);
  rectMode(CENTER);
  currentmobs = new ArrayList<Mob>();
  generateterrain();
  currentmobs.add(new Mob());//one mob for right now
}

void draw() {
  //////println("\nCycle");
  ////////println(mouseX + "," +mouseY);
  background(255);
  displayterrain();
  enemymovements();//movement of the enemies
  playermovements();//movement of the player
  loadplayer();
}

void playermovements() {//movement of player
  ////println(onfloor);
  //println("0: " + playerinteractions(0) + ", 1: " + playerinteractions(1) + ", " + spd + " ,playerx: " + theplayer.getx() + " ,playery: " + theplayer.gety() + " ,projectedy: " + (theplayer.gety() - spd));
  if (playerinteractions(1) == "no terrain"){
    onfloor = false;
  }
  if (spd >= 0 && playerinteractions(0) == "no terrain") {//jumping, going upr
    theplayer.sety(theplayer.gety() - spd);
    spd--;
  }else if (spd < 0 && playerinteractions(1) == "no terrain" && onfloor == false) {//jumping, going down
    theplayer.sety(theplayer.gety() - spd);
    spd--;
    ////println("going down\t");
  }else if (playerinteractions(0) == "terrain" && onfloor == false) {//jumping, interactions with entities above
    spd = 0;
    theplayer.sety(theplayer.gety() - spd);
    spd --;
  }else if (playerinteractions(1) == "terrain" && onfloor == false){
    ////println("down collison");
    onfloor = true;
        settingy();
    spd = 0;
  }
  if (keyLeft && playerinteractions(2) == "no terrain") {//left
    if (direction != "left"){
      direction = "left";
      leftnum = 0;
    }else if(leftnum == 10){
      leftnum = 0;
    }else{
      leftnum++;
    }
    theplayer.setx(theplayer.getx() - 5);
  }
  if (keyRight && playerinteractions(3) == "no terrain") {//right
    if (direction != "right"){
      direction = "right";
      rightnum = 0;
    }else if (rightnum == 10){
      rightnum = 0;
    }else{
      rightnum++;
    }
    theplayer.setx(theplayer.getx() + 5);
  }
  //rect(theplayer.getx(), theplayer.gety(), 20, 20);//drawing the player
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
    rectMode(CORNER);
    if(endy.get(a).equals(starty.get(a))){
      rect(startx.get(a), starty.get(a), endx.get(a)-startx.get(a), 20);
    }else{
      rect(startx.get(a), starty.get(a), 20, endy.get(a)-starty.get(a));
    }
  }
  rectMode(CENTER);
  fill(255);
}
void keyPressed() {
  if (keyCode == 38 && onfloor) {
        ////println("up pressed");
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

void loadplayer(){
  if (direction == "left"){
    PImage hold = loadImage("left" + leftnum + ".png");
    image(hold, theplayer.getx() - 10, theplayer.gety() - 25);
  }
  if (direction == "right"){
    PImage hold = loadImage("right" + rightnum + ".png");
    image(hold, theplayer.getx() - 10, theplayer.gety() - 25);
  }
  
}
void settingy(){
  int holdx = theplayer.getx();
  int holdy = theplayer.gety();
  if (terrainint(1) == "terrain"){
    if ((holdx >= 0 && holdx <= 300) || (holdx >= 350 && holdx <= 490) || (holdx >= 510 && holdx <= 800)){
      theplayer.sety(390);
    }
    if ((holdx > 290 && holdx <  360)){
      //////println("undercover");
      if(holdy - spd >= 280 && holdy - spd <= 300){
        theplayer.sety(290);
      }
      if(holdy - spd >= 390){
        //////println("trigger");
        theplayer.sety(390);
      }
    }
    if ((holdx > 490 && holdx < 530)){
      theplayer.sety(340);
    }
  }
}
String terrainint(int a){
  String trigger = "no terrain";
  int holdx = theplayer.getx();
  int holdy = theplayer.gety();
  if(a == 0){
    if (holdx > 290 && holdx < 360){
      if (holdy - spd <= 320 && holdy - spd >= 300){
        trigger = "terrain";
      }
    }
  }
  if(a == 1){
    //////println("Down: triggering");
    //////println(holdx);
    //////println(holdx >= 0 && holdx <= 300);
    if ((holdx >= 0 && holdx <= 300) || (holdx >= 350 && holdx <= 350) || (holdx >= 350 && holdx <= 510) || (holdx >= 530 && holdx <= 800)){
      if (holdy - spd >= 390){
        //////println("triggering 2");
        trigger = "terrain";
      }
    }
    if ((holdx > 290 && holdx < 360)){
      if(holdy - spd >= 290 && holdy - spd <= 310){
        trigger = "terrain";
      }
      if(holdy - spd >= 390 && holdy - spd <= 410){
        trigger = "terrain";
      }
    }
    if ((holdx > 490 && holdx < 530)){
      if (holdy - spd >= 340 && holdy - spd < 360){
        trigger = "terrain";
      }
    }
  }
  if (a == 2){//terrain on left
    if (holdx == 360 && (holdy >= 290 && holdy <= 310)){
     trigger = "terrain";
    } 
    if (holdx == 530 && (holdy >= 340 && holdy <= 390)){
      trigger = "terrain";
    }
  }
  if (a == 3){//terrain on right
    if (holdx == 290 && (holdy >= 300 && holdy <= 320)){
      trigger = "terrain";
    }
    if(holdx == 490 && (holdy >= 340 && holdy <= 390)){
       trigger = "terrain";
    }
  }
  return trigger;
}
