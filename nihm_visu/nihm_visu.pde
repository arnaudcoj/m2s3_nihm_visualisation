//declare the min and max variables that you need in parseInfo
float minX, maxX;
float minY, maxY; 
int totalCount; // total number of places
float minPopulation, maxPopulation; 
float minSurface, maxSurface;
float minDensity, maxDensity;
float minAltitude, maxAltitude;

float minPopulationToDisplay = 1000.;
float populationToDisplayCoeff = 2.;

//declare the variables corresponding to the column ids for x and y 
int X = 1; 
int Y = 2;
// and the tables in which the city coordinates will be stored 
City cities[];

City lastPointedCity = null;
City lastSelectedCity = null;

HSlider slider;

void setup() {
  size(800,900);
  colorMode(HSB, 255);
  readData();
  noStroke();
  slider = new HSlider(20, 30, 200, 20, 1);
}

void update() { 
}

void draw() {
  background(255);
  //in your draw method
  for (int i = 0 ; i < totalCount ; i++) 
    if (cities[i] != null)
      cities[i].draw();
      
  // for the pointed city to be on the foreground
  if(lastPointedCity != null)
    lastPointedCity.drawName();
    
  fill(color(0));
  text("Afficher les populations supérieures à " + minPopulationToDisplay, 5., 15.);
  
  slider.update();
  slider.display();
  
  minPopulationToDisplay = map(slider.spos, slider.sposMin, slider.sposMax, 3.125, 100000.);
  minPopulationToDisplay = constrain(minPopulationToDisplay, 0, 100000.);
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      slider.move(10);
    } else if (keyCode == DOWN) {
      slider.move(-10);
    }
    
  }
  redraw();
}

void mouseMoved() {
  City pointedCity = pick(mouseX, mouseY);
  if(pointedCity != lastPointedCity) {
    if(lastPointedCity != null) {
      lastPointedCity.hovered = false;
    }
    if(pointedCity != null) {
      pointedCity.hovered = true;
      println(pointedCity.name);
    }
    lastPointedCity = pointedCity;
    redraw();
  }
}

void mouseClicked() {
  City selectedCity = pick(mouseX, mouseY);
  if(selectedCity != lastSelectedCity) {
    if(lastSelectedCity != null) {
      lastSelectedCity.selected = false;
    }
    if(selectedCity != null) {
      selectedCity.selected = true;
      println(selectedCity.name);
    }
    lastSelectedCity = selectedCity;
    redraw();
  }
}

City pick(int px, int py) {
  for(int i = totalCount - 1; i >= 0; i--) {
    if(cities[i] != null) {
      if(cities[i].contains(px, py)) {
        return cities[i];
      }
    }
  }
  return null;
}

void readData() {
  String[] lines = loadStrings("villes.tsv"); 
  parseInfo(lines[0]); // read the header line
  cities = new City[totalCount]; 
  for (int i = 2 ; i < totalCount ; ++i) { 
    String[] columns = split(lines[i], TAB);
    City newCity = new City();
    newCity.readData(columns);
    cities[i-2] = newCity;
  }
}

void parseInfo(String line) {
  String infoString = line.substring(2); // remove the #
  String[] infoPieces = split(infoString, ',');
  totalCount = int(infoPieces[0]);
  minX = float(infoPieces[1]);
  maxX = float(infoPieces[2]);
  minY = float(infoPieces[3]); 
  maxY = float(infoPieces[4]); 
  minPopulation = float(infoPieces[5]); 
  maxPopulation = float(infoPieces[6]); 
  minSurface = float(infoPieces[7]); 
  maxSurface = float(infoPieces[8]); 
  minAltitude = float(infoPieces[9]); 
  maxAltitude = float(infoPieces[10]);
  
  maxDensity = minPopulation / maxSurface;
  minDensity = maxPopulation / max(0.1, minSurface);
  println(minDensity, maxDensity);
} 

float mapX(float x) { 
  return map(x, minX, maxX, 0, 800);
} 

float mapY(float y) { 
  return map(y, minY, maxY, 900, 0);
} 