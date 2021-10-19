float Scale = 0.01;    //how noisy the mountains are (1 is really noisy, 0.01 is about good)
int YSpacing = 5;      //gap between lines
int Radius = 500;      //radius of circle
int CentreX = 1920/2;  //centre of circle
int CentreY = 1080/2;  //centre of circle
int Height = 300;      //base "height" of mountain
int XBorder = 500;     //border sizes
int YBorder = 100;
boolean Transparent = false; //if mountains are transparent

color SquareColour = color(255);
color LinesColour = color(255);

//main
void setup(){
  size(1920, 1080);
  background(0);
  drawMountain();
  noFill();
  strokeWeight(3);
  stroke(SquareColour);
  rect(XBorder-20, YBorder-20, width-2*XBorder+40, height-2*YBorder+40);
  save("CircleMountains.png");
};

//does pythagorus to find distance from centre
float GetDistance(int x, int y){
  float Distance = sqrt(abs(x-CentreX)*abs(x-CentreX) + abs(y-CentreY)*abs(y-CentreY));
  return(Distance);
};

//fade in fade out function
float Fade(float x){
  return(x*x*x*(x*(x * 6 - 15) + 10));
};


void drawMountain(){
  fill(0);
  strokeWeight(1);
  
  //for each line
  for(int y = YBorder; y<height-YBorder; y=y+YSpacing){
    stroke(LinesColour);
    if(Transparent == false){
      beginShape();
    };
    
    //for each vertex on the line
    for(int x=XBorder; x<width-XBorder; x++){
      
      float Value = noise(x*Scale, y*Scale);
      float DistanceValue = Fade((1-(GetDistance(x, y)/Radius)));
      DistanceValue=DistanceValue>0?DistanceValue:0;
      int YHeight = int((y-(Value*Height*DistanceValue)));
      
      if(Transparent == true){
        set(x, YHeight, 255);
      }else{
      vertex(x, YHeight);
      };
      
    };
    
    if(Transparent == false){
      vertex(width-XBorder, height-YBorder);
      vertex(XBorder, height-YBorder);
      endShape(CLOSE);
    };
    
  };
};
