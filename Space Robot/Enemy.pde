class Enemy extends Character implements CharacterUpdate{
  
  private int directionX;
  private int speed;

  
  Enemy(int x, int y){
    super(x, y);
  }
  
  @Override
  public void move(){
    
    if(directionX > 0 ){
      this.setX(this.getX() + speed);
    }
    else if(directionX < 0){
      this.setX(this.getX() - speed);
    }
  
  }
  
  @Override
  public boolean detectCollision(){
    boolean bool = false;
    if(this.getX() > width+200 || this.getX() < -200){
      bool = true;
    }
    return bool;
  }

  public void display(){}
  public void setSpeed(int speed){
    this.speed = speed;
  }
  
  public void setDirectionX(int directionX){
    this.directionX = directionX;
  }
  

}
