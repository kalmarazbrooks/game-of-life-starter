final int SPACING = 20; // each cell's width/height //<>// //<>//
final float DENSITY = 0.1; // how likely each cell is to be alive at the start
int[][] grid; // the 2D array to hold 0's and 1's

void setup() {
  size(800, 600); // adjust accordingly, make sure it's a multiple of SPACING
  noStroke(); // don't draw the edges of each cell
  frameRate(10); // controls speed of regeneration
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
  // grid = calcNextGrid();
}

int[][] calcNextGrid() {
  int[][] nextGrid = new int[grid.length][grid[0].length];

  // your code here!

  return nextGrid;
}

int countNeighbors(int y, int x) {
  int n = 0; // don't count yourself!
  
  // your code here
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
