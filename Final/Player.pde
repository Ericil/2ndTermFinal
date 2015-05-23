class Player{
  int x;
  int y;
  Player(){
    this(100, 100);
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
