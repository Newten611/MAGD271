class Card implements Comparable<Card> {
  public String name;
  public Suit suit;
  public Rank rank;
  public Face facing;
  public float cornerRounding = 7.5, screenScale = 0.8;
  public PVector pos, scale;

  // CONSTRUCTORS
  // Multiple constructors are here to give you options when
  // creating a new card. 

  Card() {
    Rank[] ranks = Rank.values();
    Suit[] suits = Suit.values();
    this.suit = suits[int(random(suits.length))];
    this.rank = ranks[int(random(ranks.length))];
    this.facing = Face.Back;
    this.name = this.rank + " of " + this.suit;
    float shortEdge = min(width, height);
    this.pos = new PVector(width * 0.5, height * 0.5);
    // The traditional dimensions of a playing card are 2.5" x 3.5",
    // which is an aspect ratio of 1 : 1.4 or 0.7143 : 1.
    this.scale = new PVector(shortEdge * 0.714 * screenScale, shortEdge * screenScale);
  }

  Card(float x, float y, float w, float h) {
    Rank[] ranks = Rank.values();
    Suit[] suits = Suit.values();
    this.suit = suits[int(random(suits.length))];
    this.rank = ranks[int(random(ranks.length))];
    this.facing = Face.Back;
    this.name = this.rank + " of " + this.suit;
    this.pos = new PVector(x, y);
    this.scale = new PVector(w, h);
  }

  Card(Suit suit, Rank rank) {
    this.suit = suit;
    this.rank = rank;
    this.facing = Face.Back;
    this.name = this.rank + " of " + this.suit;
    this.pos = new PVector(width * 0.5, height * 0.5);
    float shortEdge = min(width, height);
    this.scale = new PVector(shortEdge * 0.714 * screenScale, shortEdge * screenScale);
  }

  Card(Suit suit, Rank rank, float x, float y, float w, float h) {
    this.suit = suit;
    this.rank = rank;
    this.facing = Face.Back;
    this.name = this.rank + " of " + this.suit;
    this.pos = new PVector(width * 0.5, height * 0.5);
    this.pos = new PVector(x, y);
    this.scale = new PVector(w, h);
  }

  // OVERRIDES

  public String toString() {
    return this.name;
  }

  // INSTANCE METHODS

  public int compareTo(Card card) {
    // First sort by suit.
    int suitComparison = this.suit.value.compareTo(card.suit.value);
    // If this card and the comparisand card are of the same suit, the function
    // compareTo() will return 0. If it returns 0, then compare the cards based
    // on rank. The function compareTo is available to the object
    // version of Integer, but not to the primitive variable int.
    if (suitComparison == 0) {
      return this.rank.value.compareTo(card.rank.value);
    } else {
      return suitComparison;
    }
  }

  public Integer compareValue(Card card) {
    return this.rank.value.compareTo(card.rank.value);
  }

  public void printComparison(Card card) {
    int i = this.compareValue(card);
    if (i <= -1) {
      println(this + " is lesser in value than " + card);
    } else if (i >= 1) {
      println(this + " is greater in value than " + card);
    } else {
      println(this + " is equal in value to " + card);
    }
  }

  public Boolean sameSuit(Card card) {
    return this.suit == card.suit;
  }

  public Boolean sameRank(Card card) {
    return this.rank == card.rank;
  }

  public Boolean sameColor(Card card) {
    return this.suit.value == card.suit.value;
  }

  public Boolean bounds() {
    return mouseX > this.pos.x - this.scale.x * 0.5 && mouseX < this.pos.x + this.scale.x * 0.5
      && mouseY > this.pos.y - this.scale.y * 0.5 && mouseY < this.pos.y + this.scale.y * 0.5;
  }

  public Boolean bounds(float x, float y) {
    return x > this.pos.x - this.scale.x * 0.5 && x < this.pos.x + this.scale.x * 0.5
      && y > this.pos.y - this.scale.y * 0.5 && y < this.pos.y + this.scale.y * 0.5;
  }

  // The ternary operator can be used to condense if-else conditions.
  // The syntax asks in effect is condition true? Do true case : do else case.
  // See http://alvinalexander.com/java/edu/pj/pj010018 .
  public void flip() {
    this.facing =
      this.facing == Face.Back
      ? Face.Front
      : Face.Back;
  }

  public void moveTo(PVector dest, float speed) {
    this.pos.lerp(dest, speed);
  }

  public void draw() {
    pushMatrix();
    pushStyle();
    translate(this.pos.x, this.pos.y);
    rectMode(CENTER);
    if (this.facing == Face.Back) {
      drawBack();
    } else {
      drawFront();
    }
    popStyle();
    popMatrix();
  }

  public void mousePressed() {
    if (this.bounds()) {
      this.flip();
    }
  }

  private void drawBack() {
    noStroke();
    if (bounds(mouseX, mouseY)) {
      fill(255, 0, map(this.pos.x, 0, width, 0, 127));
    } else {
      fill(200, 0, map(this.pos.y, 0, height, 0, 127));
    }
    rect(0, 0, this.scale.x, this.scale.y, this.cornerRounding);
  }

  private void drawFront() {
    noStroke();
    if (bounds(mouseX, mouseY)) {
      fill(0, map(mouseX, 0, width, 0, 127), 255);
    } else {
      fill(0, map(mouseY, 0, height, 0, 54), 240);
    }
    rect(0, 0, this.scale.x, this.scale.y, this.cornerRounding);
    drawLabel();
  }

  private void drawLabel() {
    textAlign(CENTER, CENTER);
    textSize(14);
    fill(255);
    text(this.rank.toString() + "\r\nof\r\n" + this.suit, 0, 0);
  }
}