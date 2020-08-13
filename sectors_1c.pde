//sectors_1c

void sector(float r, float t, float a, float w){  //use the arc() function properly, centered on 0,0 radius r, thickness of t, starting at angle a and extending for w degrees
  strokeWeight(t);
  arc(0, 0, r, r, radians(a), radians(a+w));
}

void ray(float r, float a, float w, int ir, int or){  //takes the parameters from a sector as well as the min and max radius, draws 'rays' at the begining or end of an arc
  strokeWeight(1);
  int end = int(random(2)) * int(w); //randomly choose the begining or end of the ray
  int len = int(random(ir, or)/(ir/3))*(ir/3); //pick a lenght for the ray that doesnt extend too far in or out
  line(cos(radians(a + end)) * r, sin(radians(a + end)) * r, cos(radians(a + end)) * (len), sin(radians(a + end)) * (len));
}

void run(){
  background(120, 0, 0);
  
  int minRadius = width / 64; //max radius for each pattern element
  int maxRadius = width / 8; //min radius
  
  float radius; //parameters generated for each individual arc in the pattern
  float thickness;
  float startAngle;
  float widthAngle;
  
  int numOfElements; //number of arcs in each shape, Thanks RobsonMoon
  
  for(int y = 0; y < 3; y++){ //itterate through a 3 by 3 grid and draw the patterns
    for(int x = 0; x < 3; x++){
      pushMatrix();
      translate((x * width / 4) + (width / 4), (y * height / 4) + (height / 4));
      numOfElements = int(random(1, 25)); //sparse looks better
      for(int i = 0; i < numOfElements; i++){ //each pattern has 0-100 sectors with random parameters
        radius = int(random(minRadius, maxRadius)/10)*10; //the /10 and *10 break up the random numbers in to increments of 10
        thickness = int(random(minRadius)/(minRadius/3))*(minRadius/3); //make the thickness a multiple of 1/3 the min radius
        startAngle = int(random(360) / 60) * 60; //sectors start at an angle which is a multiple of 60
        widthAngle = int(random(360) / 120) * 120; //sectors width's are a multiple of 120
        stroke(0, 0, random(10, 100)); //set a random brightness then draw the sector and ray
        sector(radius, thickness, startAngle, widthAngle); //draw the sector
        ray(radius, startAngle, widthAngle, minRadius, maxRadius); //draw the ray
      }
      popMatrix();
    }
  }
}

void setup(){
  size(1024, 1024); //i have a small monitor
  colorMode(HSB, 360, 100, 100); //i think in the colour wheel model
  noSmooth(); //i like jaggies
  noFill(); //make the arcs into arcs not wedges
  strokeCap(SQUARE); //make the arcs square ended
  ellipseMode(RADIUS); //i am bad at math
  run(); //dont walk
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
