class Player{
  int x;
  int y;
  Player(){
    x = 50;
    y = 50;
  }
  Player(int a, int b){
    x = a;
    y = b;
  }
  
  int getx(){
    return x;
  }
  int gety(){
    return y;
  }
  
  void setx(int a){
    x = a;
  }
  void sety(int a){
    y = a;
  }
}
