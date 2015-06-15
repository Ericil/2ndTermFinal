2nd Term Final Project    
Group Name: Megaman CS    

6/15/15    
Updates:    
- Done!    

To Play: Open the Final folder, then open Final.pde    



6/14/15    
Updates:    
- added animations for mob    
- added terrain to map2    
- lowered mob HP to 1    
- added music    
- added animation for 2nd boss    
- added start, victory, and game over screen    

Bugfixes:    
- fixed bullets so that their movement is not relying on the number of mobs(don’t as why it was like that)    
- fixed music bugging out and switching for one to the other non-stop(causing a lot of lag)    
- fixed terrain so they were actually able to be jumped onto    
- fixed boss bullets so that they would to into account ycor(didn’t do this before cause the bullets were all on 1 ycor)    
- fixed player glitching through maps diagonally    
-  fixed sound not switching and changing correctly when player dies, spawns boss, kills boss, changes level or wins    

Need to do(but can’t):    
- parallax background    

Rare bugs:    
- random glitching of player through a block setting player 2 block lower than player should be, cannot reproduce consistently and cannot figure out why    
- bosses(and very occasionally mobs) running through bullets and not getting hit    
- hitboxes of player, mob, boss not interacting correctly (not damaging the player) cannot replicate    

6/13/15    
Updates:    
- expanded first map(2x), added 2nd map    
- added mobs, added transition to 2nd map after killing first boss    
- made bullets for the player    
- made bullets damage enemies and bosses    
- added wonky boss jump    

Need to do:    
- parallax background maybe???    
- music    
- polishing    

6/11/15    
Updates:    
- boss has HP    
- boss has HP bar    
- boss is killable    
- when you win, currently sends you back to the start    

Need to do:    
- the jumping animation for the boss    
- maybe a shoot    
- another level    
- extending first level    
- parallax background maybe??    
- music    
- polishing    

6/10/15
Updates:    
- another merge between master and Jason’s branch    
- added HP bar    
- mobs can now damage player    
- added flickering (and invulnerability during this time)    
- added boss images    
- animated boss    
- added background    

Bugfixes:    
- fixed a bug where jumping up into terrain would set the player 1 block lower than the player should be    
- fixed a bug where the boss and boss room would not load if you jumped into the room instead of walked    
- fixed the terrain bugs that have been annoying me since the beginning(created because the hitbox is from the top-left corner)    
- fixed the boss damaging you when the boss room is generating and centering    

Need to do:    
- moar animations (for enemies and player)    
- maybe a shoot, can just use what the boss does    
- combat    
- another level    
- extending this level    
- maybe, hopefully a parallax background?    
- polishing    

6/8/15    
Updates:    
- added boss to the overall level    
- enclosed the room    
- made map shift when encountering boss    


6/7/15    
Updates:    
- added more to map    
- added 2 mobs (are currently red squares for placeholder)    
- tried terrain pngs (was too laggy)    
- added basic combat    

Need to do:   
- animations    
- wall interaction    
- combat    
- music    
- polishing    

6/6/15
Demo is at branch demo    

Updates:    
- merged 2 branches together!    
- currently there is an int that acts as a switch in the draw() that allows either the player to be shown or the boss, have not combined it yet    

Updates from Jasons branch:    
- a boss class    
- algorithm for 1 boss(really amazing)    
- boss moves, attacks, shoots    
- added sprites for the boss    

Updates from Derry’s branch:    
- completely redid how terrain works    
- terrain is now a textfile    
- interactions between player and terrain now relies on textfile for hitbox    

Need to do(for monday demo):    
- fixing interaction with walls on right    
- making the entire map    
- making the boss and player interactable    
- Boss animations(ugh)    
- mobs    
- redoing mob interactions    

Need to do(for final due date):    
- maybe another boss    
- another level or 2    
- more mobs    
- more animations because of more bosses and mobs    
- music    
- polishing    

