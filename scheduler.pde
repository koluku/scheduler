void setup() {

  // init
  size(480, 640);
  frameRate(100);

}

void draw() {

  // settings
  read();

  // background
  PImage background = loadImage(background_image[background_image_id]);
  image(background, 0, 0);
  fill(black, 255 * 1/4);
  noStroke();
  rect(0, 50, width, height);

  // page
  page(page_id);

  // timer count
  if(timer_toggle % 2 == 1) {

    time += 0.02;

  }

}

void mouseClicked() {

  if (mouseY > 0 && mouseY < tab_height + tab_top) {

    if (mouseX < tab_width * 1 + tab_left)  {

      // change page
      page_id = 0;
      write("page_id", page_id);

    }

    else if (mouseX < tab_width * 2 + tab_left)  {

      // change page
      page_id = 1;
      write("page_id", page_id);

    }

    else if (mouseX < tab_width * 3 + tab_left)  {

      // change page
      page_id = 2;
      write("page_id", page_id);

    }

    else if (mouseX < tab_width * 4 + tab_left)  {

      // change page
      page_id = 3;
      write("page_id", page_id);

    }

  }

  if (page_id == 0) {

    if (mouseY > height - 84 - 30  && mouseY < height - 30) {

      if (mouseX > 0 && mouseX < width) {

        // toggle all or ampm
        degital_clock_click++;
        write("degital_clock_click", degital_clock_click % 2);

      }

    }

  }

  if (page_id == 1) {

    if (mouseY > 190  && mouseY < 190 + 50) {

      if (mouseX > 20 && mouseX < 70) {

        if (category_id == 0) {

          // reset work category
          category_id = category.length - 1;
          write("category_id", category_id);

        }
        else {

          // change work category
          category_id--;
          write("category_id", category_id);

        }

      }

      if (mouseX > 410 && mouseX < 460 ) {

        if (category_id == category.length - 1) {

          // reset work category
          category_id = 0;
          write("category_id", category_id);

        }
        else {

          // change work category
          category_id++;
          write("category_id", category_id);

        }

      }

    }

    if (mouseY > 280  && mouseY < 580) {

      if (mouseX > 20 && mouseX < 320) {

        timer_toggle++;

      }

    }
    if (mouseY > 435  && mouseY < 585) {

      if (mouseX > 305 && mouseX < 455) {

        if(timer_toggle % 2 == 0) {

          if(time < 900) {

            time = 0;
            timer_toggle++;

          }
          else {

            save(category_id, int(time));
            time = 0;
            timer_toggle++;

          }

        }
        else {

          time = 0;
          timer_toggle++;

        }

      }

    }

  }

  if (page_id == 2) {

    if (mouseY > 70  && mouseY < 70 + 50) {

      if (mouseX > 20 && mouseX < 70) {

        if (category_id == 0) {

          category_id = category.length - 1;
          write("category_id", category_id);

        }
        else {

          category_id--;
          write("category_id", category_id);

        }

      }

      if (mouseX > 410 && mouseX < 460 ) {

        if (category_id == category.length - 1) {

          category_id = 0;
          write("category_id", category_id);

        }
        else {

          category_id++;
          write("category_id", category_id);

        }

      }

    }

    if (mouseY > 140  && mouseY < 440) {

      if (mouseX > 40 && mouseX < 140) {

        graph_page = 1;

      }

      if (mouseX > width - 120 && mouseX < width - 20) {

        graph_page = 2;

      }

    }

  }

  if (page_id == 3) {

    if (mouseY > 295 && mouseY < 345) {

      if (mouseX > 10 && mouseX < 60) {

        if (background_image_id == 0) {

          background_image_id = background_image.length - 1;
          write("background_image_id", background_image_id);

        }
        else {

          background_image_id--;
          write("background_image_id", background_image_id);

        }

      }

      if (mouseX > 420 && mouseX < 470) {

        if (background_image_id == background_image.length - 1) {

          background_image_id = 0;
          write("background_image_id", background_image_id);

        }
        else {

          background_image_id++;
          write("background_image_id", background_image_id);

        }

      }

    }

  }

}
