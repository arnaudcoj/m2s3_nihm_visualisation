class City {
  int postalcode; 
  String name; 
  float x; 
  float y; 
  float population; 
  float density; 
  
  float screen_x;
  float screen_y;
  color col;
  float radius;
  
  // put a drawing function in here and call from main drawing loop

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
    
    col = color(0, 200, mapDensity(density));
    radius = mapPopulation(population);
    screen_x = mapX(x);
    screen_y = mapY(y);
  }

  void draw() {
    if(population < minPopulationToDisplay)
      return;
    fill(col);
    ellipse(screen_x, screen_y, radius, radius);
    //set((int) mapX(x), (int) mapY(y), black);
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
   float radius = mapPopulation(population);
   return dist(mapX(x), mapY(y), px, py) <= radius + 1;
  }
} 