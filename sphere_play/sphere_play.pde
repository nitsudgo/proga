int SEED = 420;
int saveFrames = 0;
float INC = 0;
float DELTA_INC = 0.01 * PI;

void setup() {
    if (args != null) {
        saveFrames = int(args[0]);
    }

    size(1024, 1024, P3D);
    frameRate(60);
}

void draw() {
    noiseSeed(SEED);
    background(255);
    translate(width/2, height/2, -300);
    rotateY(frameCount * radians(1));
    rotateX(45);
    // rotateY(45);

    float lastX = 0;
    float lastY = 0;
    float lastZ = 0;

    float s = 0;
    float t = 0;

    float r = 200;

    while(t < 180) {
        s += 3;

        if (s > 360) { t += 6; s = 0; lastX = 0; lastY = 0; lastZ = 0; };

        float radS = radians(s);
        float radT = radians(t);

        float normal_X = (cos(radS) * sin(radT));
        float normal_Y = (sin(radS) * sin(radT));
        float normal_Z = (cos(radT));

        float test = sin(frameCount * radians(1));
        float INC_BY_A = sin(test);
        float INC_BY_B = cos(test);
        float INC_BY_C = sin(test) + cos(test);

        float radius = r + (r * (noise(normal_X + INC_BY_A, normal_Y + INC_BY_B, normal_Z + INC_BY_C) - 0.5));

        float thisX = 0 + (radius * cos(radS) * sin(radT));
        float thisY = 0 + (radius * sin(radS) * sin(radT));
        float thisZ = 0 + (radius * cos(radT));

        if (lastX != 0) {
            // float weightage = 1 + (2 * max((radius - r) / r, 0));
            float weightage = 1 + (3 * (radius - r) / r);
            float newX = thisX * weightage;
            float newY = thisY * weightage;
            float newZ = thisZ * weightage;

            // Normals
            strokeWeight(1);
            // stroke(127);
            // stroke(125 - (160 * 2 * (radius - r) / r), 90 + (50 * 3 * (radius - r) / r));

            float col = (127 * 6 * (radius - r) / r);
            stroke(col, 60 + col, 60 - col, 150 + col);
            line(thisX, thisY, thisZ, newX, newY, newZ);

            // Nodes
            strokeWeight(3 + (7 * 3 * (radius - r) / r));
            point(newX, newY, newZ);

            // Spiral
            strokeWeight(2);
            stroke(0, 10 + (100 * (radius - r) / r));
            // line(thisX, thisY, thisZ, lastX, lastY, lastZ);
        }

        lastX = thisX;
        lastY = thisY;
        lastZ = thisZ;
    }

    if (saveFrames >= 1) {
      if (frameCount * radians(1) > 2*PI) {
        exit();
      }

      saveFrame("./output/" + SEED + "/######.png");
    }


    INC += DELTA_INC;
}