import java.security.MessageDigest;

String textInput = "Was dich lebendig fühlen lässt, ist nicht das, was du verstehst — sondern das, was du spürst.";

final int COUNT = 32; // 64 hex chars → 32 pairs
String hash;

float[] pt;
int[] style;

void setup() {
  size(1024, 768, P3D);
  colorMode(RGB, 255);
  background(0);

  hash = hashText(textInput);
  pt = new float[6 * COUNT];
  style = new int[2 * COUNT];

  int index = 0;
  for (int i = 0; i < COUNT; i++) {
    String hexPair = hash.substring(i*2, i*2+2);
    int val = Integer.parseInt(hexPair, 16); // 0–255

    pt[index++] = radians(val % 360);               // rotx
    pt[index++] = radians((val * 3) % 360);         // roty
    pt[index++] = map(val % 90, 0, 90, 30, 120);    // degrees
    pt[index++] = map(val, 0, 255, 50, 300);        // radius
    pt[index++] = map(val % 40, 0, 40, 10, 60);     // width
    pt[index++] = radians((val % 20) + 1);          // speed

    float prob = val % 100;
    if (prob < 20) {
      style[i*2] = colorBlended(random(1), 255, 100, 0, 255, 255, 0, 210); // orange-yellow
    } else if (prob < 40) {
      style[i*2] = colorBlended(random(1), 255, 0, 100, 255, 150, 200, 210); // pink-magenta
    } else if (prob < 60) {
      style[i*2] = colorBlended(random(1), 0, 153, 255, 170, 225, 255, 210); // blue-cyan
    } else if (prob < 80) {
      style[i*2] = colorBlended(random(1), 0, 255, 150, 100, 255, 200, 210); // green-teal
    } else {
      style[i*2] = color(255, 255, 255, 220); // white
    }

    style[i*2+1] = val % 3; // shape type
  }
}

void draw() {
  background(0);
  translate(width/2, height/2, -200);
  rotateX(PI / 6);
  rotateY(frameCount * 0.005);

  int index = 0;
  for (int i = 0; i < COUNT; i++) {
    float n = noise(i * 0.1, frameCount * 0.01); // smooth organic variation

    pushMatrix();
    rotateX(pt[index++] + n * 0.2);
    rotateY(pt[index++] + n * 0.3);

    float deg = pt[index++];
    float rad = pt[index++] + n * 20;
    float w = pt[index++];
    float speed = pt[index++];

    int t = style[i*2+1];
    fill(style[i*2]);
    noStroke();

    if (t == 0) {
      arcShape(0, 0, deg, rad, w);
    } else if (t == 1) {
      arcBars(0, 0, deg, rad, w);
    } else {
      arcSolid(0, 0, deg, rad, w);
    }

    pt[index-6] += speed / 10;
    pt[index-5] += speed / 20;
    popMatrix();
  }
}

String hashText(String input) {
  try {
    MessageDigest md = MessageDigest.getInstance("SHA-256");
    byte[] hashBytes = md.digest(input.getBytes("UTF-8"));
    StringBuilder sb = new StringBuilder();
    for (byte b : hashBytes) {
      sb.append(String.format("%02x", b));
    }
    return sb.toString();
  } catch (Exception e) {
    e.printStackTrace();
    return "";
  }
}

int colorBlended(float f, float r1, float g1, float b1, float r2, float g2, float b2, float a) {
  return color(r1 + (r2 - r1) * f,
               g1 + (g2 - g1) * f,
               b1 + (b2 - b1) * f, a);
}

void arcShape(float x, float y, float degrees, float radius, float w) {
  int lineCount = floor(w/2);
  for (int j = 0; j < lineCount; j++) {
    beginShape();
    for (int i = 0; i < degrees; i++) {
      float angle = radians(i);
      vertex(x + cos(angle) * radius,
             y + sin(angle) * radius);
    }
    endShape();
    radius += 2;
  }
}

void arcBars(float x, float y, float degrees, float radius, float w) {
  beginShape(QUADS);
  for (int i = 0; i < degrees/4; i += 4) {
    float angle = radians(i);
    vertex(x + cos(angle) * radius,
           y + sin(angle) * radius);
    vertex(x + cos(angle) * (radius+w),
           y + sin(angle) * (radius+w));

    angle = radians(i+2);
    vertex(x + cos(angle) * (radius+w),
           y + sin(angle) * (radius+w));
    vertex(x + cos(angle) * radius,
           y + sin(angle) * radius);
  }
  endShape();
}

void arcSolid(float x, float y, float degrees, float radius, float w) {
  beginShape(QUAD_STRIP);
  for (int i = 0; i < degrees; i++) {
    float angle = radians(i);
    vertex(x + cos(angle) * radius,
           y + sin(angle) * radius);
    vertex(x + cos(angle) * (radius+w),
           y + sin(angle) * (radius+w));
  }
  endShape();
}