class Boss{
 int x,y,spd;
 boolean side;
 int HP;
 
 Boss(){
  x = 700;
  y = 350;
  spd = 0;
  side = true;
  HP = 15;
 }

 int getHP(){
   return HP;
 }
 int getx(){
   return x;
 }
 int gety(){
   return y;
 }
 int getspd(){
   return spd;
 }
 boolean getside(){
   return side;
 }
 
 void setHP(int a ){
   HP = a;
 }
 void setx(int a){
   x = a;
 }
 void sety(int a){
   y = a;
 }
 void setspd(int a){
   spd = a;
 }
 void switchside(){
   side = !side;
 }
   
}
