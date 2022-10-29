class Bullet{
  
  private float x;
  private float y;

  private float bulletSpeed;
  private float a1;
  private float a2;
  
  Bullet(){
  
  }
  
  Bullet(float x1, float y1, float x2, float y2, float bulletSpeed){
    this.x = x1;
    this.y = y1;
    
    this.bulletSpeed = bulletSpeed;
    
    float h = sqrt(((y2-y1)*(y2-y1)) + ((x2-x1) * (x2-x1)));
    a1 = (y2-y1)/h;
    a2 = (x2-x1)/h;
    
  }
  
  void moveBullet(){

      x+=bulletSpeed*a2;
      y+= bulletSpeed*a1;
     
  }
  
  void display(){
      fill(255,0,0);
      circle(x,y,15);
  }
  
  boolean checkCollision(){
    boolean bool = false;
    if(x<0 || x>width){
      bool = true;
    }
    if(y<0 || y>height){
      bool = true;
    }
    return bool;
  }
  
  public float getX(){
    return x;
  }
  
  public float getY(){
    return y;
  }
  
  public void setX(int x){
    this.x = x;
  }
  
  public void setY(int y){
    this.y = y;
  }
}
