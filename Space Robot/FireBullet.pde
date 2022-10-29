class FireBullet extends Bullet{
  
  private PImage fireBullet;
  private float bulletSize = 25;
  
  FireBullet(float x1, float y1, float x2, float y2, float bulletSpeed){
      super(x1, y1, x2, y2, bulletSpeed);
      fireBullet = loadImage("fireball.png");
  }
  
  @Override
  void display(){
      image(fireBullet, this.getX(), this.getY(), bulletSize, bulletSize);
  }
  
  public float getBulletSize(){
    return bulletSize;
  }

}
