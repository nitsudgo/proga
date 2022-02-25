int SEED = 1634;
float angularNoise, radiusNoise;
float xNoise, yNoise;
float angle = PI;
float radius;
float strokeColor = 254;
float strokeChange = -1;

void setup() {
  size(512,512);
  background(255);
  smooth();
  frameRate(60);
  noFill();
  
  //randomSeed(SEED);
  //noiseSeed(SEED);
  angularNoise = random(10);
  radiusNoise = random(10);
  xNoise = random(10);
  yNoise = random(10);
}

void draw() {
  radiusNoise += 0.005;
  radius = (noise(radiusNoise) * 250) + 1;
  
  angularNoise += 0.05;
  angle += (noise(angularNoise) * 6) - 3;
  if (angle > 360) { angle -= 360; };
  if (angle < 0 ) { angle += 360; };
  
  xNoise += 0.01;
  yNoise += 0.01;
  float centerX = width/2 + (noise(xNoise)*100) - 50;
  float centerY = height/2 + (noise(yNoise)*100) - 50;
  
  float rads = radians(angle);
  float x1 = centerX + (radius * cos(rads));
  float y1 = centerY + (radius * sin(rads));
  
  float opposite_rads = rads + PI;
  float x2 = centerX + (radius * cos(opposite_rads));
  float y2 = centerY + (radius * sin(opposite_rads));
  
  strokeColor += strokeChange;
  if (strokeColor > 254) { strokeChange = -1; };
  if (strokeColor < 0) { strokeChange = 1; };
  stroke(strokeColor, 60); // B&W
  
  strokeWeight(2);
  line(x1,y1,x2,y2);
}
