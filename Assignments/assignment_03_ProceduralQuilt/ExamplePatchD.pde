class ExamplePatchD extends Patch {

  void draw(float x, float y, float w, float h) {
    pushStyle();
    noStroke();
    fill(map(x, 0, width, 0, 255), map(w * h, 0, width * height, 0, 255), map(mouseX - pmouseX, 0, height, 127, 255));
    rect(x, y, w, h);
    ellipseMode(RADIUS);
    fill(20, random(100, 120), 166);
    arc(x, y + h, w, h, PI + HALF_PI, TAU);
    fill(random(200, 240), 221, 26);
    arc(x, y + h, w * 3 / 4, h * 3 /4, PI + HALF_PI, TAU);
    fill(random(180, 217), 4, 4);
    arc(x, y + h, w / 2, h / 2, PI + HALF_PI, TAU);
    fill(10, map(mouseX, 0, height, 45, 90), random(100, 140));
    arc(x, y + h, w / 4, h / 4, PI + HALF_PI, TAU);
    popStyle();
  }
}