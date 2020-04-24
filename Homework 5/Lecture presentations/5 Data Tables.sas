/*
  Data Tables
*/

/* Slide 11 */
data CookingTooMuch;
input Year CaloriesPerRecipeMean CaloriesPerRecipeSD;
datalines;
1936 2123.8 1050.0
1946 2122.3 1002.3
1951 2089.9 1009.6
1963 2250.0 1078.6
1975 2234.2 1089.2
1997 2249.6 1094.8
2006 3051.9 1496.2
run;

/* Slide 15 */
data CookingTooMuch;
input Year Mean SD;
  Lower = Mean-SD;
  Upper = Mean+SD;
datalines;
1936 2123.8 1050.0
1946 2122.3 1002.3
1951 2089.9 1009.6
1963 2250.0 1078.6
1975 2234.2 1089.2
1997 2249.6 1094.8
2006 3051.9 1496.2
run;



/* Slide 16 */
data CookingTooMuch;
input Year Mean SD @@;
  Lower = Mean-SD;
  Upper = Mean+SD;
datalines;
1936 2123.8 1050.0 1946 2122.3 1002.3 1951 2089.9 1009.6 1963 2250.0 1078.6
1975 2234.2 1089.2 1997 2249.6 1094.8 2006 3051.9 1496.2
run;

/* Slide 20 */
%web_drop_table(JoyOfCooking);
filename JoyFile '/home/peterclaussen1/summer2018/data/JoyOfCookingSAS.csv';

proc import datafile=JoyFile
  dbms=csv
  out=JoyOfCooking;
  getnames=yes;
run;

data JoyOfCooking;
  set JoyOfCooking;
  TotalCalories1936 = ServingsperRecipe1936*CaloriesperServing1936;
  TotalCalories2006 = ServingsperRecipe2006*CaloriesperServing2006;
run;


data CookingTooMuch;
input Year CaloriesPerRecipeMean CaloriesPerRecipeSD CaloriesPerServingMean CaloriesPerServingSD ServingsPerRecipeMean ServingsPerRecipeSD;
datalines;
1936 2123.8 1050.0 268.1 124.8 12.9 13.3
1946 2122.3 1002.3 271.1 124.2 12.9 13.3
1951 2089.9 1009.6 280.9 116.2 13.0 14.5
1963 2250.0 1078.6 294.7 117.7 12.7 14.6
1975 2234.2 1089.2 285.6 118.3 12.4 14.3
1997 2249.6 1094.8 288.6 122.0 12.4 14.3
2006 3051.9 1496.2 384.4 168.3 12.7 13.0
run;

/* Slide 24 */
proc print data=CookingTooMuch;
  var Year;
run;


/* Slide 25 */
data CookingTooMuchYear;
  set CookingTooMuch;
  keep Year;
run;

proc print data=CookingTooMuchYear;
run;

/* Slide 26 */
data CookingTooMuchNoYear;
  set CookingTooMuch;
  drop Year;
run;

proc print data=CookingTooMuchNoYear;
run;

/* Slide 35 */
data CookingTooMuchYears;
  set CookingTooMuch(firstobs=2 obs=3);
run;

proc print data=CookingTooMuchYears;
run;

data CookingTooMuchYears;
  set CookingTooMuch(firstobs=2 obs=3);
run;

proc print data=CookingTooMuchYears;
run;

/* Slide 37 */
proc print data=CookingTooMuch(firstobs=4 obs=4);
  var Year;
run;

/* Slide 44 */
proc means data=JoyOfCooking print;
  var ServingsperRecipe1936 TotalCalories1936;
run;

proc freq data=JoyOfCooking;
  table Class TooMuch;
run;

/* Slide 47 */
proc summary data=JoyOfCooking print;
  class ServingsperRecipe1936;
  var TotalCalories1936;
run;

/* Slide 51 */
proc freq data=JoyOfCooking;
   tables ServingsperRecipe1936*ServingsperRecipe2006;
run;

title 'Continuous vs Continuous';
proc sgplot data=JoyOfCooking;
  scatter x=ServingsperRecipe1936 y=ServingsperRecipe2006;
run;

title 'Continuous vs Categorical';
proc sgplot data=JoyOfCooking;
  vbox ServingsperRecipe2006 / category=ServingsperRecipe1936;
run;

title 'Categorical vs Categorical';
proc freq data=JoyOfCooking;
  tables ServingsperRecipe2006*ServingsperRecipe1936 / plots=MOSAIC;
run;


ods listing close;