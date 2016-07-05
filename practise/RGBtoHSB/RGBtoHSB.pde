import java.awt.Color;
size(300,300);

ArrayList<int[]> rgbList = new ArrayList<int[]>();
int[] rgbColor = {35, 24, 218};
rgbList.add(rgbColor);

float[] hsbvals = new float[3];

float[] convertColor = Color.RGBtoHSB(rgbList.get(0)[0],rgbList.get(0)[1],rgbList.get(0)[2],hsbvals);
convertColor[0]*=360;

println(convertColor);