
// Visualization of the time travel in the movi "Bill & Ted's Excellent Adventure"

// The data based on this Wikipedia article:
// http://en.wikipedia.org/wiki/Bill_%26_Ted's_Excellent_Adventure
// and run time at which historical figures appear in the actual movie.

import processing.pdf.*;

color circuits = color(255, 30);
color background_color = color(50);
int padding = 60;
int min_year = 1988;
int max_year = -410;
int min_runtime = 0;
int max_runtime = 93;
int dot_size = 20;

void setup() {

  size(600, 900);
  beginRecord(PDF, "bill-and-ted.pdf");
  background(background_color);
  smooth();
  noStroke();

  //for importing csv files into a 2d array
  //by che-wei wang
  //http://cwwang.com/2008/02/23/csv-import-for-processing/

  String lines[] = loadStrings("bill_and_ted.csv");
  String [][] csv;
  int csvWidth=0;

  //calculate max width of csv file
  for (int i=0; i < lines.length; i++) {
    String [] chars=split(lines[i], ',');
    if (chars.length>csvWidth) {
      csvWidth=chars.length;
    }
  }

  //create csv array based on # of rows and columns in csv file
  csv = new String [lines.length][csvWidth];

  //parse values into 2d array
  for (int i=0; i < lines.length; i++) {
    String [] temp = new String [lines.length];
    temp= split(lines[i], ',');
    for (int j=0; j < temp.length; j++) {
      csv[i][j]=temp[j];
    }
  }
  
  //plot the points where movie run times intersect with the year in history
  for (int i = 0; i < csv.length; i++) {
    String year_temp = csv[i][1];
    String minutes_temp = csv[i][2];
    float years_scale = map(int(year_temp), min_year, max_year, padding, width - padding);
    float minutes_scale = map(int(minutes_temp), min_runtime, max_runtime, height - padding, padding);
    float color_change = map(i, 0, csv.length, 0, 255);
    stroke(circuits);
    noFill();
    curveTightness(4);
    bezier(padding, height - padding, -125, 300, 500, 500, years_scale, minutes_scale);
    fill(color_change, 213, 184);
    noStroke();
    ellipse(years_scale, minutes_scale, dot_size, dot_size);
  }

  //draw a circle for 1988 at zero on both axes
  fill(120, 213, 184);
  ellipse(padding, height - padding, dot_size*2, dot_size*2);

  endRecord();
}

