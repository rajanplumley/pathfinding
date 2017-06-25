void render_neigbors(){
  ArrayList<point> n = neigbors(grid[homex][homey]);
  for(int i = 0; i < n.size(); i++){
   fill(255,0,0);
   ellipse(scale*n.get(i).xpos,scale*n.get(i).ypos,r,r);}}

void render_grid(){
  strokeWeight(1);
  for(int y = 0; y < h; y++){
    for(int x = 0; x < w; x++){
      stroke(0);
      fill(255);
      if(grid[x][y].isgood == 1){
        ellipse(scale*grid[x][y].xpos, scale*grid[x][y].ypos, r,r);
        grid[x][y].prev = 1;}}}}

void sel_point(point the_pt){
  if(pow((pow(scale*the_pt.xpos + scale - mouseX, 2) + pow(scale*the_pt.ypos + scale - mouseY,2)) , 0.5) < scale*0.5 & the_pt.isgood == 1){
    selx = the_pt.xpos;
    sely = the_pt.ypos;}}

void if_picked(point the_pt){
  if(pow((pow(scale*the_pt.xpos + scale - mouseX, 2) + pow(scale*the_pt.ypos + scale - mouseY,2)) , 0.5) < scale*0.5 && mousePressed == true){
    homex = the_pt.xpos;
    homey = the_pt.ypos;}}

void update_mouse(){
  for(int y = 0; y < h; y++){
    for(int x = 0; x < w; x++){
      if(grid[x][y].isgood == 1){
       sel_point(grid[x][y]);
       if_picked(grid[x][y]);}}}}

void render_pair(){
  fill(0);
  ellipse(scale*selx, scale*sely, r,r );
  ellipse(scale*homex, scale*homey, r + pulse_factor*abs(cos(phase)), r + pulse_factor*abs(cos(phase)));
  phase += 0.20;}

float dist(point pt1, point pt2){
  return pow((pow(scale*pt2.xpos - scale*pt1.xpos, 2) + pow(scale*pt2.ypos - scale*pt1.ypos, 2)) , 0.5);}

//void simple_walk(int x, int y){
//  stroke(0);
//  while(x != selx){
//    int xp = x;
//    if(selx > x){x = x + 1;}
//    if(selx < x){x = x - 1;}
//    path.add(grid[x][y]);}
//  while(y != sely){
//    int yp = y;
//    if(sely > y){y = y + 1;}
//    if(sely < y){y = y - 1;}
//    path.add(grid[x][y]);}}
    
void draw_path(){
  background(180);
  for(int i = 0; i < path.size()-1; i++){
    stroke(0);
    strokeWeight(r/2);
    line(scale*path.get(i).xpos, scale*path.get(i).ypos, scale*path.get(i+1).xpos, scale*path.get(i+1).ypos);}}
    
void check_path(int x, int y){
  for(int i = 0; i < path.size(); i++){
    if(path.get(i).isgood == 0){
      while(path.size() != i+1){
        path.remove(i);}}}}

void walk(int x, int y){
   x = path.get(path.size()-1).xpos;
   y = path.get(path.size()-1).ypos;
   while(grid[x][y] != grid[selx][sely]){
     ArrayList<point> n = neigbors(grid[x][y]);
     ArrayList<point> good_pts = new ArrayList<point>();
     FloatList dists = new FloatList();
     for(int i = 0; i < n.size(); i++){
       if(grid[n.get(i).xpos][n.get(i).ypos].prev == 1){
         dists.append(dist(n.get(i), grid[selx][sely]));
         good_pts.add(grid[n.get(i).xpos][n.get(i).ypos]);}}
     float min = dists.min();
     for(int i = 0; i < good_pts.size(); i++){
       if(dist(good_pts.get(i), grid[selx][sely]) == min){
         x = good_pts.get(i).xpos;
         y = good_pts.get(i).ypos;}}
     path.add(grid[x][y]);
     grid[x][y].prev = 0;}}
     
ArrayList<point> neigbors(point the_pt){
  neigbors = new ArrayList<point>();
  int[] x_candidates = {the_pt.xpos + 1, the_pt.xpos - 1};
  int[] y_candidates = {the_pt.ypos + 1, the_pt.ypos - 1};
  if(x_candidates[0] < w){
    if(grid[x_candidates[0]][the_pt.ypos].isgood == 1){neigbors.add(grid[x_candidates[0]][the_pt.ypos]);}}
  if(x_candidates[1] > -1){
    if(grid[x_candidates[1]][the_pt.ypos].isgood == 1){neigbors.add(grid[x_candidates[1]][the_pt.ypos]);}}
  if(y_candidates[0] < h){
    if(grid[the_pt.xpos][y_candidates[0]].isgood == 1){neigbors.add(grid[the_pt.xpos][y_candidates[0]]);}}
  if(y_candidates[1] > -1){
    if(grid[the_pt.xpos][y_candidates[1]].isgood == 1){neigbors.add(grid[the_pt.xpos][y_candidates[1]]);}}
  return neigbors;}