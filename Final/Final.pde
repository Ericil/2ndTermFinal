import java.io.*;
import java.util.*;
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

AudioPlayer bgm, bossbgm, boss2bgm;
Minim minim, minim2, minim3;

boolean keyUp, keyDown, keyLeft, keyRight;//for movement of the player
boolean atking;
boolean canUp, canDown, canLeft, canRight;//if the player can move in that direction
ArrayList<Mob> currentmobs, currentmobs2;//the mobs that will be spawned
Player theplayer;
int onmapx, onmapy;
boolean onfloor;
int spd = 0;
String direction;
int leftnum, rightnum, jumpnum, idlenum, atknum;
boolean idleleft = true;
boolean idleright = true;
int intervalleft, intervalright, intervalidle, intervalatk;
int projectedx, projectedy;
int shift;
BufferedReader test;
String[][] themap, themap2;
int stage = 1;
int movementamountvert, movementamounthorz;
Boss boss;
int bossidleno = 0;
int bosschargeno = 0;
int bosschargedelay = 0;
boolean rewind = false;
int bossidle = 0;
int bossidledelay = 0;
int timer = 0;
int counter = 0;
int counter2 = 0;
int counter3 = 0;
int counter4 = 0;
int timer2 = 0;
int lockon = 0;
int delay = 0;
int atktimer = 0;
int bossprojimg = 0;
int bossdiveimg = 0;
int bossairimg = 0;
int bossjumpimg = 0;
boolean bossjump = false;
boolean bossair = false;
boolean bossprojectile = false;
boolean bossdive = false;
boolean enddive = false;
int countdown = 3;
Random chance = new Random();
boolean changeprojectile = false;
ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
boolean lock = false;
boolean lockmore = false;
boolean finishedloading = false;
int loadingbosscount = 0;
int makingcell = 375;
boolean hit = false;
int invuln = 0;
PImage holding;
PImage background;
boolean killed = false;
int autoplayer;
int removeblocks;
int bulletamount;
void setup() {
  holding = loadImage("terrain.png");
  background = loadImage("backgroundtest.jpg");
  frameRate(60);
  currentmobs = new ArrayList<Mob>();
  onmapx = 0;
  onmapy = 0;
  theplayer = new Player();
  starting();
  size(800, 500);
  minim = new Minim(this);
  minim2 = new Minim(this);
  minim3 = new Minim(this);
  bgm = minim.loadFile("bgm.mp3");
  bossbgm = minim2.loadFile("bossbgm1.mp3");
  boss2bgm = minim3.loadFile("bossbgm2.mp3");
  bgm.play();
  bossbgm = minim.loadFile("bossbgm"+stage+".mp3");
}

void starting() {
  loadingbosscount = 0;
  makingcell = 375;
  killed = false;
  currentmobs = new ArrayList<Mob>();
  if (killed == false) {
    test = createReader("map.txt");
  } else {
    test = createReader("map2.txt");
  }
  String ugh = null;
  String[] hold = new String[20];
  try {
    for (int a = 0; (ugh = test.readLine ()) != null; a++) {
      hold[a] = ugh;
    }
  }
  catch(IOException e) {
  }
  themap = new String[20][320];
  for (int a = 0; a < hold.length; a++) {
    for (int b = 0; b < 320; b++) {
      themap[a][b] = hold[a].substring(b, b+1);
      if (themap[a][b].equals("p")) {
        theplayer.setx(b * 25);
        theplayer.sety(a * 25);
        onmapx = b;
        onmapy = a;
      }
      if (themap[a][b].equals("m")) {
        currentmobs.add(new Mob(b * 25, a * 25));
      }
    }
  }
  killed = false;
  theplayer.setx(100);
  theplayer.sety(375);
  theplayer.setHP(5);
  themap[onmapy][onmapx] = "a";
  onmapx = 4;
  onmapy = 15;
  themap[onmapy][onmapx] = "p";
  movementamountvert = 25;
  movementamounthorz = 0;
  spd = 0;
  leftnum = 0;
  rightnum = 0;
  jumpnum = 0;
  idlenum = 0;
  intervalleft = 0;
  intervalright = 0;
  intervalidle = 0;
  intervalatk = 0;
  atking = false;
  projectedx = theplayer.getx();
  projectedy = theplayer.gety();
  shift = 0;
  direction = "right";
  onfloor = true;
  lock = false;
  lockmore = false;
  finishedloading = false;
  boss = new Boss();
  autoplayer = 0;
  removeblocks = 375;
  bulletamount = 5;
}

