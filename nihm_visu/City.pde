class City {
  int postalcode; 
  String name; 
  float x; 
  float y; 
  float population; 
  float density; 
  
  float screen_x;
  float screen_y;
  float radius;
  
  boolean hovered = false;
  boolean selected = false;
  
  void readData(String[] columns) { 
    postalcode = int(columns[0]);
    x = float(columns[1]);
    y = float(columns[2]);
    name = columns[4];
    population = float(columns[5]);
    float surface = max(float(columns[6]), 0.1);
    
    density = population / surface;
    
    minDensity = min(density, minDensity);
    maxDensity = max(density, maxDensity);
    
    radius = mapPopulation(population);
    screen_x = mapX(x);
    screen_y = mapY(y);
  }

  void draw() {
    if(population < minPopulationToDisplay)
      return;
    
    
    color col;
    
    if(selected) {
      col = color(70, 200, mapDensity(density));
      fill(col);      
    } else if (hovered) {
      col = color(150, 200, mapDensity(density));
      fill(col);
    } else {
      col = color(0, 200, mapDensity(density));
      fill(col);
    }
    
    ellipse(screen_x, screen_y, radius, radius);
    //set((int) mapX(x), (int) mapY(y), black);
  }
  
  void drawName() {
    if(selected) {
      color col;
      float text_x = screen_x + radius / 2. + 5;
      float text_y = screen_y;
      float text_width = textWidth(name);
      
      col = color(70, 35, 255, 220);
      fill(col);
      rect(text_x, text_y, text_width + 5, 20, 3, 6, 12, 18); 

      col = color(70, 255, 40);
      fill(col);      
      textAlign(LEFT, BOTTOM);
      text(name, text_x + 2, text_y + 18);
      
    } else if(hovered) {
      color col;
      float text_x = screen_x + radius / 2. + 5;
      float text_y = screen_y;
      float text_width = textWidth(name);
      
      col = color(150, 35, 255, 220);
      fill(col);
      rect(text_x, text_y, text_width + 5, 20, 3, 6, 12, 18); 

      col = color(150, 255, 40);
      fill(col);      
      textAlign(LEFT, BOTTOM);
      text(name, text_x + 2, text_y + 18);
    }
  }

  float mapX(float x) { 
    return map(x, minX, maxX, 0, 800);
  } 

  float mapY(float y) { 
    return map(y, minY, maxY, 900, 0);
  } 

  float mapPopulation(float p) {
    return map(p, minPopulation, maxPopulation, 2, 100);
  }

  float mapDensity(float d) {
    return map(d, minDensity, maxDensity, 255, 100);
  }
  
  boolean contains (int px, int py) {
    if(population < minPopulationToDisplay)
      return false;
   return dist(screen_x, screen_y, px, py) < radius / 2.;
  }
} 