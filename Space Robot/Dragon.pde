class Dragon extends Enemy{  
  
  private final int SPEED = 3;
  final static int DRAGON_H = 100;
  final static int DRAGON_W = 100;
  
  private PImage dragonRight;
  private PImage dragonLeft;
  
  private int directionX;
  
  Dragon(int x, int y){
    super(x, y);  
    this.setSpeed(SPEED);
    if(x < width/2){
      directionX = 1;
    }
    else{
      directionX = -1;
    }
    this.setDirectionX(directionX);
    dragonRight = loadImage("dragonRight.png");
    dragonLeft = loadImage("dragonLeft.png");
  }
  
  @Override
  public void display(){
  
    if(directionX > 0){
      image(dragonRight, this.getX(), this.getY(), DRAGON_W, DRAGON_H);
    }
    else if(directionX < 0){
      image(dragonLeft, this.getX(), this.getY(), DRAGON_W, DRAGON_H);
    }
    
  }

  
  @Override
  public String toString(){
    return "Dragon";
  }
  
}  
