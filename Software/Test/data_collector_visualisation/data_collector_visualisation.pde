//import the required libraries
import processing.serial.*;
Serial mySerial;
Table table;
int score_vector[] = {0, 0, 0, 0};

PrintWriter output;

void setup()
{
  //set mySerial to listen on COM port 10 at 9600 baud
  mySerial = new Serial(this, "COM5", 57600);
  output = createWriter("data/table.csv");
  int data[] = {0,0,0,0};
}

void draw()
{
  if(mySerial.available() > 0)
  {
    //set the value recieved as a String
    String value = mySerial.readString();

    //check to make sure there is a value
    if(value != null)
    {
      print(value);
     
      score_vector[Integer.parseInt(value)]++;
      output.println(score_vector.toString());
      print(score_vector);
      output.flush();
    }
    
    
  }
}
