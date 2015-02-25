//Change back to hour - ignore buroughs
//Histogram on hours - slide 

//with the minutes - try a fade in and out over a 15 minute range

//Global 

String csv[];
String myData[][];
float myDataMap[][];//map lat long and borough once.
int myDataTime[][]; //split time once;
int markerSoize = 2;
int fieldLength = 29;

//Canvas Size
int canvasWidth = 1527/2;
int canvasHeight = 1374/2;
//NYC Coordinates

float Nlat = 40.9184;
float Slat = 40.4866;
float Wlong = -74.2909;
float Elong = -73.6764;

//Time Initialisation
int hour = 0;
int minutes =0;

//draw properties
int markerSize = 3; //radius of marker
int markerAlpha = 50; //alpha value for marker
color fillBronx = color(255,200,200);
color fillManhattan = color(210,200,255);
color fillStaten = color(255,200,255);
color fillBrooklyn = color(200,255,200);
color fillQueens = color(255,255,200);
color fillOther = color(255,255,255);
int fontSize = 30;
int fontSizeLegend = 15;

//Legend Defaults
  int legendLeft = 60;
  int legendLeading = 28;
  int legendTop = 170;
  int legendAlpha = 180;

void setup() {
  frameRate(0.5);
  size(canvasWidth, canvasHeight);

  
  smooth(); //anti aliases better
  textSize(fontSize); //Set Text Size;
  textAlign(CENTER); 
  csv = loadStrings("NYPD_Motor_Vehicle_Collisions_2014-old.csv");
  myData = new String[csv.length][fieldLength];
  myDataMap = new float[csv.length][2];
  myDataTime = new int[csv.length][2];
  for (int i=0; i<csv.length; i++) {
    myData[i] = csv[i].split(",");
    float graphLong = map(float(myData[i][5]), Wlong, Elong, 0, width);
    float graphLat = map(float(myData[i][4]), Nlat, Slat, 0, height);
    myDataMap[i][0] = graphLat;
    myDataMap[i][1]= graphLong;
    //time parsing
    int dataHour = 0;
    int dataMinute = 0;
    
    String time[] = myData[i][1].split(":");
    if (!myData[i][1].equals("TIME")) //First row causes an error
    {
      dataHour = int(time[0]);
      dataMinute = int(time[1]);
    }
    myDataTime[i][0] = dataHour;
    myDataTime[i][1] = dataMinute;
    
  }

 
}

void chrome()
{
  //Static features - legends/controls
  //Legend

  textSize(fontSizeLegend);
  textAlign(LEFT);
  fill(fillManhattan, legendAlpha);
  text("Manhattan", legendLeft,(legendTop+ legendLeading * 1));
  fill(fillBronx, legendAlpha);
  text("Bronx", legendLeft, (legendTop + legendLeading * 0));
  fill(fillQueens, legendAlpha);
  text("Queens", legendLeft, (legendTop + legendLeading *2));
  fill(fillStaten, legendAlpha);
  text("Staten Island", legendLeft, (legendTop + legendLeading*4));
  fill(fillBrooklyn, legendAlpha);
  text("Brooklyn", legendLeft, (legendTop + legendLeading*3));
  textAlign(CENTER); //Reset
  textSize(fontSize);//Reset
}


void draw() {
    background(0);
    chrome();
  if (hour < 24) {
    fill(230);
    textAlign(LEFT);
    text("Collisions between\n"+ hour+":00 & "+(hour+1)+":00" , legendLeft, 80);
    //Highlighted data
    int counter = 0;
    for (int i=0; i<myData.length; i++) {

      int myhour = myDataTime[i][0];
      int myminutes = myDataTime[i][1];
     // if (myhour==hour && myminutes==minutes) 
      if (myhour==hour)
      {
        // float graphLong = map(float(myData[i][5]), Wlong, Elong, 0, width);
        //  float graphLat = map(float(myData[i][4]), Nlat, Slat, 0, height);
        //println(graphLat + "/" + graphLong);
        // fill(255, 25);
        if (myData[i][2].equals("BRONX")) {
          fill(fillBronx,markerAlpha);
        } else if (myData[i][2].equals( "MANHATTAN")) {
          fill(fillManhattan, markerAlpha);
        } else if (myData[i][2].equals( "BROOKLYN" ) ) {
          fill(fillBrooklyn, markerAlpha);
        } else if (myData[i][2].equals("QUEENS" )) {
          fill(fillQueens, markerAlpha);
        }  else if (myData[i][2].equals("STATEN ISLAND" )) {
          fill(fillStaten, markerAlpha);
        } 
        else
        {
          fill(fillOther, markerAlpha);
        }
        noStroke();
        ellipse(myDataMap[i][1], myDataMap[i][0], markerSize, markerSize);
        counter ++;
      }
    }

    hour++;
    if (hour == 24) {
      hour=0; 
      minutes =0;
    }
  }//end hour loop
}

