class Mob{
  int x;
  int y;
  boolean movement;
  Mob(){
    this(100, 200);
  }
  Mob(int a, int b){
    x = a;
    y = b;
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
