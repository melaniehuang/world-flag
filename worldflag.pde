JSONArray countries;
StringList allFlagColors; 

void setup(){
 size(1200,800);
 background(0);
 
 countries = loadJSONArray("flagColors.json");
 allFlagColors = new StringList(); 
  
 for (int i = 0; i < countries.size(); i++) {    
  JSONObject country = countries.getJSONObject(i);      
  JSONArray colors = country.getJSONArray("colors"); 
    
  for (int c = 0; c < colors.size(); c++){
   JSONObject flagColor = colors.getJSONObject(c);
   String hex = flagColor.getString("hex");
     
   if (!allFlagColors.hasValue(hex)) { 
    allFlagColors.append(hex);
   }  
  }
 }

 println(allFlagColors);
 //get all colors and convert them to rgb

}

void draw() {
  
}