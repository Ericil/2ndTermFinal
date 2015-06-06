class Boss{
 int x,y,spd;
 boolean side;
 
 Boss(){
  x = 700;
  y = 400;
  spd = 0;
  side = true;
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
 void switchside(){
   side = !side;
 }
   
}
