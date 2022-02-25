ExoticMatter em1, em2, em3, em4, em5, em6, em7, em8, em9;
int saveFrames = 0;

void setup() {
  if (args != null) {
    saveFrames = int(args[0]);
  }

  size(1024, 1024, P3D);
  smooth();
  background(255);
  frameRate(60);
  float speed = PI/100;

  // Change these for easy variations
  long seed = 1634;
  strokeWeight(2);

  // With a speed of PI/100, and using sin and cos to evolve the radius for perturbation...
  // ...we will need 2PI / (PI / 100) = 200 steps to loop back to the starting point.

  float emRadius = 150;
  em1 = new ExoticMatter(width/6, height/6, 0, emRadius, speed, seed, 2);
  em2 = new ExoticMatter(3*width/6, height/6, 0, emRadius, speed, seed, 3);
  em3 = new ExoticMatter(5*width/6, height/6, 0, emRadius, speed, seed, 4);

  em4 = new ExoticMatter(width/6, 3*height/6, 0, emRadius, speed, seed, 5);
  em5 = new ExoticMatter(3*width/6, 3*height/6, 0, emRadius, speed, seed, 6);
  em6 = new ExoticMatter(5*width/6, 3*height/6, 0, emRadius, speed, seed, 7);

  em7 = new ExoticMatter(width/6, 5*height/6, 0, emRadius, speed, seed, 8);
  em8 = new ExoticMatter(3*width/6, 5*height/6, 0, emRadius, speed, seed, 9);
  em9 = new ExoticMatter(5*width/6, 5*height/6, 0, emRadius, speed, seed, 10);
}

void draw() {
  background(255);
  em1.evolve();
  em2.evolve();
  em3.evolve();

  em4.evolve();
  em5.evolve();
  em6.evolve();

  em7.evolve();
  em8.evolve();
  em9.evolve();
}

class ExoticMatter {
  float SPHERE_RADIUS;
  float EVOLVE_NOISE_BY;
  float NOISE_EVOLUTION = 0;
  float X_OFFSET;
  float Y_OFFSET;
  float Z_OFFSET;
  int DETAIL;
  long SEED;

  ExoticMatter(float x, float y, float z, float sr, float enb, long seed, int d) {
    randomSeed(seed);
    noiseSeed(seed);
    SEED = seed;
    DETAIL = d;
    X_OFFSET = x;
    Y_OFFSET = y;
    Z_OFFSET = z;
    SPHERE_RADIUS = sr;
    EVOLVE_NOISE_BY = enb;
  }

  void evolve() {
    for (int s = 0; s < 360; s += DETAIL) {
      for (int t = 0; t < 360; t += DETAIL) {
        float normal_x = cos(s) * sin(t);
        float normal_y = sin(s) * sin(t);
        float normal_z = cos(t);

        drawPoint(normal_x, normal_y, normal_z, SPHERE_RADIUS);
      }
    }

    if (saveFrames >= 1) {
      if (NOISE_EVOLUTION >= 4*PI) {
        exit();
      }

      saveFrame("./output/" + SEED + "/######.png");
    }

    NOISE_EVOLUTION += EVOLVE_NOISE_BY;
  }

  void drawPoint(float nx, float ny, float nz, float r) {
    float radius = r * noise(nx + sin(NOISE_EVOLUTION), ny + cos(NOISE_EVOLUTION), nz + sin(NOISE_EVOLUTION) + cos(NOISE_EVOLUTION) );

    colorMode(HSB, 255);
    // stroke(255*sin(radius*0.001), 255*cos(radius*0.001), 255*tan(radius*0.001));
    stroke(50*sin(radius*0.0075), 255*sin(radius*0.01) + 200, 255*sin(radius*0.01) + 75);

    float x = X_OFFSET + radius*nx;
    float y = Y_OFFSET + radius*ny;
    float z = Z_OFFSET + radius*nz;
    point(x, y, z);
  }
}
