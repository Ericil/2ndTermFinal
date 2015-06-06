class Projectile{
 int x,y,spd;
 boolean side;
 
 Projectile(int a, int b, boolean right){
  x = a;
  y = b;
  spd = 15;
  side = right;
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
 
 void setx(int a){
   x = a;
 }
 void sety(int a){
   y = a;
 }
 void setspd(int a){
   spd = a;
 } 
}
