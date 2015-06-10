class Mob{
  int x;
  int y;
  int HP;
  boolean movement;
  Mob(int a, int b){
    x = a;
    y = b;
    HP = 2;
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
  boolean getmovement(){
    return movement;
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
  void setmovement(boolean a){
    movement = a;
  }
}
