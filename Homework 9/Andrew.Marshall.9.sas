/*
\file
\ingroup	module group

\brief		brief description

			Exercise 1 from Assignment 9

\version	\$Revision: 1.0 $
\author		\$Author: Andrew Marshall $
\date		\$Date:	2018-07-27 $
*/

/* Exercise 1

Load the JoyOfCooking data set from lecture and create histograms, QQ-norm and box-whisker plots for calories per serving and servings per recipe. You can use data from either year. 
Add a title to each plot, identifying the data. */


/*File import to be used for data plots*/
title 'Assignment 9, Exercise 1';
filename JoyPath '/home/drewmars70/summer2018/JoyOfCookingSAS.csv';

/*Moving data from file to dataset*/
proc import datafile=JoyPath
  dbms=csv
  out=JoyOfCooking;
  getnames=yes;
run;


/*This section will present a histogram of the JoyOfCooking data (Calories Per Serving) that was recently imported.*/
title "Calories Per Serving 2006";
proc univariate data=JoyOfCooking;
	 var CaloriesPerServing2006;
     histogram CaloriesPerServing2006;
run;
/*This section will present a histogram of the JoyOfCooking data (Servings Per Recipe) that was recently imported.*/
title "Servings Per Recipe 2006";
proc univariate data=JoyOfCooking;
	 var ServingsPerRecipe2006;
 histogram ServingsPerRecipe2006;
run;

/*This section will present a QQ plot of the JoyOfCooking data (Calories Per Serving) that was recently imported.*/
title "Calories Per Serving 2006";
proc univariate data=JoyOfCooking;
	qqplot CaloriesPerServing2006;
run;

/*This section will present a QQ plot of the JoyOfCooking data (Servings Per Recipe) that was recently imported.*/
title "Servings Per Recipe 2006";
proc univariate data=JoyOfCooking;
	qqplot ServingsPerRecipe2006;
run;

/*This section will present a box-whisker plot of the JoyOfCooking data (Calories Per Serving) that was recently imported.*/
title "Calories Per Serving 2006";
proc sgplot data = JoyOfCooking;
	vbox CaloriesPerServing2006;
run;

/*This section will present a box-whisker plot of the JoyOfCooking data (Servings Per Recipe) that was recently imported.*/
title "Servings Per Recipe 2006";
proc sgplot data = JoyOfCooking;
	vbox ServingsPerRecipe2006;
run;


















