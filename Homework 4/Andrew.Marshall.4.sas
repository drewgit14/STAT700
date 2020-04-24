/**
\file
\ingroup	module group

\brief		brief description

			Exercise 1 for homework assignment 4;

\version	\$Revision: 1.0 $
\author		\$Author: Andrew Marshall $
\date		\$Date:	2018-06-19 $

/* options macrogen symbolgen mprint mlogic; */

/*
 * General Instructions.
 * This file includes unit test code for Exercise 1 and 2. It's
 * not practical to code these exercises in macro language, so I'm
 * including only the IML unit tests.
 * 
 * The same restrictions apply to IML as stated in the R markdown. 
 * Use the macro below to declare data and constants in the appropriate
 * IML blocks. I've created one block in this template, but you can divide
 * into smaller blocks if you wish.
 * 
 * 
 */
%let unit_test_points = 0;

%macro Homework4Data;
  Year = {1936 1946 1951 1963 1975 1997 2006};
  CaloriesPerRecipeMean = {2123.8 2122.3 2089.9 2250.0 2234.2 2249.6 3051.9};
  CaloriesPerRecipeSD = {1050.0 1002.3 1009.6 1078.6 1089.2 1094.8 1496.2};
  CaloriesPerServingMean = {268.1 271.1 280.9 294.7 285.6 288.6 384.4};

  CaloriesPerServingSD = {124.8 124.2 116.2 117.7 118.3 122.0 168.3};
  ServingsPerRecipeMean = {12.9 12.9 13.0 12.7 12.4 12.4 12.7};
  ServingsPerRecipeSD = {13.3 13.3 14.5 14.6 14.3 14.3 13.0};
  sample_size = 18;
  tenth_increment = 0.10;
  hundredth_increment = 0.100;
  idx_1936 = 1;
  idx_2006 = dimension(CaloriesPerRecipeMean)[2];
  idxs36_07 = {idx_1936, idx_2006};
  alpha=0.05;
%mend;

proc iml;
  %Homework4Data;
  
title 'Exercise 1';
/* Optional - see R Markdown  */
 
  /* Exercise 1 IML Code Here */
    
   /*
   Secondary matrix for Calories per Recipe Mean values; m_2
   */
  m_2 = CaloriesPerRecipeMean//CaloriesPerRecipeMean//CaloriesPerRecipeMean//CaloriesPerRecipeMean
  //CaloriesPerRecipeMean//CaloriesPerRecipeMean//CaloriesPerRecipeMean;
  print(m_2);
    
   /*
  Primary matrix for Calories per Recipe Mean values (transposed matrix m_2); m_1
   */
  m_1 = m_2`;
  print(m_1);
 
  /*
  Secondary matrix for Calories per Recipe Standard Deviation values; s_2
   */
  
  s_2 = CaloriesPerRecipeSD//CaloriesPerRecipeSD//CaloriesPerRecipeSD//CaloriesPerRecipeSD
  //CaloriesPerRecipeSD//CaloriesPerRecipeSD//CaloriesPerRecipeSD;
  print(s_2);
  
  /*
  Primary matrix for Calories per Recipe Standard Deviation values (transposed s_2); s_1
   */
  s_1 = s_2`;
  print(s_1);
    
  /*
   Cohen's d function for use with newly created matrices m_1,m_2,s_1,s_2
   */
  d_12 = 0;
  start d_12CPR(m_1,m_2,s_1,s_2);
  d_12_var = (abs(m_1-m_2)) / (sqrt((s_1##2 + s_2##2)/2));
  return(d_12_var);
  finish d_12CPR;
  dmat = d_12CPR(m_1,m_2,s_1,s_2);
  d_12 = max(dmat[idx_1936,idx_2006]); 
  print(d_12);
  
   
  /*Exercise 1 unit test, IML code */
  
  if(abs(d_12-0.7181)<0.0001) then
    do;
      local_unit_test_points = &unit_test_points + 4;
      print(local_unit_test_points);
      call symput("unit_test_points", char(local_unit_test_points));
    end;
   else
    do;
      print 'd_12 is not assigned the correct value';
    end;
  
title 'Exercise 2';
/* Optional - see R Markdown  */

   /* Exercise 2 IML Code Here 

  l_1 = 0;
  l_2 = 0;
  print(l_1);
  print(l_2);
  */
  /* Exercise 2 unit test, IML code 

  local_unit_test_points = &unit_test_points;
 
  if(abs(l_1-0.396952)<1e-6) then;
    do;
      local_unit_test_points = local_unit_test_points + 2;
      print(local_unit_test_points);
    end;
    
  if(abs(l_2-0.391043)<1e-6) then;
    do;
      local_unit_test_points = local_unit_test_points + 2;
      print(local_unit_test_points);
    end;

  call symput("unit_test_points", char(local_unit_test_points));
  */

title 'Exercise 3';
/* Optional - see R Markdown  */

  /* Create a data set for comparison with proc GLM;
   Uncommented this block and the proc reg block below
   if you choose this exercise
   create Ex4Data var {CaloriesPerRecipeMean CaloriesPerServingMean};
   append;      
   close Ex4Data;
*/
title 'Exercise 4';
/* Optional - see R Markdown  */

title 'Exercise 5';
/* Optional - see R Markdown  */

title 'Exercise 6';
/* Optional - see R Markdown  */

/* Total points from unit tests */
title 'Unit Test Points';
  print(&unit_test_points); 
quit;

/*
Run this code if you selected exercise 4

proc reg data = Ex4Data plots=none;
  model CaloriesPerRecipeMean = CaloriesPerServingMean;
run;
*/