void draw() {
  /*
  for(int a = 0; a < themap.length; a++){
   for(int b = 0; b < themap[a].length; b++){
   print(themap[a][b] + " ");
   }
   }
   */
  image(background, 0, -400);
  int a = 1;
  //enemymovements();//movement of the enemies
  if (a == 0) {
    displayBoss();
  } else {
    fill(0);
    if (theplayer.gety() - spd > 450 || theplayer.getHP() == 0) {
      starting();
    }
    if (lockmore == true) {
      loadfinal();
    }
    displayterrain();
    playermovements();//movement of the player
    combat();
    monstermovements();
    if (finishedloading == true && boss != null) {
      displayBoss();
      bgm.pause();
      if (!bossbgm.isPlaying()) {
        bossbgm.rewind();
        bossbgm.play();
      }
    } else if (boss != null) {
      timer = millis();
    } else {
      killedfirstboss();
      if (theplayer.getx() == width - 25) {
        starting();
      }
    }
    loadmonsters();
    loadplayer();
    if (!bgm.isPlaying()) {
      bgm.rewind();
      bgm.play();
    }
  }
}

void combat() {
  //println("playery: " + theplayer.gety());
  //println("invuln: " + invuln);
  //println("HP :" + theplayer.getHP());
  if (atking == true) {
    if (direction == "right") {
      //println("atking right");
      for (int a = 0; a < currentmobs.size (); a++) {
        if (projectedx < currentmobs.get(a).getx() && projectedx + 50 > currentmobs.get(a).getx() && theplayer.gety() == currentmobs.get(a).gety() && hit == false) {
          //println("HP: " + currentmobs.get(a).getHP());
          if (currentmobs.get(a).getHP() == 1) {
            currentmobs.remove(a);
          } else {
            currentmobs.get(a).setHP(currentmobs.get(a).getHP() - 1);
          }
          hit = true;
        }
      }
      if (boss != null) {
        if ((theplayer.getx() < boss.getx() && theplayer.getx() + 60 > boss.getx() && theplayer.gety() == boss.gety() + 25) && hit == false) {
          if (boss.getHP() == 1) {
            boss = null;
            killed = true;
          } else {
            boss.setHP(boss.getHP() - 1);
          }
          hit = true;
        }
      }
    } else {
      for (int a = 0; a < currentmobs.size (); a++) {
        if (projectedx > currentmobs.get(a).getx() && projectedx - 50 < currentmobs.get(a).getx() && theplayer.gety() == currentmobs.get(a).gety() && hit == false) {
          //println("HP : " + currentmobs.get(a).getHP());
          if (currentmobs.get(a).getHP() == 1) {
            currentmobs.remove(a);
          } else {
            currentmobs.get(a).setHP(currentmobs.get(a).getHP() - 1);
          }
          hit = true;
        }
      }
      if (boss != null) {
        if ((theplayer.getx() > boss.getx() && theplayer.getx() - 60 < boss.getx() && theplayer.gety() == boss.gety() + 25) && hit == false) {
          if (boss.getHP() == 1) {
            boss = null;
            killed = true;
          } else {
            boss.setHP(boss.getHP() - 1);
          }
          hit = true;
        }
      }
    }
  }
  for (int i = 0; i < projectiles.size (); i++) {
    for (int a = 0; a < currentmobs.size () && projectiles.size() != 0; a++) {
      //println("mobsy: " + currentmobs.get(a).gety());
      //println("projectiley: " + projectiles.get(i).gety());
      if (projectiles.get(i).getside() == false) {
        if (projectiles.get(i).getx() + shift + 5 >= currentmobs.get(a).getx() && projectiles.get(i).getx()+ shift - 5 <= currentmobs.get(a).getx()
          && projectiles.get(i).gety() == currentmobs.get(a).gety()) {
          currentmobs.remove(a);
          projectiles.remove(i);
        } else {
          PImage fire = loadImage("firel.png");
          image(fire, projectiles.get(i).getx(), projectiles.get(i).gety());
          projectiles.get(i).setx(projectiles.get(i).getx()+1);
          if (projectiles.get(i).getx() > 700 || projectiles.get(i).getx() < 100) {
            projectiles.remove(i);
          }
        }
      } else {
        if (projectiles.get(i).getx() + shift - 5 <= currentmobs.get(a).getx() && projectiles.get(i).getx() + shift + 5 > currentmobs.get(a).getx()
          && projectiles.get(i).gety() == currentmobs.get(a).gety()) {
          currentmobs.remove(a);
          projectiles.remove(i);
        } else {
          PImage fire = loadImage("firer.png");
          image(fire, projectiles.get(i).getx(), projectiles.get(i).gety());
          projectiles.get(i).setx(projectiles.get(i).getx()-1);
          if (projectiles.get(i).getx() > 700 || projectiles.get(i).getx() < 100) {
            projectiles.remove(i);
          }
        }
      }
    }
  }
  if (invuln == 0) {
    for (int a = 0; a < currentmobs.size (); a++) {
      if (currentmobs.get(a).getmovement() == false) {
        if (projectedx > currentmobs.get(a).getx() && projectedx - 40 < currentmobs.get(a).getx() && theplayer.gety() == currentmobs.get(a).gety()) {
          theplayer.setHP(theplayer.getHP() - 1);
          invuln = 99;
        }
      } else {
        if (projectedx < currentmobs.get(a).getx() && projectedx + 40 > currentmobs.get(a).getx() && theplayer.gety() == currentmobs.get(a).gety()) {
          theplayer.setHP(theplayer.getHP() - 1);
          invuln = 99;
        }
      }
    }
    if (finishedloading && boss != null) {
      if ((theplayer.getx() > boss.getx() && theplayer.getx() - 40 < boss.getx() && theplayer.gety() == boss.gety() + 25) ||
        (theplayer.getx() < boss.getx() && theplayer.getx() + 40 > boss.getx() && theplayer.gety() == boss.gety() + 25)) {
        theplayer.setHP(theplayer.getHP() - 1);
        invuln = 99;
        println("hit");
      }
      for (int a = 0; a < projectiles.size (); a++) {
        if (projectiles.get(a).getx() + 10 >=theplayer.getx() && projectiles.get(a).getx() - 10 <= theplayer.getx()) {
          println("projectilexy: " + projectiles.get(a).getx(), projectiles.get(a).gety());
          theplayer.setHP(theplayer.getHP() - 1);
          invuln = 99;
        }
      }
    }
  } else {
    invuln--;
  }
}
void playermovements() {//movement of players

    if (atking == true && onfloor) {
    if (intervalatk == 3) {
      if (atknum == 5) {
        atking = false;
        atknum = 0;
        hit = false;
      } else {
        atknum++;
      }
      intervalatk = 0;
    } else {
      intervalatk++;
    }
  } else if (lockmore == false) {
    if (playerinteractions(1) == "no terrain") {
      onfloor = false;
    }
    if (spd > 0 && playerinteractions(0) == "no terrain") {//jumping, going up
      theplayer.sety(theplayer.gety() - spd);
      if (movementamountvert - spd <= 0) {
        movementamountvert = movementamountvert - spd + 25;
        //themap[onmapy][onmapx] = "a";
        onmapy = onmapy - 1;
        //themap[onmapy][onmapx] = "p";
      } else {
        movementamountvert = movementamountvert - spd;
      }
      if (spd - 2 == 0) {
        spd = -2;
      } else {
        spd--;
      }
    } else if (spd < 0 && playerinteractions(1) == "no terrain" && onfloor == false) {//jumping, going down
      //println("down");
      theplayer.sety(theplayer.gety() - spd);
      if (movementamountvert - spd >= 25) {
        movementamountvert = movementamountvert - spd - 25;
        //themap[onmapy][onmapx] = "a";
        onmapy = onmapy + 1;
        //themap[onmapy][onmapx] = "p";
      } else {
        movementamountvert = movementamountvert - spd;
      }
      spd--;
    } else if (playerinteractions(0) == "terrain" && onfloor == false) {//jumping, interactions with entities above
      spd = 0;
      movementamountvert = movementamountvert - spd;
      theplayer.sety(theplayer.gety() - spd);
      spd --;
    } else if (playerinteractions(1) == "terrain" && onfloor == false) {
      onfloor = true;
      theplayer.sety(theplayer.gety()/25 * 25 + 25);
      spd = 0;
    } else if (spd == 0 && onfloor == false && playerinteractions(1) == "no terrain") {
      spd = -1;
      theplayer.sety(theplayer.gety() - spd);
      if (movementamountvert - spd >= 25) {
        movementamountvert = movementamountvert - spd - 25;
        //themap[onmapy][onmapx] = "a";
        onmapy = onmapy + 1;
        //themap[onmapy][onmapx] = "p";
      } else {
        movementamountvert = movementamountvert - spd;
      }
      spd--;
    }
    if (onfloor == false) {
      if (spd == 0) {
        jumpnum = 5;
      }
      if (spd == 15) {
        jumpnum = 0;
      }
      if (spd < 15 && spd >= 11) {
        jumpnum = 1;
      }
      if (spd < 11 && spd >= 7) {
        jumpnum = 2;
      }
      if (spd < 7 && spd >= 4) {
        jumpnum = 3;
      }
      if (spd < 4 && spd >= 1) {
        jumpnum = 4;
      }
      if (spd < 0 && spd >= -4) {
        jumpnum = 6;
      }
      if (spd < -4 && spd >= -8) {
        jumpnum = 7;
      }
      if (spd < -8 && spd >= -12) {
        jumpnum = 8;
      }
      if (spd < -12 && spd >= -16) {
        jumpnum = 9;
      }
      if (spd < -16) {
        jumpnum = 10;
      }
    }
    if (keyLeft && playerinteractions(2) == "no terrain") {//left
      if (projectedx < 400 || projectedx > 7225) {
        //println("trigger");
        theplayer.setx(theplayer.getx() - 5);
      } else {
        if (lock == false) {
          //println("trigger2");
          shift = shift - 5;
        }
      }
      if (lock == false || projectedx >= 7225) {

        projectedx = projectedx - 5;
        movementamounthorz = movementamounthorz - 5;
      }
    }
    if (keyRight && playerinteractions(3) == "no terrain") {//right
      if (projectedx < 400 || projectedx >= 7225) {

        if (projectedx >= 7325 && lock == false && onfloor == true) {
          lockmore = true;
          lock = true;
        }
        theplayer.setx(theplayer.getx() + 5);
      } else {
        shift = shift + 5;
      }

      projectedx = projectedx + 5;
      movementamounthorz = movementamounthorz + 5;
    }
    if (keyRight && onfloor == false) {
      if (direction != "right") {
        direction = "right";
      }
    }
    if (keyLeft && onfloor == false) {
      if (direction != "left") {
        direction = "left";
      }
    }
    if (keyRight && onfloor == true) {
      if (intervalright == 3) {
        if (direction != "right") {
          direction = "right";
          rightnum = 0;
        } else if (rightnum == 10) {
          rightnum = 0;
        } else {
          rightnum++;
        }
        intervalright = 0;
      } else {
        intervalright++;
      }
    }
    if (keyLeft && onfloor == true) {
      if (intervalleft == 3) {
        if (direction != "left") {
          direction = "left";
          leftnum = 0;
        } else if (leftnum == 10) {
          leftnum = 0;
        } else {
          leftnum++;
        }
        intervalleft = 0;
      } else {
        intervalleft++;
      }
    }
    if (keyUp == false && keyDown == false && keyRight == false && keyLeft == false && onfloor == true) {
      if (intervalidle == 2) {
        if (idlenum == 7) {
          idlenum = 0;
        } else {
          idlenum++;
        }
        intervalidle = 0;
      } else {
        intervalidle++;
      }
    }
  }
  //rect(theplayer.getx(), theplayer.gety(), 20, 20);//drawing the player
}

