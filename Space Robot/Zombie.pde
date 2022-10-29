class Zombie extends Enemy{
  
  private final int SPEED = 2;
  final static int ZOMBIE_H = 80;
  final static int ZOMBIE_W = 50;
  
  private PImage zombieRight;
  private PImage zombieLeft;
  
  private int directionX;
  
  
  Zombie(int x, int y){
    super(x, y);  
    this.setSpeed(SPEED);
    if(x < width/2){
      directionX = 1;
    }
    else{
      directionX = -1;
    }
    this.setDirectionX(directionX);
    zombieRight = loadImage("zombieRight.png");
    zombieLeft = loadImage("zombieLeft.png");
  }
  
  @Override
  public void display(){
  
    if(directionX > 0){
      image(zombieRight, this.getX(), this.getY(), ZOMBIE_W, ZOMBIE_H);
    }
    else if(directionX < 0){
      image(zombieLeft, this.getX(), this.getY(), ZOMBIE_W, ZOMBIE_H);
    }
  
  }
  
  @Override
  public String toString(){
    return "Zombie";
  }


}
