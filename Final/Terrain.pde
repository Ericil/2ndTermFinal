class Terrain{
  int x;
  int y;
  Terrain(){
    this(0,0);
  }
  Terrain(int a, int b){
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
