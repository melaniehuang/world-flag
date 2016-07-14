//TO DO: Add white and black values

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

int totalPercent = 0;

void setup() {
  size(1200, 864);
  background(50);
  colorMode(HSB,360,1,1); 

  countries = loadJSONArray("flagColors.json"); 
  
  int whiteCounter = 0;
  int blackCounter = 0;
  int redCounter = 0;
  int yellowCounter = 0;
  int blueCounter = 0;
  int greenCounter = 0;

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
        
        if (hsbCol.get(2) > 0.95 && hsbCol.get(1) < 0.05) {
          whiteCounter++;
          whiteList.add(hsbCol); 
        } else if (hsbCol.get(2) < 0.30){
          blackCounter++;
          blackList.add(hsbCol); 
        } else {
          if (hsbCol.get(0) >= 20 && hsbCol.get(0) < 80){
            yellowCounter++;
            hsbCol.add(percent);
            yellowList.add(hsbCol);
          } else if (hsbCol.get(0) >= 80 && hsbCol.get(0) < 170) {
            greenCounter++;
            hsbCol.add(percent);
            greenList.add(hsbCol);
          } else if (hsbCol.get(0) >= 170 && hsbCol.get(0) < 290){
            blueCounter++;
            hsbCol.add(percent);
            blueList.add(hsbCol);
          } else {
            redCounter++;
            hsbCol.add(percent);
            redList.add(hsbCol);
          } 
        }
      
      }
    
    }
  }
  
  //sortColorLists(redList);
  
  println("WHITE: " + whiteList.size() + " / BLACK: " + blackList.size() + " / RED: " + redList.size() + " / YELLOW: " + yellowList.size() + " / GREEN: " + greenList.size() + " / BLUE: " + blueList.size());

  noLoop();
}

void draw() {
  //noStroke();
  //int rectTotal = 0;
  
  //for (int i = 0; i < colorList.size(); i++) {   
  //  fill(colorList.get(i).get(0),colorList.get(i).get(1),colorList.get(i).get(2));
    
  //  float rectValue = ceil((colorList.get(i).get(3))/5);
  //  int rectHeight = int(rectValue/2);
  //  rectTotal = rectTotal + rectHeight;
      
  //  rect(0, 3*i, width, 3);  
  //}
  
  //fill(255);
  //rect(0, 3*colorList.size(), width, 3);
  //fill(0);
  //rect(0, 3*colorList.size() + 3, width, 3);
  
  //println(rectTotal);
  //println(countries.size());
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