//import the required libraries
import processing.serial.*;

Serial mySerial;
PImage bg;
Table table;
int score_vector[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
int CONTESTANTS = 10;
int WIDTH = 1920;
int HEIGHT = 1080;
int GAP = 50;
int AMPLITUDE = 800;
String name = "";

PrintWriter output;


void setup()
{ 
  //set mySerial to listen on COM port 10 at 9600 baud
  mySerial = new Serial(this, "COM5", 57600);
  output = createWriter("data/table.csv");
  size(1920, 1080);
  background(1);
  
  bg = loadImage("background.jpg");
}

void draw_bars(int[] vector) {
  
  float magnitude = sqrt(pow(vector[0],2) + pow(vector[1],2) + pow(vector[2],2) + pow(vector[3],2) + pow(vector[4],2) + pow(vector[5],2) + pow(vector[6],2) + pow(vector[7],2) + pow(vector[8],2) + pow(vector[9],2) );
  
  for (int i = 1; i <= CONTESTANTS; i++) {
    float delta = 1.0*(WIDTH - (CONTESTANTS + 1)*GAP)/CONTESTANTS;
    //println(HEIGHT - (CONTESTANTS + 1)*GAP);
    float height_norm = (float)((float)vector[i-1])/magnitude;
    int height = (int)((float)AMPLITUDE*height_norm);
    rect(i*GAP + (i-1)*delta, HEIGHT - height, delta, height);
    textSize(16);
    String name = "";
    print(i);
    
    if (i == 1) {
      name = "FOS Wondelgem";
    }
    if (i == 2) {
      name = "Chiro Sjaloom";
    }
    if (i == 3) {
      name = "EEVOC";
    }
    if (i == 4) {
      name = "Chiro Magneet";
    }
    if (i == 5) {
      name = "VZW Spees";
    }
    if (i == 6) {
      name = "KLJ SML";
    }
    if (i == 7) {
      name = "Scouts Ardu";
    }
    if (i == 8) {
      name = "Scouts Wondelgem";
    }
    if (i == 9) {
      name = "Chiro Sleidinge";
    }
    if (i == 10) {
      name = "Scouts Lievegem";
    }
    print(name);
    
    text(name, i*GAP + (i-1)*delta, HEIGHT - height); 
    
    
  } 
  
}

void draw() {
  
  
  if(mySerial.available() > 0) {
    //set the value recieved as a String
    String value_raw = mySerial.readString();
    int value = Integer.parseInt(value_raw);

    //check to make sure there is a value
    if((value_raw != null) && 0 <= value && value < CONTESTANTS) {
      score_vector[value]++;
      //print_score_vector();
      output.flush();
      
      print(value);
      
      background(bg);
      draw_bars(score_vector);
      //println("updated");
    }
    
    
  }
}
