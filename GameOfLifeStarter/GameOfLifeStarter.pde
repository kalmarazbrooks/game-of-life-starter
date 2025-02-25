final int SPACING = 20; // each cell's width/height //<>// //<>// //<>//
final float DENSITY = 0.7; // how likely each cell is to be alive at the start
Cell[][] grid; // the 2D array to hold 0's and 1's

boolean running = true;

void setup() {
  size(1500, 1000); // adjust accordingly, make sure it's a multiple of SPACING
  noStroke(); // don't draw the edges of each cell
  frameRate(10); // controls speed of regeneration
  grid = new Cell[height / SPACING][width / SPACING];

  // populate initial grid
  for (int row = 0; row < grid.length; row++) {
    for (int col = 0; col < grid[0].length; col++) {
      int type = (int) (Math.random() * 11);
      if (type < (DENSITY*10)) {
        grid[row][col] = new Cell(1, 0);
      } else {
        grid[row][col] = new Cell(0, 0);
      }
    }
  }
}

void draw() {
  if (running) {
    runCycle();
  }
  
  long totalMemory = Runtime.getRuntime().totalMemory();
  long freeMemory = Runtime.getRuntime().freeMemory();
  long usedMemory = totalMemory - freeMemory;
  
  println("Total memory: " + totalMemory / (1024 * 1024) + " MB");
  println("Free memory: " + freeMemory / (1024 * 1024) + " MB");
  println("Used memory: " + usedMemory / (1024 * 1024) + " MB");
}
void runCycle() {
  calcNextGrid();
  showGrid();
}

void calcNextGrid() {
  for (int row = 0; row < grid.length; row++) {
    for (int col = 0; col < grid[0].length; col++) {
      int number = countNeighbors(row, col);
      grid[row][col].applyNextStatus(applyRule(number, row, col));
    }
  }
}
int applyRule(int n, int row, int col) {
  if (grid[row][col].getCellStatus() == 1) {
    if (n < 2 || n > 3) {
      return 0;
    }
  } else {
    if (n == 3) {
      return 1;
    }
  }

  return grid[row][col].getCellStatus();
}

int countNeighbors(int y, int x) {
  int n = 0; // don't count yourself!

  for (int a = -1; a <= 1; a++) {
    for (int b = -1; b <= 1; b++) {
      if ((y + a > -1 && x + b > -1) && (y + a < grid.length && x + b < grid[0].length)) {
        n += grid[y + a][x + b].getCellStatus();
      }
    }
  }

  if (grid[y][x].getCellStatus() == 1) {
    n--; // removes self
  }

  return n;
}

void showGrid() {
  // your code here
  for (int row = 0; row < grid.length; row++) {
    for (int col = 0; col < grid[0].length; col++) {
      grid[row][col].time();
      square((col * SPACING), (row * SPACING), SPACING);
    }
  }
  // use square() to represent each cell
  // use fill(r, g, b) to control color: black for empty, red for filled (or alive)
}

void rewind() {
  for (int row = 0; row < grid.length; row++) {
    for (int col = 0; col < grid[0].length; col++) {
      grid[row][col].goBack();
      square((col * SPACING), (row * SPACING), SPACING);
    }
  }

  calcNextGrid();
}

void keyPressed() {
  if (keyCode == RIGHT) {
    runCycle();
  } else if (keyCode == LEFT) {
    rewind();
  } else if (keyCode == ENTER) {
    running = !running;
  }
}

void mousePressed() {
  int yPos = (int)(mouseY / 20);
  int xPos = (int)(mouseX / 20);
  
  if (mouseButton == LEFT) {
    grid[yPos][xPos].alternateStatus(SPACING, yPos, xPos); // single, on/off
  } else if (mouseButton == RIGHT) {
    blast(xPos, yPos); // multiple, on ONLY
  }
}
private void blast(int y, int x) {
  grid[x][y].chargeCell(SPACING, x, y);
  grid[x-1][y].chargeCell(SPACING, x-1, y);
  grid[x+1][y].chargeCell(SPACING, x+1, y);
  grid[x][y-1].chargeCell(SPACING, x, y-1);
  grid[x][y+1].chargeCell(SPACING, x, y+1);
}
