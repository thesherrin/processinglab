// Linbraries
import processing.pdf.*;

//Global
PShape baseMap;
String csv[];
String myData[][];
PFont f;
float scaleFactor = 0.04;
float massThreshold = 5000000;
Boolean flop = true;
void setup() {
  size(1200, 600);
  noLoop();
  baseMap = loadShape("WorldMap.svg");
  csv = loadStrings("MeteorStrikes.csv"); // Modularise this csv import process in the future.
  //  for (int i=0; i< csv.length; i++) {
  //    println(i + "/" + csv[i]);
  //  }
  myData = new String[csv.length][6];
  for (int i=0; i<csv.length; i++) {
    myData[i] = csv[i].split(",");
    println(myData[i][1]);
  }
}


void draw() {
  beginRecord(PDF, "MeteorStrikes.pdf");
  shape(baseMap, 0, 0, width, height); // postion shape (PShape, x,y, width, height)
  noStroke();
  for (int i=0; i<myData.length; i++) {
    //println(i);
    if (myData[i][5].equals("Found")) {
      fill(255, 0, 0, 50);
    } else
    {
      fill (0, 0, 255, 50);
    }
    float graphlong = map(float(myData[i][3]), -180, 180, 0, width);
    float graphlat = map(float(myData[i][4]), -90, 90, height, 0);
    println(graphlong + ";" + graphlat);
    float mass = sqrt(float(myData[i][2])/PI);
    ellipse(graphlong, graphlat, mass*scaleFactor, mass*scaleFactor);
   // if (i<20) {
    if(float(myData[i][2])> massThreshold){ 
     fill(0); //Text Fill Colour
     if(flop){
      text(myData[i][0], graphlong + mass*scaleFactor/2, graphlat);
     }
     else
     {
       text(myData[i][0], graphlong - mass*scaleFactor/2-10, graphlat);
     }
    flop = !flop;
    }
  }
  endRecord();
  println("PDF Saved");
}

