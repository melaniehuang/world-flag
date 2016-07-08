//TO DO: Add white and black values

import java.awt.Color;
import java.util.*;

JSONArray countries;
//Using ArrayLists of ArrayLists here because you can check equality
ArrayList<ArrayList<Float>> colorList = new ArrayList<ArrayList<Float>>();
ArrayList<ArrayList<Float>> whiteList = new ArrayList<ArrayList<Float>>();
ArrayList<ArrayList<Float>> blackList = new ArrayList<ArrayList<Float>>();

int totalPercent = 0;

void setup() {
  size(1200, 1000);
  background(0);
  colorMode(HSB,360,1,1); 

  countries = loadJSONArray("flagColors.json"); 
  
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
      
      if (!colorList.contains(rgbColor) && percent > 10) {
        ArrayList<Float> hsbCol = rgbtoHSB(rgbColor);
        
        if (hsbCol.get(2) > 0.95) {
          whiteList.add(hsbCol); 
        } else if (hsbCol.get(2) < 0.05){
          blackList.add(hsbCol); 
        } else {
          
          if (hsbCol.get(0) >= 20 && hsbCol.get(0) < 80){
            yellowCounter++;
          } else if (hsbCol.get(0) >= 80 && hsbCol.get(0) < 170) {
            greenCounter++;
          } else if (hsbCol.get(0) >= 170 && hsbCol.get(0) < 290){
            blueCounter++; 
          } else {
            redCounter++;
          }
            
          hsbCol.add(percent);
          totalPercent = totalPercent + floor(percent);
          colorList.add(hsbCol); 
        }
      }
      
      if (colorList.size() > height){
        println("ERROR: Too many colors, make the canvas height taller");
      }
    }
  }

  Collections.sort(colorList, new Comparator<ArrayList<Float>>() {
    @Override
    public int compare(ArrayList<Float> a1, ArrayList<Float> a2) {
      return a1.get(0).compareTo(a2.get(0));
    }
  });
  
  //println("colors:" + colorList + " white:" + whiteList + " black:" + blackList);
  println("c.size:" +colorList.size() + " w.size:" + whiteList.size() + " b.size:" + blackList.size());
  println("r:" + redCounter + " y:" + yellowCounter + " g:" + greenCounter + " b:" + blueCounter);
  noLoop();
}

void draw() {
  noStroke();
  int rectTotal = 0;
  
  for (int i = 0; i < colorList.size(); i++) {   
    fill(colorList.get(i).get(0),colorList.get(i).get(1),colorList.get(i).get(2));
    
    float rectValue = ceil((colorList.get(i).get(3))/10);
    int rectHeight = int(rectValue/2);
    rectTotal = rectTotal + rectHeight;
      
    rect(0, i + i*(rectHeight), width, i + i*(rectHeight));
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
  hsbColor.add(hsbvals[0]);
  hsbColor.add(hsbvals[1]);
  hsbColor.add(hsbvals[2]);

  return hsbColor;
}