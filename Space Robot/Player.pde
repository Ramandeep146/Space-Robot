class Player extends Character implements CharacterUpdate{


  private int speed;
  private int jumpVel=0;
  
  private int gravity = 1;
  
  
  Player(int x, int y){
    super(x, y);
  }
  
  @Override
  public void move(){
     if(left){
       this.setX(this.getX()-speed);
     }
     if(right){
       this.setX(this.getX()+speed);
     }
     gravityPull();
  }
  
  @Override
  public boolean detectCollision(){
    
    boolean bool = false;
      if(this.getX() <= 0){
        this.setX(0);
        bool = true;
      }
      if(this.getX() >= width-50){
        this.setX(width-50);
        bool = true;
      }
      if(this.getY() <= 0){
        this.setY(0);
        bool = true;
      }
      if(this.getY() >= height - 80){
        jumpVel = 0;
        this.setY(height-80);
        bool = true;
      }
      return bool;
  }
  
  public void gravityPull(){   
    if(jump){
      jumpVel = 0;
      return;
    }
      this.setY(this.getY() + jumpVel);
        jumpVel = jumpVel + gravity;  
  }

  public void setSpeed(int speed){
    this.speed = speed;
  }
  
  public void setVel(int vel){
    this.jumpVel = vel;
  }
  

  public ArrayList<Bullet> getArrayList(){
    return null;
  }
  
  @Override
  public String toString(){
    return "Player";
  }
  
  public void display(){}
  public void usePower(){}

}
