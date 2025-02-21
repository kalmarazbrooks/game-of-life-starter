final int SPACING = 20; // each cell's width/height //<>// //<>//
final float DENSITY = 0.1; // how likely each cell is to be alive at the start
int[][] grid; // the 2D array to hold 0's and 1's

void setup() {
  size(800, 600); // adjust accordingly, make sure it's a multiple of SPACING
  noStroke(); // don't draw the edges of each cell
  frameRate(1); // controls speed of regeneration
  grid = new int[height / SPACING][width / SPACING];

  // populate initial grid
  for (int row = 0; row < grid.length; row++) {
     for (int col = 0; col < grid[0].length; col++) {
       int type = (int) (Math.random() * 11);
       if (type < (DENSITY*10)) {
         grid[row][col] = 1;
       } else {
         grid[row][col] = 0;
       }
     }
  }
}

void draw() {
  showGrid();
  grid = calcNextGrid();
}

int[][] calcNextGrid() {
  int[][] nextGrid = new int[grid.length][grid[0].length];

  for (int row = 0; row < grid.length; row++) {
     for (int col = 0; col < grid[0].length; col++) {
       int number = countNeighbors(row, col);
       nextGrid[row][col] = applyRule();
     }
  }

  return nextGrid;
}
int applyRule() {
  return 1;
}

int countNeighbors(int y, int x) {
  int n = 0; // don't count yourself!
  
  for (int a = -1; a <= 1; a++) {
    for (int b = -1; b <= 1; b++) {
      if ((y + a > -1 && x + b > -1) && (y + a < grid.length && x + b < grid[0].length)) {
        n += grid[y + a][x + b];
      }
    }
  }
  
  if (grid[y][x] == 1) {
    n--; // removes self
  }
  // don't check out-of-bounds cells

  return n;
}

void showGrid() {
  // your code here
  for (int row = 0; row < grid.length; row++) {
     for (int col = 0; col < grid[0].length; col++) {
       if (grid[row][col] == 1) {
         fill(255, 255, 255);
       } else {
         fill(0, 0, 0);
       }
       
       square((col * SPACING), (row * SPACING), SPACING);
     }
  }
  // use square() to represent each cell
  // use fill(r, g, b) to control color: black for empty, red for filled (or alive)
}
