class point{
  int xpos;
  int ypos;
  int isgood;
  int prev;}
ArrayList<point> path;
point[] bad_pts;
int w = 35;
int h = 35;
int sz = 1000;
float scale = sz/(w+1);
int r = 6;
point[][] grid;
int selx = 2;
int sely = 2;
int homex = 1;
int homey = 1;
float phase = 0.0;
float pulse_factor = 5;
float d;
ArrayList<point> neigbors;

void setup(){
  size(1000,1000);
  grid = new point[w][h];
  for(int y = 0; y < h; y++){
    for(int x = 0; x < w; x++){
       point pt = new point();
       pt.xpos = x;
       pt.ypos = y;
       pt.isgood = 1;
       grid[x][y] = pt;}}
  bad_pts = new point[50];
  for(int y = h/2-3; y < h/2 + 4; y++){
    for(int x = h/2-3; x < h/2 + 4; x++){
      grid[x][y].isgood = 0;}}
  for(int y = 12; y < 17; y++){
    for(int x = 5; x < 16; x++){
      grid[x][y].isgood = 0;}}
  render_grid();}
      

void draw(){
  translate(scale,scale);
  path = new ArrayList<point>();
  path.add(grid[homex][homey]);
  update_mouse();
  int x = homex;
  int y = homey;
  walk(x,y);
  draw_path();
  render_grid();
  render_pair();
  //render_neigbors();
  //check_path(x, y);}
}