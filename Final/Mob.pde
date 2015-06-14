class Mob{
  int x;
  int y;
  int HP;
  int picnum;
  boolean movement;
  Mob(int a, int b){
    x = a;
    y = b;
    HP = 1;
    picnum = 0;
    
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
  int getpicnum(){
    return picnum;
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
  void setpicnum(int a ){
    picnum = a;
  }
  void setmovement(boolean a){
    movement = a;
  }
}
