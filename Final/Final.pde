import java.io.*;
import java.util.*;
boolean keyUp, keyDown, keyLeft, keyRight;//for movement of the player
boolean canUp, canDown, canLeft, canRight;//if the player can move in that direction
ArrayList<Mob> currentmobs;//the mobs that will be spawned
ArrayList<Integer> startx, endx, starty, endy;
Player theplayer;
boolean onfloor;
int spd = 0;
ArrayList<PImage> leftwalk, rightwalk, leftjump, rightjump;
String direction;
int leftnum, rightnum, jumpnum, idlenum;
boolean idleleft = true;
boolean idleright = true;
int intervalleft, intervalright, intervalidle;
int projectedx, projectedy;
int shift;
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
  starting();
  size(800, 500);
  rectMode(CENTER);
  currentmobs = new ArrayList<Mob>();
  generateterrain();
  currentmobs.add(new Mob());//one mob for right now
}

void starting(){
    theplayer = new Player(100, 350);
    spd = 0;
    leftnum = 0;
    rightnum = 0;
    jumpnum = 0;
    idlenum = 0;
    intervalleft = 0;
    intervalright = 0;
    intervalidle = 0;
    projectedx = theplayer.getx();
    projectedy = theplayer.gety();
    shift = 0;
    direction = "right";
    onfloor = false;
}
void draw() {
  if(theplayer.gety() > 700){
    starting();
  }
  //////println("\nCycle");
  ////////println(mouseX + "," +mouseY);
  background(255);
  displayterrain();
  //enemymovements();//movement of the enemies
  playermovements();//movement of the player
  loadplayer();
}

void playermovements() {//movement of player
  println(theplayer.getx() + "," + theplayer.gety() + ":" + projectedx + "," + projectedy + ":" + (projectedx - shift));
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
  if(onfloor == false){
    if (spd == 0){
      jumpnum = 5;
    }
    if (spd == 15){
      jumpnum = 0;
    }
    if (spd < 15 && spd >= 11){
      jumpnum = 1;
    }
    if (spd < 11 && spd >= 7){
      jumpnum = 2;
    }
    if (spd < 7 && spd >= 4){
      jumpnum = 3;
    }
    if (spd < 4 && spd >= 1){
      jumpnum = 4;
    }
    if (spd < 0 && spd >= -4){
      jumpnum = 6;
    }
    if (spd < -4 && spd >= -8){
      jumpnum = 7;
    }
    if (spd < -8 && spd >= -12){
      jumpnum = 8;
    }
    if (spd < -12 && spd >= -16){
      jumpnum = 9;
    }
    if (spd < -16){
      jumpnum = 10;
    }
  }
  if (keyLeft && playerinteractions(2) == "no terrain") {//left
    if(projectedx < 400){
      theplayer.setx(theplayer.getx() - 5);
    }else{
      shift = shift - 5;
    }
    projectedx = projectedx - 5;
  }
  if (keyRight && playerinteractions(3) == "no terrain") {//right
    if(projectedx < 400){
      theplayer.setx(theplayer.getx() + 5);
    }else{
      shift = shift + 5;
    }
    projectedx = projectedx + 5;
  }
  if (keyRight && onfloor == false){
    if(direction != "right"){
      direction = "right";
    }
  }
  if (keyLeft && onfloor == false){
    if(direction != "left"){
      direction = "left";
    }
  }
  if(keyRight && onfloor == true){
    if(intervalright == 3){
      if (direction != "right"){
        direction = "right";
        rightnum = 0;
      }else if (rightnum == 10){
        rightnum = 0;
      }else{
        rightnum++;
      }
      intervalright = 0;
    }else{
      intervalright++;
    }
  }
  if(keyLeft && onfloor == true){
    if(intervalleft == 3){
      if (direction != "left"){
        direction = "left";
        leftnum = 0;
      }else if(leftnum == 10){
        leftnum = 0;
      }else{
        leftnum++;
      }
      intervalleft = 0;
    }else{
      intervalleft++;
    }
  }
  if(keyUp == false && keyDown == false && keyRight == false && keyLeft == false && onfloor == true){
    if(intervalidle == 2){
      if(idlenum == 7){
        idlenum = 0;
      }else{
        idlenum++;
      }
      intervalidle = 0;
    }else{
      intervalidle++;
    }
  }
  //rect(theplayer.getx(), theplayer.gety(), 20, 20);//drawing the player
}

