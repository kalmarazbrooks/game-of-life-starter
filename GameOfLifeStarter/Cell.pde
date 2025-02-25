public class Cell {

  int lifeStatus = 0;
  int nextStatus = 0;
  double timeAlive = 0;

  ArrayList<Integer> saveState = new ArrayList<Integer>();

  public Cell(int bornStatus, double previousTime) {
    lifeStatus = bornStatus;
    timeAlive += previousTime;
  }

  public void time() {
    saveState.add(lifeStatus);
    lifeStatus = nextStatus;

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

  public void goBack() {
    lifeStatus = saveState.remove(saveState.size()-1);

    if (lifeStatus == 1) {
      lifetimeIncrease((240 / frameRate)*(-1));
    } else {
      fill(0, 0, 0);
    }
  }

  public void alternateStatus(int SPACING, int xPos, int yPos) {
    if (lifeStatus == 1) {
      lifeStatus = 0;
      fill(0, 0, 0);
    } else {
      lifeStatus = 1;
      fill(255, 0, 0);
    }

    square((yPos * SPACING), (xPos * SPACING), SPACING);
  }
  public void chargeCell(int SPACING, int xPos, int yPos) {
    lifeStatus = 1;
    fill(255, 0, 0);
    
    square((yPos * SPACING), (xPos * SPACING), SPACING);
  }

  public void applyNextStatus(int state) {
    nextStatus = state;
  }
  public int getCellStatus() {
    return lifeStatus;
  }
  public double getTimeAlive() {
    return timeAlive;
  }
}
