boolean right, left, jump;
boolean running = false;
int score = 0;
String s = "";
PImage img;

PrintWriter output;


Player p;
ArrayList<Enemy> enemies;
ArrayList<FireBullet> fire;

void setup(){
  frameRate(60);
  fullScreen(P2D);
  //size(1500,800,P2D);
 // background(50);
  img = loadImage("background2.jpg");
  enemies = new ArrayList<Enemy>();
  fire = new ArrayList<FireBullet>();
  p = new Robot(width/2,height-Robot.ROBOT_H);
  output = createWriter("KillPosition.txt");
  running = true;
}

void draw(){
  //background(50);
  image(img, 0,0, width, height);
  fill(255);
  
  if(!running){
    fill(255,0,0);
    textSize(100);
    text("GAME OVER!", width/2-textWidth("GAME OVER!")/2, height/2-50);
    text(s, width/2-textWidth(s)/2, height/2 + 50); 
    text("Click Anywhere to Start Again!", width/2-textWidth("Click Anywhere to Start Again!")/2, height/2 + 150); 
   // output.close();
    return;
  }
  
  updatePlayer();
  updateEnemies();
  updateFireBullet();
  
  detectBulletCol();
  
  if (detectPlayerEnemyCol()){
    running = false;;
  };
  s = "SCORE: " + str(score);
  textSize(40);
  text(s, width/2-textWidth(s)/2, 50); 
 
}

void reset(){
  enemies = new ArrayList<Enemy>();
  fire = new ArrayList<FireBullet>();
  p = new Robot(width/2,height-Robot.ROBOT_H);
  score = 0;
  running = true;
}

void updatePlayer(){
  p.move();
  p.detectCollision();
  p.display();
}

void updateEnemies(){

  if(random(1) < 0.01){
    if(random(1) < 0.7){
      enemies.add(new Zombie((int)random(2)*(width+Zombie.ZOMBIE_W)-Zombie.ZOMBIE_W, height - Zombie.ZOMBIE_H));
    }
    else{
      enemies.add(new Dragon((int)random(2)*(width+Dragon.DRAGON_W)-Dragon.DRAGON_W, (int)random(height-200)));
    }
    
  }
  
  for(int i = enemies.size()-1; i>=0; i--){
    Enemy e = enemies.get(i);
    e.move();
    e.display();
    if(e.detectCollision()){
      enemies.remove(i);
    }
  }
  
  for(int i = enemies.size()-1; i>=0; i--){
    Enemy e = enemies.get(i);
    if(e.toString() == "Dragon" && random(1) < 0.006){
      fire.add(new FireBullet(e.getX() + Dragon.DRAGON_W/2, e.getY() + Dragon.DRAGON_H/2, p.getX(), p.getY(), 5));
    }
  }

}

void updateFireBullet(){
   for(int i=fire.size()-1; i>=0;i--){
        Bullet b = fire.get(i);
        b.moveBullet();
        b.display();
        if(b.checkCollision()){
          fire.remove(i);
        }
    }
    
   for(int i=fire.size()-1; i>=0;i--){
        FireBullet b = fire.get(i);
        
        
        float bx = b.getX();
        float by = b.getY();
        int px = p.getX();
        int py = p.getY();
        
        float distance = sqrt(((px-bx)*(px-bx)) + ((py-by)*(py-by))); 
        if (distance <= Robot.ROBOT_W-15 + b.getBulletSize()) {
          running = false;
        }
        
        //if(b.getX() >= p.getX()+10 && b.getY() >= p.getY()+10 && b.getX() <= p.getX()+Robot.ROBOT_W - 10 && b.getY() <= p.getY()+Robot.ROBOT_H - 10){
        //  running = false;
        //}
    }
    
}

boolean detectPlayerEnemyCol(){
  
  for(int i = enemies.size()-1; i>=0; i--){
    Enemy e = enemies.get(i);
    int ex = e.getX();
    int ey = e.getY();
    int px = p.getX();
    int py = p.getY();
    
    int pW = 0;
    int eW = 0;

    if(p.toString() == "Robot"){
      pW = Robot.ROBOT_W;
    }
    if(e.toString() == "Dragon"){
      eW = Dragon.DRAGON_W;
    }
    if(e.toString() == "Zombie"){
      eW = Zombie.ZOMBIE_W;
    }
    
    float distance = sqrt(((px-ex)*(px-ex)) + ((py-ey)*(py-ey))); 

    // Compare distance to sum of radii
    if (distance <= eW/2 + pW/2) {
      return true;
    }
  }
  
  return false;
}

boolean detectBulletCol(){
    boolean bool = false;
    
    ArrayList<Bullet> bullets = p.getArrayList();
    
    for(int i = bullets.size()-1; i>=0; i--){
      for(int j = enemies.size()-1; j>=0; j--){
        
        Bullet b = bullets.get(i);
        Enemy e = enemies.get(j);
        
        int ex = e.getX();
        int ey = e.getY();
        int bx = (int)b.getX();
        int by = (int)b.getY();
        int wid = 0;
        int hei = 0;
        
        if(e.toString() == "Zombie"){
          wid = Zombie.ZOMBIE_W;
          hei = Zombie.ZOMBIE_H;
        }
        else if(e.toString() == "Dragon"){
          wid = Dragon.DRAGON_W;
          hei = Dragon.DRAGON_H;
        }
        
        if(bx>=ex && bx<=ex+wid && by>=ey && by<=ey+hei){
          if(e.toString()=="Dragon"){
            score+=50;
          }
          else if(e.toString()=="Zombie"){
            score+=10;
          }
          output.println("Enemy killed at X = " + ex + " and Y = " + ey + " at " + hour() + ":" + minute() + ":" + second());
          output.flush();
          enemies.remove(j);
          bullets.remove(i);
          break;
        }
      }
    }
    
    return bool;
}

void keyPressed(){
  
  if(keyCode == 65){
    left = true;
  }
  else if(keyCode == 68){
    right = true;
  }
  else if(keyCode == 32){
    jump = true;
  }
  
  
}

void keyReleased(){
  
  if(keyCode == 65){
    left = false;
  }
  else if(keyCode == 68){
    right = false;
  }
  else if(keyCode == 32){
    jump = false;
  }

}

void mousePressed(){
  if(running){
      p.usePower();
  }
  else{
      reset();
  }

}
