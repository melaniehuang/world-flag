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
ArrayList<ArrayList<Float>> allList = new ArrayList<ArrayList<Float>>();

int totalPercent = 0;

void setup() {
  size(1200, 864);
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
        
        if (hsbCol.get(2) > 0.95 && hsbCol.get(1) < 0.05) {
          whiteList.add(hsbCol); 
        } else if (hsbCol.get(2) < 0.30){
          blackList.add(hsbCol); 
        } else {
          if (hsbCol.get(0) >= 20 && hsbCol.get(0) < 80){
            hsbCol.add(percent);
            yellowList.add(hsbCol);
          } else if (hsbCol.get(0) >= 80 && hsbCol.get(0) < 170) {
            hsbCol.add(percent);
            greenList.add(hsbCol);
          } else if (hsbCol.get(0) >= 170 && hsbCol.get(0) < 290){
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
  
  int totalSize = whiteList.size() + blackList.size() + redList.size() + yellowList.size() + greenList.size() + blueList.size();
  println(totalSize);
  
  for (int i = 0; i < redList.size(); i++) { 
   int redHeight = height/redList.size();
   
   fill(redList.get(i).get(0),redList.get(i).get(1),redList.get(i).get(2)); 
   rect(0,redHeight*i,100,redHeight);
  }
  
  for (int i = 0; i < blueList.size(); i++) { 
   int blueHeight = height/blueList.size();
   fill(blueList.get(i).get(0),blueList.get(i).get(1),blueList.get(i).get(2)); 
   rect(100,blueHeight*i,100,blueHeight);
  }
  
  for (int i = 0; i < greenList.size(); i++) { 
   fill(greenList.get(i).get(0),greenList.get(i).get(1),greenList.get(i).get(2)); 
   rect(200,4*i,100,4);
  }
  
  for (int i = 0; i < yellowList.size(); i++) { 
   fill(yellowList.get(i).get(0),yellowList.get(i).get(1),yellowList.get(i).get(2)); 
   rect(300,4*i,100,4);
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