/*
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
*/
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

void keyPressed() {
  if (keyCode == 38 && onfloor) {
        ////println("up pressed");
    keyUp = true;
    spd = 15;
    onfloor = false;
  }
  if (keyCode == 37) {
    keyLeft = true;
    idleleft = false;
  }
  if (keyCode == 39) {
    keyRight = true;
    idleright = false;
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
    idleleft = true;
  }
  if (keyCode == 39) {
    keyRight = false;
    idleright = true;
  }
  if (keyCode == 40) {
    keyDown = false;
  }
}

void loadplayer(){
  if (onfloor == true){
    if (direction == "left" && idleleft == false){
      PImage hold = loadImage("left" + leftnum + ".png");
      image(hold, theplayer.getx() - 10, theplayer.gety() - 25);
    }
    if (direction == "left" && idleleft == true){
      PImage hold = loadImage("idleleft" + idlenum + ".png");
      image(hold, theplayer.getx() - 10, theplayer.gety() - 25);
    }
    if (direction == "right" && idleright == false){
      PImage hold = loadImage("right" + rightnum + ".png");
      image(hold, theplayer.getx() - 10, theplayer.gety() - 25);
    }
    if (direction == "right" && idleright == true){
      PImage hold = loadImage("idleright" + idlenum + ".png");
      image(hold, theplayer.getx() - 10, theplayer.gety() - 25);
    }
  }else{
    if (direction == "right"){
      PImage hold = loadImage("jumpright" + jumpnum + ".png");
      image(hold, theplayer.getx() - 10, theplayer.gety() - 25);
    }
    if (direction == "left"){
      PImage hold = loadImage("jumpleft" + jumpnum + ".png");
      image(hold, theplayer.getx() - 10, theplayer.gety() - 25);
    }
  }
  
}
void settingy(){
  //int holdx = theplayer.getx();
  int holdx = projectedx;
  int holdy = theplayer.gety();
  if (terrainint(1) == "terrain"){
    if ((holdx >= 0 && holdx <= 300) || (holdx >= 350 && holdx <= 470) || (holdx >= 510 && holdx <= 800) || (holdx >= 900 && holdx <= 2000)){
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
    if ((holdx > 470 && holdx < 530)){
      theplayer.sety(340);
    }
  }
}


void generateterrain() {//making the terrain
  helpergenterrain(0, width, 400, 400);
  helpergenterrain(300, 350, 300, 300);
  helpergenterrain(500, 500, 350, 400);
  helpergenterrain(900, 2000, 400, 400);
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
      rect(startx.get(a) - shift, starty.get(a), endx.get(a)-startx.get(a), 20);
    }else{
      rect(startx.get(a) - shift, starty.get(a), 20, endy.get(a)-starty.get(a));
    }
  }
  rectMode(CENTER);
  fill(255);
}
String terrainint(int a){
  String trigger = "no terrain";
  //int holdx = theplayer.getx();
  int holdy = theplayer.gety();
  int holdx = projectedx;
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
    if ((holdx >= 0 && holdx <= 300) || (holdx >= 350 && holdx <= 470) || (holdx >= 530 && holdx <= 800) || holdx >= 900 && holdx <= 2000){
      if (holdy - spd >= 390 && holdy - spd <= 410){
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
    if ((holdx > 470 && holdx < 530)){
      if (holdy - spd >= 330 && holdy - spd < 350){
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
    if(holdx == 470 && (holdy >= 340 && holdy <= 390)){
       trigger = "terrain";
    }
  }
  return trigger;
}
