//import the required libraries
import processing.serial.*;
Serial mySerial;
PImage bg;
Table table;
int score_vector[] = {0, 0, 0, 0};
int CONTESTANTS = 4;
int WIDTH = 1920;
int HEIGHT = 1080;
int GAP = 50;

PrintWriter output;

void print_score_vector() {
  print('^');
  println();
  for (int i = 0; i<CONTESTANTS; i++) {
    print(score_vector[i]);
    println();
  }
  print('v');
  println();
}

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
  
  for (int i = 1; i <= CONTESTANTS; i++) {
    float delta = 1.0*(WIDTH - (CONTESTANTS + 1)*GAP)/CONTESTANTS;
    println(HEIGHT - (CONTESTANTS + 1)*GAP);
    rect(i*GAP + (i-1)*delta, HEIGHT - 30*vector[i-1], delta, 30*vector[i-1]);
    
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
      
      background(bg);
      draw_bars(score_vector);
      println("updated");
    }
    
    
  }
}
