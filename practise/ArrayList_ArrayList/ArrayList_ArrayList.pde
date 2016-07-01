void setup() {
  size(200, 200);
  ArrayList<ArrayList<Integer>> colors = new ArrayList<ArrayList<Integer>>();
  ArrayList<Integer> numbers1 = new ArrayList<Integer>();
  ArrayList<Integer> numbers2 = new ArrayList<Integer>();
  numbers1.add(2);
  numbers1.add(4);
  numbers1.add(34);
  numbers2.add(2);
  numbers2.add(4);
  numbers2.add(34);

  colors.add(numbers1);
  println(colors.contains(numbers2));
}