void monstermovements() {// this is for one mob right now, later on,
  for (int a = 0; a < currentmobs.size (); a++) {
    if (currentmobs.get(a).getx() % 25 == 0 && currentmobs.get(a).getmovement() == true) {
      if (themap[currentmobs.get(a).gety() / 25][currentmobs.get(a).getx() / 25 - 1].equals("x")) {
        currentmobs.get(a).setmovement(false);
      }
    } else if (currentmobs.get(a).getx() % 25 == 0 && currentmobs.get(a).getmovement() == false) {
      if (themap[currentmobs.get(a).gety() / 25][currentmobs.get(a).getx() / 25 + 1].equals("x")) {
        currentmobs.get(a).setmovement(true);
      }
    }
    if (currentmobs.get(a).getmovement() == false) {//right
      currentmobs.get(a).setx(currentmobs.get(a).getx() + 1);
    } else {
      currentmobs.get(a).setx(currentmobs.get(a).getx() - 1);
    }
  }
}
void loadmonsters() {
  for (int a = 0; a < currentmobs.size (); a++) {
    if (currentmobs.get(a).getx() - shift < 900 && currentmobs.get(a).getx() >= 0) {
      fill(255, 0, 0);
      //println("mobs: " + currentmobs.get(a).getx(), currentmobs.get(a).gety());
      rect(currentmobs.get(a).getx() - shift, currentmobs.get(a).gety(), 25, 25);
    }
  }
}
/*
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
 */
