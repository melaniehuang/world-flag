import java.awt.Color;
JSONArray countries;
//Using ArrayLists of ArrayLists here because you can check equality
ArrayList<ArrayList<Integer>> colorList = new ArrayList<ArrayList<Integer>>();

void setup(){
  size(1200,800);
  background(0);
 
  countries = loadJSONArray("flagColors.json"); 
  
  for (int i = 0; i < countries.size(); i++) {    
    JSONObject country = countries.getJSONObject(i);      
    JSONArray colors = country.getJSONArray("colors"); 
    
    for (int c = 0; c < colors.size(); c++){
      JSONObject flagColor = colors.getJSONObject(c);
      String hex = flagColor.getString("hex");
      ArrayList<Integer> rgbColor = hextoRGB(hex);
    
      if (!colorList.contains(rgbColor)){
        float[] hsbCol = rgbtoHSB(rgbColor);
        println(hsbCol);
        colorList.add(rgbColor);
      }
    }
  }

  //println(colorList);

}

void draw() {
  noStroke();
  
  int rectHeight = height/colorList.size();
  
  for(int i = 0; i < colorList.size(); i++){
    fill(colorList.get(i).get(0),colorList.get(i).get(1),colorList.get(i).get(2));
    rect(0,i + i*rectHeight,width,rectHeight);
  }
}

ArrayList<Integer> hextoRGB (String countryColor){
  ArrayList<Integer> getHexColors = new ArrayList<Integer>();
  
  for (int i = 0; i < 3; i++){
    String cHex = countryColor.substring(i*2,2+(i*2));
    int c = unhex(cHex);
    getHexColors.add(c);    
  }
  
  return getHexColors;

}

float[] rgbtoHSB (ArrayList<Integer> rgbList){
  float[] hsbvals = new float[3];

  float[] convertColor = Color.RGBtoHSB(rgbList.get(0),rgbList.get(1),rgbList.get(2),hsbvals);
  convertColor[0]*=360;
  
  return convertColor;
}