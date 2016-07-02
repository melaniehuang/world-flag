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
      ArrayList<Integer> rgbColor = convertColor(hex);
    
      if (!colorList.contains(rgbColor)){
        colorList.add(rgbColor);
      }
    }
  }

  println(colorList.get(3));

}

void draw() {
}

ArrayList<Integer> convertColor (String countryColor){
  ArrayList<Integer> getHexColors = new ArrayList<Integer>();
  
  for (int i = 0; i < 3; i++){
    String cHex = countryColor.substring(i*2,2+(i*2));
    int c = unhex(cHex);
    getHexColors.add(c);    
  }
  
  return getHexColors;

}