String playerinteractions(int a) {
  String trigger = "no terrain";
  if (a == 0) {//up
    for (int b = 0; b < currentmobs.size (); b++) {//mobs above
      if (dist(theplayer.getx(), theplayer.gety(), currentmobs.get(b).getx(), currentmobs.get(b).gety()) <= 25 && currentmobs.get(b).gety() < theplayer.gety()) {
        trigger = "terrain";
      }
    }
    if (terrainint(0) == "terrain") {
      trigger = "terrain";
    }
  }
  if (a == 1) {//down
    for (int b = 0; b < currentmobs.size (); b++) {//mobs below
      if (dist(theplayer.getx(), theplayer.gety(), currentmobs.get(b).getx(), currentmobs.get(b).gety()) <= 25 && currentmobs.get(b).gety() > theplayer.gety()) {
        trigger = "terrain";
      }
    }
    if (terrainint(1) == "terrain") {
      trigger = "terrain";
    }
  }
  if (a == 2) {//left
    for (int b = 0; b < currentmobs.size (); b++) {//mobs to the left
      if (dist(theplayer.getx(), theplayer.gety(), currentmobs.get(b).getx(), currentmobs.get(b).gety()) <= 25 && currentmobs.get(b).getx() < theplayer.getx()) {
        trigger = "terrain";
      }
    }
    if (terrainint(2) == "terrain") {
      trigger = "terrain";
    }
  }
  if (a == 3) {//right
    for (int b = 0; b < currentmobs.size (); b++) {//mobs to the right
      if (dist(theplayer.getx(), theplayer.gety(), currentmobs.get(b).getx(), currentmobs.get(b).gety()) <= 25 && currentmobs.get(b).getx() > theplayer.getx()) {
        trigger = "terrain";
      }
    }
    if (terrainint(3) == "terrain") {
      trigger = "terrain";
    }
  }
  return trigger;
}