6/5/15    
Updates:
- fixed attack sprites    

Need to do:    
- terrain interaction    
- levels    
- more animations    
- mob and boss stuff    
- music    
- polishing    

6/4/15    
Updates:    
- added attack animation    

Need to do:    
- levels    
- more animations for bosses, mobs, and player    
- mob and boss attacks    
- mob and boss paths    
- music    
- polishing    

6/1/15    
Stable demo version is with commit by njason7 on May 31, 2015 “Added more idle sprites”    

Updates:    
- added movement of screen instead of player moving after a certain point    
- fixed terrain collision bugs brought on by this new addition    
- branch by Jason to work on boss algorithms    
- idle sprites a lot better    
- jump animation is decent now    
- added jumping and air dashing for one boss (Jason2 branch)    

Need to do:    
- levels    
- mob and boss attacks    
- mob and boss paths    
- music    
- polishing    

5/30/15    
Updates:    
- animation for left and right updated, looks a lot better    
- idle animations done, but the sprites used makes it look wonky    
- fixed whitespace on sprites    

Need to do:    
- fixing idle sprites    
- jump animation    
- level(s)    
- mob and boss attacks    
- mob and boss paths    
- music    
- polishing    

5/29/15    
Updates:    
- animation for left and right done, looks a bit too fast    
- added idle sprites    

Need to do:    
- animation    
- level(s)    
- mob paths    
- mob and player HP    
- music    
- polishing    

5/28/15    
Updates:
- movement works!!    
- jump works too!!    
- added basic sprites    
- basics for terrain interaction have been set up    
- basic sprites added    

Need to do:    
- animation    
- level    
- mob paths    
- mob and player HP    
- music    
- polishing    


5/27/15    
Updates:    
- removed terrain class    
- removed previous way of interaction    
- redid terrain generation (works)    
- redid player-terrain interaction (skeleton there, doesn’t really work)    
- tried to fix jump, getting complicated    

Need to do:    
- sprites    
- level    
- mob paths    
- mob and player HP    
- music    
- polishing    

Notes:    
- might want to fix boolean values in my playerinteraction function or make it return a string to make it easier to understand    

5/26/15    
Updates:    
- continued on player-terrain interaction    
- tried to fix going through the floor, much better than before    

Need to do:    
- sprites    
- level    
- mob paths    
- mob and player HP    
- music    
- polishing    

Notes:    
- want to redo the way terrain works, currently lags because I generate a terrain item every .5 of a coord    

5/25/15    
Updates:    
- Added terrain class    
- Removed movement in up and down    
- Implemented jump    
- Added mod detection of a player    
- Added player detection of terrain(only for above and below right now)    

Need to do:    
- mob and player HP    
- set paths for mobs    
- sprites    
- the level    
- music    
- polishing    

5/23/15    
Updates:    
- Added player class    
- Added mob class    
- Added movement for player (currently in 4 directions until jump is implemented)    
- Added player detection of a mob hitbox    

Need to do:    
- Jumping     
- mob detection of a player hitbox
- mob and player HP    
- set paths for mobs    
- sprites    
- the level    
- music    
- polishing

5/22/15 (Initial Setup)
Roadmap of goals:    
- Basic movement (left and right)    
- Jumping    
- Enemies+life implementation    
- Hitboxes    
- Attacks    
- Map structure    
- Boss/possible mini-boss    
- Sprites    
- Music    
- More levels    
- Polishing hitboxes and sprites    

What will be challenging:    
- movement and sprites, maybe the jumping depending on implementation(holding spacebar makes you jump higher or a set jump)    

What are the minimum features for a working project:    
Movement, enemies, attacking, interactions between sprites (hitboxes)    


Brief Description:    
We will be creating a platform game similar to Megaman. The player uses a character to maneuver across a map while killing enemies by using projectiles or a sword. There is going to be a boss at the end of the stage.    
