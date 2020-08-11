//sectors_1c

void sector(float r, float t, float a, float w){  //draww an assload of lines, side by side, really close so they form a secotor of thickness t at distance r from the center starting at angle a and extending for w degrees
  for(float i = 0; i < w; i = i + 0.05){
    line(cos(radians(i + a)) * r, sin(radians(i + a)) * r, cos(radians(i + a)) * (r + t), sin(radians(i + a)) * (r + t));
  }
}

void ray(float r, float a, float w, int ir, int or){  //takes the parameters from a sector as well as the min and max radius, draws 'rays' at the begining or end of an arc
  if(w > 0){
    int end = int(random(2)) * int(w);
    int len = int(random(ir, or)/(ir/3))*(ir/3);
    line(cos(radians(a + end)) * r, sin(radians(a + end)) * r, cos(radians(a + end)) * (len), sin(radians(a + end)) * (len));
  }
}

void run(){
  background(120, 0, 0);
  
  int minRadius = width / 64; //max radius for each pattern
  int maxRadius = width / 8; //min radius
  
  float radius; //parameters generated for each individual arc in the pattern
  float thickness;
  float startAngle;
  float widthAngle;
  
  for(int y = 0; y < 3; y++){ //itterate through a 3 by 3 grid and draw the patterns
    for(int x = 0; x < 3; x++){
      pushMatrix();
      translate((x * width / 4) + (width / 4), (y * height / 4) + (height / 4));
      for(int i = 0; i < int(random(0, 100)); i++){ //each pattern has 0-100 sectors with random parameters
        radius = int(random(minRadius, maxRadius)/10)*10;
        thickness = int(random(minRadius)/(minRadius/3))*(minRadius/3);
        startAngle = int(random(360) / 60) * 60;
        widthAngle = int(random(361) / 120) * 120;
        stroke(0, 0, random(10, 100)); //set a random brightness then draw the sector and ray
        sector(radius, thickness, startAngle, widthAngle);
        ray(radius, startAngle, widthAngle, minRadius, maxRadius);
      }
      popMatrix();
    }
  }
}

void setup(){
  size(1024, 1024);
  colorMode(HSB, 360, 100, 100);
  noSmooth();
  ellipseMode(RADIUS);
  run();
}

void mousePressed(){ //left click to run, right click to save
  if(mouseButton == LEFT){
    run();
  } else if(mouseButton == RIGHT){
    String fname = year() + "-" + month() + "-" + day() + "_" + hour() + ":" + minute() + ":" + second() + ".png";
    save(fname);
  }
}

void draw(){
  
}
