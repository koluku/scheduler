void read() {

  String data[] = loadStrings(settings_file);

  for(int i = 0; i < data.length; i++) {

    String row[] = split(data[i], " = ");

    if(row[0].equals("background_image_id")) {

      background_image_id = int(row[1]);

    }
    if(row[0].equals("degital_clock_click")) {

      degital_clock_click = int(row[1]);

    }
    if(row[0].equals("category_id")) {

      category_id = int(row[1]);

    }
    if(row[0].equals("page_id")) {

      page_id = int(row[1]);

    }

  }

}

void write(String var, int value) {

  String origin[] = loadStrings(settings_file);
  String pick[] = {};

  for(int i = 0; i < origin.length; i++) {

    String row[] = split(origin[i], " = ");

    if(!(row[0].equals(var))) {

      pick = append(pick, origin[i]);

    }

  }

  String data[] = append(pick, var + " = " + value);

  saveStrings(settings_file, data);

}

void save(int category_id, int time) {

  String log[] = loadStrings(log_file);
  log = append(log, day() + "," + category_id  + "," + time);

  saveStrings(log_file, log);

}

void nav(int tab_checked) {

  int tab_max = tab_items + tab_checked;

  for(int i = tab_checked; i < tab_max; i++) {

    int j = i;

    if(i > tab_items) {
      j = tab_max - i;
    }

    noStroke();
    fill(white, 255 * (tab_max - i) / tab_items);
    rect(tab_width * j + tab_left, tab_top, tab_width, tab_height);

  }

}

void analog_clock() {

  stroke(white);
  strokeWeight(2);
  noFill();
  ellipse(width / 2, height / 2, 180 * 2 + 2, 180 * 2 + 2);

  analog_clock_hand(second() / 60.0, 180, 1, width / 2, height / 2);
  analog_clock_hand(minute() / 60.0, 140, 4, width / 2, height / 2);
  analog_clock_hand(hour() / 12.0, 100, 8, width / 2, height / 2);

}

void analog_clock_hand(float rat, float r, float weight, float x, float y) {

  float theta = TWO_PI * rat - PI / 2.0;
  float x1 = x + r * cos(theta);
  float y1 = y + r * sin(theta);

  stroke(white);
  strokeWeight(weight);
  line(x, y, x1, y1);

}

void degital_clock(int option) {

  if(option == 0) {

    degital_clock_all();

  }
  if(option == 1) {

    degital_clock_ampm();

  }

}

void degital_clock_all() {

  fill(white);
  textSize(84);
  text(nf(hour(), 2) + ":" + nf(minute(), 2) + ":" + nf(second(), 2), 60, height - 30);

}

void degital_clock_ampm() {

  fill(white);
  textSize(32);

  if(hour() % 12 == 0) {

    text("AM", 30, height - 30);

  }
  else {

    text("PM", 30, height - 30);

  }

  textSize(84);
  text(nf(hour() % 12, 2) + ":" + nf(minute(), 2) + ":" + nf(second(), 2), 80, height - 30);

}

void timer(int toggle) {

  int time_hour = int(time) / 3600;
  int time_minute = (int(time) % 3600) / 60;
  int time_second = int(time) % 60;
  String time_show = nf(time_hour, 2) + ":" + nf(time_minute, 2) + ":" + nf(time_second, 2);

  fill(white);
  textSize(84);
  text(time_show, 50, 150);

  PImage left_arrow = loadImage("arrow-left.png");
  PImage right_arrow = loadImage("arrow-right.png");
  image(left_arrow, 20, 200);
  image(right_arrow, width - 50 - 20, 200);
  textSize(64);
  text(category[category_id], 150, 240);

  noFill();
  stroke(white);
  strokeWeight(2);
  ellipse(170, 430, 300, 300);
  ellipse(380, 510, 150, 150);

  if(toggle == 0) {

    fill(white);
    textSize(84);
    text("Start", 80, 460);

    if(time < 900) {

      textSize(32);
      text("Reset", 340, 520);

    }
    else {

      textSize(32);
      text("Record", 330, 520);

    }

  }
  else if(toggle == 1) {

    fill(white);
    textSize(84);
    text("Stop", 80, 460);
    textSize(32);
    text("Reset", 340, 520);

  }

}

