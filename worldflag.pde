JSONArray countries;
StringList allFlagColors; 

void setup(){
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
  
  println(allFlagColors);
 
 }
}