void keyPressed() {
  if (keyCode == 83 && onfloor && bulletamount != 0) {
    if (direction == "right") {
      projectiles.add(new Projectile(theplayer.getx(), theplayer.gety(), false));
    } else {
      projectiles.add(new Projectile(theplayer.getx(), theplayer.gety(), true));
    }
    bulletamount--;
  }
  if (keyCode == 65 && onfloor) {
    atking = true;
  }
  if (keyCode == 38 && onfloor) {
    keyUp = true;
    spd = 16;
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

void loadplayer() {
  fill(0);
  rect(10, 10, 35, theplayer.getHP() * 15 + 10);
  fill(#00ccff);
  for (int a = 1; a <= theplayer.getHP (); a++) {
    stroke(0);
    rect(15, a * 15, 25, 15);
  }
  for (int a = 0; a < bulletamount; a++) {
    fill(#ffff00);
    rect(45 + a * 20, 15, 20, 20);
  } 
  imageMode(CORNER);
  if (invuln % 3 == 0) {
    if (onfloor == true) {
      if (direction == "left") {
        if (atking == true) {
          PImage hold = loadImage("swordleft" + atknum + ".png");
          image(hold, theplayer.getx() - 26, theplayer.gety() - 10);
        } else if (idleleft == false) {
          PImage hold = loadImage("left" + leftnum + ".png");
          image(hold, theplayer.getx(), theplayer.gety() - 10);
        } else if (idleleft == true) {
          PImage hold = loadImage("idleleft" + idlenum + ".png");
          image(hold, theplayer.getx(), theplayer.gety() - 10);
        }
      }
      if (direction == "right") {
        if (atking == true) {
          PImage hold = loadImage("swordright" + atknum + ".png");
          image(hold, theplayer.getx(), theplayer.gety() - 10);
        } else {
          if (idleright == false) {
            PImage hold = loadImage("right" + rightnum + ".png");
            image(hold, theplayer.getx(), theplayer.gety()  - 10);
          }
          if (idleright == true) {
            PImage hold = loadImage("idleright" + idlenum + ".png");
            image(hold, theplayer.getx(), theplayer.gety() - 10);
          }
        }
      }
    } else {
      if (direction == "right") {
        PImage hold = loadImage("jumpright" + jumpnum + ".png");
        image(hold, theplayer.getx(), theplayer.gety() - 10);
      }
      if (direction == "left") {
        PImage hold = loadImage("jumpleft" + jumpnum + ".png");
        image(hold, theplayer.getx(), theplayer.gety() - 10);
      }
    }
  }
  //fill(0);
  //rect(theplayer.getx(), theplayer.gety(), 25, 25);
}


void displayterrain() {
  //drawing the terrain

  /*
  fill(0);
   for (int a = 0; a < startx.size(); a++) {
   rectMode(CORNER);
   if(endy.get(a).equals(starty.get(a))){
   rect(startx.get(a) - shift, starty.get(a), endx.get(a)-startx.get(a), 20);
   }else{
   rect(startx.get(a) - shift, starty.get(a), 20, endy.get(a)-starty.get(a));
   }
   }
   */
  fill(0);
  rectMode(CORNER);
  for (int a = 0; a < themap.length; a++) {
    for (int b = 0; b < themap[a].length; b++) {
      if (themap[a][b].equals("x")) {
        //rect(b * 25 - shift, a * 25, 25, 25);
        if (b * 25 - shift < 850 && b * 25 - shift >= -50) {

          image(holding, b * 25 - shift, a * 25);
        }
      }
    }
  }
  fill(255);
}
String terrainint(int a) {
  String trigger = "no terrain";
  //int holdx = theplayer.getx();
  int holdy = theplayer.gety();
  int holdx = projectedx;
  if (a == 0) {
    if (movementamountvert - spd <= 0) {

      if (themap[onmapy - 1][onmapx].equals("x") || (projectedx % 25 != 0 && themap[onmapy -1][onmapx + 1].equals("x"))) {
        trigger = "terrain";
      }
    }
  }
  if (a == 1) {
    boolean plustime = false;
    if (movementamountvert - spd >= 25) {
      if (themap[onmapy + 1][projectedx /25].equals("x") || (projectedx % 25 != 0 && (themap[onmapy + 1][onmapx + 1].equals("x")))) {
        trigger = "terrain";
        movementamountvert = 25;
      }
    }
  }
  if (a == 2) {//terrain on left
    if (movementamounthorz == 0) {
      if (themap[onmapy][onmapx - 1].equals("x")) {
        trigger = "terrain";
        //println("collisonleft");
        movementamounthorz = 0;
      } else {
        movementamounthorz = 25;
        //themap[onmapy][onmapx] = "a";
        onmapx = onmapx - 1;
        //themap[onmapy][onmapx] = "p";
      }
    }
  }
  if (a == 3) {//terrain on right
    if (movementamounthorz == 25) {
      if (themap[onmapy][onmapx + 2].equals("x")) {
        trigger = "terrain";
        //println("collisonright");
        movementamounthorz = 25;
      } else {
        movementamounthorz = 0;
        //themap[onmapy][onmapx] = "a";
        onmapx = onmapx + 1;
        //themap[onmapy][onmapx] = "p";
      }
    }
  }
  return trigger;
}

void loadfinal() {
  if (loadingbosscount == 0) {
    lockmore = true;
    theplayer.setx(theplayer.getx() - 5);
    shift = shift + 5;
    loadingbosscount = loadingbosscount + 5;
  } else if (loadingbosscount != 375) {
    theplayer.setx(theplayer.getx() - 5);
    shift = shift + 5;
    loadingbosscount = loadingbosscount + 5;
  } else if (loadingbosscount == 375) {
    lockmore = false;
    finishedloading = true;
  }
  if (makingcell >= 25) {
    themap[makingcell / 25][7200 / 25] = "x";
    makingcell = makingcell - 25;
  }
}

void killedfirstboss() {
  if (removeblocks >= 300) {
    themap[removeblocks / 25][319] = "a";
    removeblocks = removeblocks - 25;
  }
}
void displayBoss() {
  fill(0);
  rect(750, 10, 35, boss.getHP() * 15 + 10);
  fill(#ff0000);
  for (int a = 1; a <= boss.getHP (); a++) {
    stroke(0);
    rect(755, a * 15, 25, 15);
  }
  int start = millis();
  //println(start-timer);
  if (stage == 1) {
    if (start-timer < 2000) {
      if (boss.getside()) {
        PImage bossidle = loadImage("idler"+bossidleno+".png");
        image(bossidle, boss.getx(), boss.gety());
        if (start - bossidledelay > 20) {
          bossidleno++;
          bossidledelay = millis();
        }
        if (bossidleno == 8) {
          bossidleno = 0;
        }
      } else {
        PImage bossidle = loadImage("idlel"+bossidleno+".png");
        image(bossidle, boss.getx(), boss.gety());
        if (start - bossidledelay > 20) {
          bossidleno++;
          bossidledelay = millis();
        }
        if (bossidleno == 8) {
          bossidleno = 0;
        }
      }
    }
    if (start-timer > 2000 && start-timer < 3000) {
      PImage bosscharge = loadImage("charge"+bosschargeno+".png");
      image(bosscharge, boss.getx(), boss.gety());
      if (start - bosschargedelay > 50) {
        if (rewind) {
          if (bosschargeno == 0) {
            rewind = false;
            bosschargeno++;
          }
          bosschargeno--;
        } else {
          if (bosschargeno == 3) {
            rewind = true;
            bosschargeno--;
          }
          bosschargeno++;
        }
        bosschargedelay = millis();
      }
    }
    if ((start-timer) > 3000) {
      if (bossprojectile || projectiles.size() > 0) {
        PImage bossproj;
        if (boss.getside()) {
          if (countdown > 1) {
            bossproj = loadImage("projectiler2.png");
          } else if (countdown > 0) {
            bossproj = loadImage("projectiler8.png");
          } else {
            bossproj = loadImage("projectiler14.png");
          }
        } else {
          if (countdown > 1) {
            bossproj = loadImage("projectilel2.png");
          } else if (countdown > 0) {
            bossproj = loadImage("projectilel8.png");
          } else {
            bossproj = loadImage("projectilel14.png");
          }
        }
        image(bossproj, boss.getx(), boss.gety());
        if (countdown == 3) {
          projectiles.add(new Projectile(boss.getx(), boss.gety()+20, boss.getside()));
          timer2 = millis();
          countdown--;
        } else if (countdown > 0 && start-timer2 > 1000) {
          projectiles.add(new Projectile(boss.getx(), boss.gety()+20, boss.getside()));
          timer2 = millis();
          countdown--;
        } else if (countdown == 0 && projectiles.size() == 0) {
          bossprojectile = false;
          countdown = 3;
          changeprojectile = false;
          timer = millis();
        }
        if (projectiles.size() > 0) {
          for (int i = 0; i<projectiles.size (); i++) {
            //ellipse(projectiles.get(i).getx(), projectiles.get(i).gety(), 30, 15);
            if (!projectiles.get(i).getside()) {
              PImage fire = loadImage("firel.png");
              image(fire, projectiles.get(i).getx(), projectiles.get(i).gety());
              projectiles.get(i).setx(projectiles.get(i).getx()+10);
            } else {
              PImage fire = loadImage("firer.png");
              image(fire, projectiles.get(i).getx(), projectiles.get(i).gety());
              projectiles.get(i).setx(projectiles.get(i).getx()-10);
            }
            if (projectiles.get(i).getx() > 700 || projectiles.get(i).getx() < 100) {
              projectiles.remove(i);
            }
          }
        }
      } else if (boss.getx() == 700 || boss.getx() == 100) {
        int action, action2, action3;
        if (counter < 5 && counter2 < 7) {
          action = chance.nextInt(5-counter);
          action2 = chance.nextInt(7-counter2);
          action3 = chance.nextInt(9-counter3);
        } else if (counter < 9) {
          action = 0;
          action2 = 0;
          action3 = chance.nextInt(9-counter3);
        } else {
          action3 = 0;
          action = 4;
          action2 = 6;
        }
        if (action3 == 0) {
          bossprojectile = true;
          counter3 = 0;
        } else if (action2 == 0) {
          bossair = true;
          counter2 = 0;
        } else if (action == 0) {
          bossjump = true;
          counter = 0;
        }
      }
      if (!bossprojectile) {
        if (boss.getside()) {
          boss.setx(boss.getx()-10);
        } else {
          boss.setx(boss.getx()+10);
        }
      }
      if (bossair) {
        boss.sety(300);
      }
      if (bossjump) {
        if (boss.gety() == 350) {
          boss.setspd(40);
        } else {
          boss.setspd(boss.getspd() - 4);
        }

        PImage jumping;
        if (boss.getside()) {
          if (boss.getspd() == 40) {
            jumping = loadImage("jumpr.png");
          } else if (boss.getspd() < 40 && boss.getspd() >= 32) {
            jumping = loadImage("jumpr0.png");
          } else if (boss.getspd() < 32 && boss.getspd() >= 24) {
            jumping = loadImage("jumpr1.png");
          } else if (boss.getspd() < 24 && boss.getspd() >= 16) {
            jumping = loadImage("jumpr2.png");
          } else if (boss.getspd() < 16 && boss.getspd() >= 8) {
            jumping = loadImage("jumpr3.png");
          } else if (boss.getspd() < 8 && boss.getspd() >= 0) {
            jumping = loadImage("jumpr4.png");
          } else if (boss.getspd() < 0 && boss.getspd() >= -8) {
            jumping = loadImage("jumpr5.png");
          } else if (boss.getspd() < -8 && boss.getspd() >= -16) {
            jumping = loadImage("jumpr6.png");
          } else if (boss.getspd() < -16 && boss.getspd() >= -24) {
            jumping = loadImage("jumpr7.png");
          } else if (boss.getspd() < -24 && boss.getspd() >= -32) {
            jumping = loadImage("jumpr8.png");
          } else if (boss.getspd() < -32 && boss.getspd() > -40) {
            jumping = loadImage("jumpr9.png");
          } else {
            jumping = loadImage("jumpr10.png");
          }
        } else {
          if (boss.getspd() == 40) {
            jumping = loadImage("jumpl.png");
          } else if (boss.getspd() < 40 && boss.getspd() >= 32) {
            jumping = loadImage("jumpl0.png");
          } else if (boss.getspd() < 32 && boss.getspd() >= 24) {
            jumping = loadImage("jumpl1.png");
          } else if (boss.getspd() < 24 && boss.getspd() >= 16) {
            jumping = loadImage("jumpl2.png");
          } else if (boss.getspd() < 16 && boss.getspd() >= 8) {
            jumping = loadImage("jumpl3.png");
          } else if (boss.getspd() < 8 && boss.getspd() >= 0) {
            jumping = loadImage("jumpl4.png");
          } else if (boss.getspd() < 0 && boss.getspd() >= -8) {
            jumping = loadImage("jumpl5.png");
          } else if (boss.getspd() < -8 && boss.getspd() >= -16) {
            jumping = loadImage("jumpl6.png");
          } else if (boss.getspd() < -16 && boss.getspd() >= -24) {
            jumping = loadImage("jumpl7.png");
          } else if (boss.getspd() < -24 && boss.getspd() >= -32) {
            jumping = loadImage("jumpl8.png");
          } else if (boss.getspd() < -32 && boss.getspd() > -40) {
            jumping = loadImage("jumpl9.png");
          } else {
            jumping = loadImage("jumpl10.png");
          }
        }
        image(jumping, boss.getx(), boss.gety());

        boss.sety(boss.gety()-boss.getspd());
      } else if (!bossprojectile) {
        PImage dash;
        if (boss.getside()) {
          dash = loadImage("dashright.png");
        } else {
          dash = loadImage("dashleft.png");
        }
        image(dash, boss.getx(), boss.gety());
      }
      if (boss.getx() == 100 && boss.getside()) {
        boss.sety(350);
        boss.switchside();
        timer = millis();
        counter++;
        counter2++;
        counter3++;
        bossair = false;
        bossjump = false;
        bossprojectile = false;
        boss.setspd(0);
        bossidleno = 0;
        bosschargeno = 0;
      } else if (boss.getx() == 700 && !boss.getside()) {
        boss.sety(350);
        boss.switchside();
        timer = millis();
        counter++;
        counter2++;
        counter3++;
        bossair = false;
        bossjump = false;
        bossprojectile = false;
        boss.setspd(0);
        bossidleno = 0;
        bosschargeno = 0;
      }
    }
  } else if (stage == 2) {
    if (start - timer < 2000) {
      PImage bossidle = loadImage("b2idle.png");
      image(bossidle, boss.getx(), boss.gety());
    }
    if (start - timer > 2000 && start - timer < 3000) {
      PImage bosscharge = loadImage("charge"+bosschargeno+".png");
      image(bosscharge, boss.getx(), boss.gety());
      if (start - bosschargedelay > 50) {
        bosschargeno++;
        bosschargedelay = millis();
      }
    }
    if (bossprojectile) {
      boss.setx(400);
      PImage bossproj = loadImage("b2proj"+bossprojimg+".png");
      if (bossprojimg < 2) {
        bossprojimg++;
      }
      if (lockon == 0) {
        lockon = theplayer.getx();
        delay = millis();
      }
      if (countdown >= 1 && start-delay > 700) {
        projectiles.add(new Projectile(lockon, 320));
        countdown--;
        lockon = 0;
      }
      for (int i = 0; i<projectiles.size (); i++) {
        PImage bossprome = loadImage("b2proj.png");
        image(bossprome, projectiles.get(i).getx(), projectiles.get(i).gety());
        projectiles.get(i).sety(projectiles.get(i).gety() - 3);
        if (projectiles.get(i).gety() < 150) {
          projectiles.remove(i);
        }
      }
      if (countdown == 0 && (projectiles.size() == 0)) {
        lockon = 0;
        timer = millis();
        countdown = 3;
        boss.setx(700);
        bossprojimg = 0;
      }
      counter++;
      counter2++;
      counter4++;
    } else if (bossair) {
      if (lockon == 0) {
        lockon = theplayer.getx() + 100;
      } else {
        if (boss.getx() > lockon) {
          boss.setx(boss.getx()-10);
          PImage bosschar = loadImage("b2charge13.png");
          image(bosschar, boss.getx(), boss.gety());
        } else if (boss.gety() > 150) {
          PImage bossup = loadImage("b2air"+bossairimg+".png");
          image(bossup, boss.getx(), boss.gety());
          if (bossairimg < 5) {
            bossairimg++;
          }
          boss.setx(boss.getx()-10);
          boss.sety(boss.gety()-15);
        } else {
          lockon = 0;
          bossairimg = 0;
          boss.setx(700);
          boss.sety(350);
          timer = millis();
        }
      }
      counter++;
      counter3++;
      counter4++;
    } else if (bossdive) {
      if (lockon == 0) {
        lockon = theplayer.getx();
        boss.setx(lockon);
        boss.sety(150);
      }
      if (boss.gety() < 350 && !enddive) {
        boss.sety(boss.gety()+10);
        PImage bossdive1 = loadImage("b2dive"+(0+bossdiveimg)+".png");
        image(bossdive1, boss.getx(), boss.gety());
        if (bossdiveimg < 3) {
          bossdiveimg++;
        }
      } else if (boss.gety() == 350) {
        PImage divemid = loadImage("b2dive4.png");
        image(divemid, boss.getx(), boss.gety());
        bossdiveimg = 0;
        enddive = true;
        boss.sety(340);
      } else if (enddive && boss.gety() > 150) {
        boss.sety(boss.gety()-10);
        PImage bossdive2 = loadImage("b2dive"+(5+bossdiveimg)+".png");
        image(bossdive2, boss.getx, boss.gety());
        if (bossdiveimg < 3) {
          bossdiveimg++;
        }
      } else if (boss.gety() == 150 && enddive) {
        lockon = 0;
        timer = millis();
        boss.setx(700);
        boss.sety(350);
        enddive = false;
        bossdiveimg = 0;
      }
      counter++;
      counter2++;
      counter3++;
    } else if (bossjump) { //not actually a jumping attack
      if (lockon == 0) {
        lockon = theplayer.getx();
      } else {
        if (boss.getx() > lockon) {
          boss.setx(boss.getx()-10);
          atktimer = millis();
          PImage bossjump1 = loadImage("b2jump"+bossjumpimg+".png");
          image(bossjump1, boss.getx(), boss.gety());
          if (bossjumpimg < 2) {
            bossjumpimg++;
          }
        } else {
          PImage bossjump2 = loadImage("b2jump"+bossjumpimg+".png");
          image(bossjump2, boss.getx(), boss.gety());
          if (bossjumpimg < 9) {
            bossjumpimg++;
          }
          if (start - atktimer > 1000) {
            lockon = 0;
            boss.setx(700);
            boss.sety(350);
            timer = millis();
          }
        }
      }
      counter2++;
      counter3++;
      counter4++;
    }

    int action, action2, action3, action4;
    if (counter < 5 && counter2 < 7 && counter3 < 9) {
      action = chance.nextInt(5-counter);
      action2 = chance.nextInt(7-counter2);
      action3 = chance.nextInt(9-counter3);
      action4 = chance.nextInt(11-counter4);
    } else if (counter4 > 11) {
      action = 0;
      action2 = 0;
      action3 = 0;
      action4 = 0;
    } else if (counter3 > 9) {
      action3 = 0;
      action = 4;
      action2 = 6;
      action4 = 3;
    } else if (counter2 > 7) {
      action2 = 0;
      action4 = 4;
      action = 6;
      action3 = 3;
    } else {
      action = 0;
      action2 = 4;
      action3 = 5;
      action4 = 6;
    }
    if (action4 == 0) {
      bossdive = true;
      counter4 = 0;
    } else if (action3 == 0) {
      bossprojectile = true;
      counter3 = 0;
    } else if (action2 == 0) {
      bossair = true;
      counter2 = 0;
    } else if (action == 0) {
      bossjump = true;
      counter = 0;
    }
  }
}