void graph() {

  String log[] = loadStrings(log_file);
  int data[][] = new int[log.length][3];

  for(int i = 0; i < log.length; i++) {

    String row[] = split(log[i],",");

    for(int j = 0; j < 3; j++) {

      data[i][j] = int(row[j]);

    }

  }

  PImage left_arrow = loadImage("arrow-left.png");
  PImage right_arrow = loadImage("arrow-right.png");
  image(left_arrow, 20, 70);
  image(right_arrow, width - 50 - 20, 70);
  fill(white);
  textSize(64);
  text(category[category_id], 150, 110);

  stroke(white);
  strokeWeight(2);
  line(40, 140, 40, 440);
  line(40, 440, width - 20, 440);
  line(40, 290, 45, 290);
  fill(white);
  textSize(20);
  text("2h", 10, 140);
  text("1h", 10, 290);
  text("0", 20, 440);

  int i = 0;
  float set;
  float sum = 0;

  for(int j = 0; j < log.length; j++) {

    if(data[j][1] == category_id) {

      if(graph_page == 1) {

        if( data[j][0] > day() - 15 && data[j][0] < day() - 7) {

          set = data[j][2];

          stroke(white);
          strokeWeight(6);
          line(60 + 60 * i, 440 - 3, 60 + 60 * i, 440 - (set / 3600) * 150 - 3);
          textSize(16);
          text(day() - 14 + i, 60 + 60 * i, 460);

          sum += set;
          i++;

        }

      }

      if(graph_page == 2) {

        if( data[j][0] > day() - 8 && data[j][0] < day() - 0) {

          set = data[j][2];

          stroke(white);
          strokeWeight(6);
          line(60 + 60 * i, 440 - 3, 60 + 60 * i, 440 - (set / 3600) * 150 - 3);
          textSize(16);
          text(day() - 7 + i, 60 + 60 * i, 460);

          sum += set;
          i++;

        }

      }

    }

  }

  textSize(32);
  text("Sum: " + nf((sum / 3600), 1, 1) + " hour", 140, 540);
  text("Ave: " + nf((sum / 3600 / 7), 1, 1) + " hour", 140, 570);

}

void date() {

  fill(white);
  textSize(48);
  text(year() + ". " + month() + ". " + day(), 110, 140);

}

void calender() {

  String week[] = {"SUN", "MON", "TUE", "WED", "TUR", "FRI", "SUT"};

  for(int i = 0; i < 7; i++) {

    fill(white);
    textSize(16);
    text(week[i], 70 + 50 * i, 190);

    for(int j = 0; j < 6; j++) {

      stroke(white);
      strokeWeight(1);
      noFill();
      rect(65 + 50 * i, 200 + 50 * j, 50, 50);

    }

  }

  for(int i = 0; i < 7; i++) {

    if(i > 0 && i < 3) {

      textSize(16);
      text(i, 70 + 50 * (i + 4), 220);

    }

    for(int j = 1; j < 6; j++) {

      if(i + 7 * j + 3 < 39) {

        textSize(16);
        text(i + 7 * (j - 1) + 3, 70 + 50 * i, 220 + 50 * j);

      }

    }

  }

  fill(white);
  rect(65 + 50 * 5, 200 + 50 * 2, 50, 50);
  fill(black);
  text(15, 70 + 50 * 5, 220 + 50 * 2);

}

void page(int id) {

  if (id == 0) {

    analog_clock();
    degital_clock(degital_clock_click % 2);

  }
  if (id == 1) {

    timer(timer_toggle % 2);

  }
  if (id == 2) {

    graph();

  }
  if (id == 3) {

    PImage left_circle_arrow = loadImage("arrow-circle-left.png");
    PImage right_circle_arrow = loadImage("arrow-circle-right.png");

    image(left_circle_arrow, 10, height / 2 - 25);
    image(right_circle_arrow, width - 50 - 10, height / 2 - 25);

    date();
    calender();

    fill(white);
    textSize(18);
    text("Thanks for Unsplash (https://unsplash.com/)", 40, height - 20);

  }

  nav(id);

}
