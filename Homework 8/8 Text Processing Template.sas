/* options macrogen symbolgen mprint mlogic; */

/*
 * General Instructions.
 * There are not unit tests for this exercise. This file defines the data
 * you will need for this homework, except where you will be importing data.
 * 
 * You can delete the data for exercises you do not attempt in SAS.
 */


title 'Exercise 1';
/* Optional - see R Markdown  */
%let CaloriesPerRecipeMean = 2123.8 2122.3 2089.9 2250.0 2234.2 2249.6 3051.9;
%let CaloriesPerRecipeSD = 1050.0 1002.3 1009.6 1078.6 1089.2 1094.8 1496.2;
%let Year = 1936 1946 1951 1963 1975 1997 2006;


title 'Exercise 2';
/* Optional - see R Markdown  */

%let Means = 268.1 271.1 280.9 294.7 285.6 288.6 384.4;
%let StandardDeviations = 124.8 124.2 116.2 117.7 118.3 122.0 168.3;
%let SampleSizes 18 18 18 18 18 18 18;

title 'Exercise 3';
/* Optional - see R Markdown  */

%let TableRow = calories per serving (SD) | 268.1 (124.8) | 271.1 (124.2) | 280.9 (116.2)  | 294.7 (117.7) | 285.6 (118.3) | 288.6 (122.0) | 384.4 (168.3);

data ParseRow;
  TableRow = 'calories per serving (SD) | 268.1 (124.8) | 271.1 (124.2) | 280.9 (116.2)  | 294.7 (117.7) | 285.6 (118.3) | 288.6 (122.0) | 384.4 (168.3)';
  TableRow = '1936 | 1946 | 1951 | 1963 | 1975 | 1997 | 2006';
  /* Tokenize TableRow */
  datalines;
run;

/*
%let n = 18;
%let alpha = 0.05;

%macro StandardError(sigma, n);
  &sigma/sqrt(&n);
%mend;

%macro ConfidenceInterval(sigma, n);
  quantile('T',1-&alpha/2,9999)*%StandardError(&sigma,&n);
%mend;

data PlotCookingTooMuch;
  set CookingTooMuch;
  CaloriesPerServing = CaloriesPerServingMean;
  Lower = CaloriesPerRecipe-%ConfidenceInterval(CaloriesPerServingSD,&n);
  Upper = CaloriesPerRecipe+%ConfidenceInterval(CaloriesPerServingSD,&n);
  keep Year CaloriesPerRecipe Lower Upper;
run;

proc sgplot data=PlotCookingTooMuch noautolegend;                                                                                                  
   scatter x=Year y=CaloriesPerRecipe / yerrorlower=Lower                                                                                            
                           yerrorupper=Upper                                                                                            
                           markerattrs=(color=blue symbol=CircleFilled);                                                                
   series x=Year y=CaloriesPerRecipe / lineattrs=(color=blue pattern=2); 
   yaxis label= "Calories";
   title1 'Calories per Recipe';                                                                   
run; 
*/

title 'Exercise 4';
/* Optional - see R Markdown  */

title 'Exercise 5';
/* Optional - see R Markdown  */

title 'Exercise 6';
/* Optional - see R Markdown  */

/* Change memname to that of the imported table */
proc sql;
  select name into :name1-:name7 from dictionary.columns
  where libname = 'WORK' and memname = 'FASTEST';
quit;

%global GLMModel;

/*
proc glm data=FASTEST;
  class Engine;
  model &GLMModel;
run;
*/