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

void setup() {
  size(800,900);
  colorMode(HSB, 255);
  readData();
  noStroke();
}

void draw() {
  background(255);
  //in your draw method
  for (int i = 0 ; i < totalCount ; i++) 
    if (cities[i] != null)
      cities[i].draw();
  fill(color(0));
  text("Afficher les populations supérieures à " + minPopulationToDisplay, 5., 15.);
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      minPopulationToDisplay *= populationToDisplayCoeff;
    } else if (keyCode == DOWN) {
      minPopulationToDisplay *= 1. / populationToDisplayCoeff;
    }
    minPopulationToDisplay = constrain(minPopulationToDisplay, 3.125, 2560000.);
  }
  redraw();
}

void mouseMoved() {
  City pointedCity = pick(mouseX, mouseY);
  if(pointedCity != lastPointedCity) {
    if(pointedCity != null) {
      println(pointedCity.name);
    }
    lastPointedCity = pointedCity;
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