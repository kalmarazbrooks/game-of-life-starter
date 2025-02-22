public class Cell {
  
  int lifeStatus = 0;
  double timeAlive = 0;
  
  public Cell(int bornStatus, double previousTime) {
    lifeStatus = bornStatus;
    timeAlive += previousTime;
  }
  
  public void time() {
    if (lifeStatus == 1) {
      lifetimeIncrease(240 / frameRate);
    } else {
      fill(0, 0, 0);
      timeAlive = 0;
    }
  }
  private void lifetimeIncrease(double time) {
    timeAlive += time;
    
    fill((float)(255 - Math.min(timeAlive, 255)), 0, (float)(Math.min(timeAlive, 255)));
  }
  
  public int getCellStatus() {
    return lifeStatus;
  }
  public double getTimeAlive() {
    return timeAlive;
  }
}
