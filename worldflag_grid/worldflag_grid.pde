void setup(){
  background(255);
  size(1400,800);
  
  noStroke();
  noLoop();
}

void draw(){
  int borderSize = 55;
  
  int artWidth = width - borderSize*2;
  int artHeight = height - borderSize*2;
  int startX = borderSize;
  int startY = borderSize;
  
  fill(#FA5858);
  rect(startX,startY,artWidth/5*2,artHeight);
  startX = borderSize + artWidth/5*2;
  
  fill(#58EEFA);
  rect(startX,startY,artWidth/5,artHeight);
  startX = startX + (artWidth/5);
  
  fill(#B3FA58);
  rect(startX,startY,artWidth/5*2,artHeight/20*9);
  startY = borderSize + artHeight/20*9;
  
  fill(#FAD758);
  rect(startX,startY,artWidth/5*2,artHeight/20*7);
  startY = startY + artHeight/20*7;
  
  fill(0);
  rect(startX,startY,artWidth/5*2,artHeight-(artHeight/20*7)-(artHeight/20*9));
}