class Player{
  int x;
  int y;
  int HP;
  Player(){
    this(100, 100);
  }
  Player(int a, int b){
    x = a;
    y = b;
    HP = 5;
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
  
  void setHP(int a){
    HP = a;
  }
  void setx(int a){
    x = a;
  }
  void sety(int a){
    y = a;
  }
}
