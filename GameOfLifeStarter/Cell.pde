public class Cell {
  
  int lifeStatus = 0;
  int nextStatus = 0;
  
  int colorCode; // 0 is blue, 1 is red
  
  ArrayList<Integer> saveState = new ArrayList<Integer>();
  
  public Cell(int bornStatus) {
    lifeStatus = bornStatus;
  }
  
  public void time() {
    saveState.add(lifeStatus);
    lifeStatus = nextStatus;
    
    checkColor();
  }
  
  public void goBack() {
    lifeStatus = saveState.remove(saveState.size()-1);
    
    checkColor();
  }
  
  public void applyNextStatus(int state) {
    nextStatus = state;
  }
  public void alternateStatus(int cCode) {
    if (lifeStatus == 1) {
      lifeStatus = 0;
    } else {
      lifeStatus = 1;
    }
    
    applyColor(cCode);
    checkColor();
    saveState.add(lifeStatus);
  }
  private void applyColor(int cCode) {
    colorCode = cCode;
  }
  
  public int getCellStatus() {
    return lifeStatus;
  }
  
  private void checkColor() {
    if (lifeStatus == 1) {
      if (colorCode == 0) {
        fill(0, 0, 255);
      } else {
        fill(255, 0, 0);
      }
    } else {
      fill(0, 0, 0);
    }
  }
}
