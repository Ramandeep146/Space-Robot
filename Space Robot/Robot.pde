class Robot extends Player{
  
  private float leftArmAngle = 0.0;
  private float rightArmAngle = 0.0;
  
  private ArrayList<Bullet> bullets;
  
  final static int ROBOT_H = 80;
  final static int ROBOT_W = 50;
  
  private PImage img = loadImage("robot.png");
  private PImage fire = loadImage("fire.png");
  
  private final int SPEED = 10;
  private final int VEL = -10;
  private final int bulletSpeed = 12;
  
  
  Robot(int x, int y){
    super(x,y);
    this.setSpeed(SPEED);
    this.setVel(VEL);
    bullets = new ArrayList<Bullet>();
  }
  
  @Override
  public void usePower(){
    bullets.add(new Bullet(this.getX() + ROBOT_W/2, this.getY() + ROBOT_H/2, mouseX, mouseY, bulletSpeed));
  }
  
  public ArrayList<Bullet> getArrayList(){
    return bullets;
  }
  
  @Override
  public void display(){
    
    /*
     * These variables are for mouseX and mouseY,
     * adjusted to be relative to the robot's location
     */
    float mX;
    float mY;

    pushMatrix();

    translate(this.getX(), this.getY()); // place robot so arms are always on screen
    
    mX = mouseX - this.getX();
    mY = mouseY - this.getY();
    
    leftArmAngle = atan2(mY - ROBOT_H/2 - 10, mX) - HALF_PI;
    
    rightArmAngle = atan2(mY - ROBOT_H/2 - 10, mX - ROBOT_W) - HALF_PI;
  
    drawRobot();
    
    popMatrix();

    for(int i=bullets.size()-1; i>=0;i--){
        Bullet b = bullets.get(i);
        b.moveBullet();
        b.display();
        if(b.checkCollision()){
          bullets.remove(i);
        }
    }
    
      
  }
  
  @Override
  public void move(){
     if(left){
       this.setX(this.getX()-SPEED);
     }
     if(right){
       this.setX(this.getX()+SPEED);
     }
     if(jump){
       this.setY(this.getY() - SPEED/2);
     }
     super.gravityPull();
  }
  
  private void drawRobot(){
    image(img, 0, 0, ROBOT_W, ROBOT_H);
    fill(220,0,0);
    drawLeftArm();
    drawRightArm();
    if(jump){
      drawFire();
    }
  }

  private void drawLeftArm(){
    pushMatrix();
    translate(0, ROBOT_H/2 + 10);
    rotate(leftArmAngle);
    rect(-10, 0, 10, 30); // left arm
    popMatrix();
  }

  private void drawRightArm(){
    pushMatrix();
    translate(ROBOT_W, ROBOT_H/2 + 10);
    rotate(rightArmAngle);
    rect(0, 0, 10, 30); // right arm
    popMatrix();
  }
  
  private void drawFire(){
    image(fire, ROBOT_W/2-15, ROBOT_H-10, 30,30);
  }
  
  @Override
  public String toString(){
    return "Robot";
  }
  
}
