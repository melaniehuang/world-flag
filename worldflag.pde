import java.awt.Color;
import java.util.*;

JSONArray countries;
//Using ArrayLists of ArrayLists here because you can check equality
ArrayList<ArrayList<Float>> redList = new ArrayList<ArrayList<Float>>();
ArrayList<ArrayList<Float>> blueList = new ArrayList<ArrayList<Float>>();
ArrayList<ArrayList<Float>> yellowList = new ArrayList<ArrayList<Float>>();
ArrayList<ArrayList<Float>> greenList = new ArrayList<ArrayList<Float>>();
ArrayList<ArrayList<Float>> whiteList = new ArrayList<ArrayList<Float>>();
ArrayList<ArrayList<Float>> blackList = new ArrayList<ArrayList<Float>>();
ArrayList<ArrayList<Float>> allList = new ArrayList<ArrayList<Float>>();

int borderSize = 55;
int startX = borderSize;
int startY = borderSize;

void setup() {
  size(1400, 800);
  background(255);
  colorMode(HSB,360,1,1); 

  countries = loadJSONArray("flagColors.json"); 

  for (int i = 0; i < countries.size(); i++) {    
    JSONObject country = countries.getJSONObject(i);      
    JSONArray colors = country.getJSONArray("colors"); 

    for (int c = 0; c < colors.size(); c++) {
      JSONObject flagColor = colors.getJSONObject(c);
      String hex = flagColor.getString("hex");
      float percent = flagColor.getFloat("percent");
      
      ArrayList<Integer> rgbColor = hextoRGB(hex);
      
      if (percent > 10) {
        ArrayList<Float> hsbCol = rgbtoHSB(rgbColor);
        
        if (hsbCol.get(2) > 0.95 && hsbCol.get(1) < 0.10) {
          whiteList.add(hsbCol); 
        } else if (hsbCol.get(2) < 0.25){
          blackList.add(hsbCol); 
        } else {
          if (hsbCol.get(0) >= 23 && hsbCol.get(0) < 80){
            hsbCol.add(percent);
            yellowList.add(hsbCol);
          } else if (hsbCol.get(0) >= 80 && hsbCol.get(0) < 180) {
            hsbCol.add(percent);
            greenList.add(hsbCol);
          } else if (hsbCol.get(0) >= 180 && hsbCol.get(0) < 290){
            hsbCol.add(percent);
            blueList.add(hsbCol);
          } else {
            hsbCol.add(percent);
            redList.add(hsbCol);
          } 
        }

      }
    
    }
  }
  
  println("WHITE: " + whiteList.size() + " / BLACK: " + blackList.size() + " / RED: " + redList.size() + " / YELLOW: " + yellowList.size() + " / GREEN: " + greenList.size() + " / BLUE: " + blueList.size());
  noLoop();
}

void draw() {
  noStroke();
  
  int borderSize = 55;
  
  int artWidth = width - borderSize*2;
  int artHeight = height - borderSize*2;
  int startX = borderSize;
  int startY = borderSize;
  
  fill(#FA5858);
  rect(startX,startY,artWidth/5*2,artHeight);
  drawColor(redList,artWidth/5*2,startX,startY);

  startX = borderSize + artWidth/5*2;
  
  fill(#58EEFA);
  rect(startX,startY,artWidth/5,artHeight);  
  drawColor(blueList,artWidth/5,startX,startY);

  startX = startX + (artWidth/5);
  
  fill(#B3FA58);
  rect(startX,startY,artWidth/5*2,artHeight/20*9);
  drawColorHeight(greenList,artWidth/5*2,(artHeight/20*9)/greenList.size(),startX,startY);

  startY = borderSize + artHeight/20*9;
  
  fill(#FAD758);
  rect(startX,startY,artWidth/5*2,artHeight/20*7);
  drawColorHeight(yellowList,artWidth/5*2,(artHeight/20*7)/yellowList.size(),startX,startY);
  startY = startY + artHeight/20*7;
  
  fill(0);
  rect(startX,startY,artWidth/5*2,artHeight-(artHeight/20*7)-(artHeight/20*9));
  drawColorHeight(blackList,artWidth/5*2,(artHeight-(artHeight/20*7)-(artHeight/20*9))/blackList.size(),startX,startY);
}

float calcPercent(ArrayList<ArrayList<Float>> colorList){
  
  float percent = 0;
  
  for(int i = 0; i < colorList.size(); i++){
    float colorPercent = colorList.get(i).get(3);
    percent = percent + colorPercent;
  }
  
  return percent;
}

void drawColor(ArrayList<ArrayList<Float>> colorList, int colorWidth, int colorX, int colorY){
  for (int i = 0; i < colorList.size(); i++) { 
    int colorHeight = (height-borderSize*2)/colorList.size();
   
    fill(colorList.get(i).get(0),colorList.get(i).get(1),colorList.get(i).get(2)); 
    rect(colorX, colorY + colorHeight*i,colorWidth,colorHeight);
  }
}

void drawColorHeight(ArrayList<ArrayList<Float>> colorList, int colorWidth, int colorHeight, int colorX, int colorY){
  for (int i = 0; i < colorList.size(); i++) {  
    fill(colorList.get(i).get(0),colorList.get(i).get(1),colorList.get(i).get(2)); 
    rect(colorX, colorY + colorHeight*i,colorWidth,colorHeight);
  }
}


ArrayList<Integer> hextoRGB (String countryColor) {
  ArrayList<Integer> getHexColors = new ArrayList<Integer>();

  for (int i = 0; i < 3; i++) {
    String cHex = countryColor.substring(i*2, 2+(i*2));
    int c = unhex(cHex);
    getHexColors.add(c);
  }
  return getHexColors;
}

ArrayList<Float> rgbtoHSB (ArrayList<Integer> rgbList) {
  float[] hsbvals = new float[3];
  hsbvals = Color.RGBtoHSB(rgbList.get(0), rgbList.get(1), rgbList.get(2), hsbvals);
  hsbvals[0]*=360;

  ArrayList<Float> hsbColor = new ArrayList<Float>();
  for(int h = 0; h < 3; h++){
    hsbColor.add(hsbvals[h]);
  }
  return hsbColor;
}

void sortColorLists (ArrayList<ArrayList<Float>> colorType){
  Collections.sort(colorType, new Comparator<ArrayList<Float>>() {
    @Override
    public int compare(ArrayList<Float> a1, ArrayList<Float> a2) {
      return a1.get(0).compareTo(a2.get(0));
    }
  });
}