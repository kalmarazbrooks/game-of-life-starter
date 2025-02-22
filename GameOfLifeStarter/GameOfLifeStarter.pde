final int SPACING = 20; // each cell's width/height //<>// //<>//
final float DENSITY = 0.5; // how likely each cell is to be alive at the start
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
    showGrid();
    grid = calcNextGrid();
  }
}

Cell[][] calcNextGrid() {
  Cell[][] nextGrid = new Cell[grid.length][grid[0].length];

  for (int row = 0; row < grid.length; row++) {
    for (int col = 0; col < grid[0].length; col++) {
      int number = countNeighbors(row, col);
      nextGrid[row][col] = new Cell(applyRule(number, row, col), grid[row][col].getTimeAlive());
    }
  }

  return nextGrid;
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

void keyPressed() {
  if (keyCode == ENTER) {
    running = !running;
  }
}
