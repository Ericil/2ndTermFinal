class Terrain{
  float x;
  float y;
  Terrain(){
    this(0,0);
  }
  Terrain(int a, int b){
    x = (float)a;
    y = (float)b;
  }
  Terrain(float a, int b){
    x = a;
    y = (float)b;
  }
  Terrain(float a, float b){
    x = a;
    y = b;
  }
  float getx(){
    return x;
  }
  float gety(){
    return y;
  }
  
  void setx(float a){
    x = a;
  }
  void sety(float a){
    y = a;
  }
}
