/**
\file
\ingroup	module group

\brief		brief description

			Exercise 1 for Homework assignment;

\version	\$Revision: 1.0 $
\author		\$Author: Andrew Marshall $
\date		\$Date:	2018-06-07 $


/* options macrogen symbolgen mprint mlogic; */

/*
 * General Instructions.
 * This file includes unit test code for Exercise 1 and 2. You can use
 * PROC IML or Macro language for either exercise, but you must choose exactly one
 * for each exercise.
 * 
 * Write your own code for the sections labelled 'Code Here'. Write code to compute
 * and assign values to pass the unit tests - do not change the hard-coded
 * numeric constants.
 * 
 * You must upload your SAS log to D2L to get credit for unit test points.
 */
%let unit_test_points = 0;

title 'Exercise 1 (R and SAS, required)';
/*
Calculate Cohen's $d$ for calories per recipe, calories per serving and 
servings per recipe, comparing years 1936 and 2006. Use the formula
$d = \frac{|m_1-m_2|}{\sqrt{(s_1^2 + s_2^2)/2}}$

Choose to use either Macro or IML, only one will be graded.
Unit tests are protected by comment blocks for these exercises;
move the comments to execute the unit tests for the code you wish
to be graded.

Be sure to upload the SAS log as well as results.
*/

/* Exercise 1 Macro Code Here */
%let d_12 = .;

/* Exercise 1 unit test, macro code 
%put %sysevalf(&d_12);
%let difference = %sysevalf(%sysfunc(abs(&d_12-0.7181)));

%if %sysevalf(&difference<0.0001) %then
  %do;
    %let unit_test_points = %eval(&unit_test_points+8);
  %end;
%else 
  %do;
    %put 'd is not assigned the correct value';
  %end;
 */

proc iml;
  /* Exercise 1 IML Code Here */
 /* Variable declarations and calculations for Calories per Recipe (CPR) */
  m_1 = 2123.8; 
  m_2 = 3051.9;
  s_1 = 1050.0;
  s_2 = 1496.2;
  d_12CPR = (abs(m_1-m_2)) / (sqrt((s_1**2 + s_2**2)/2));
  print(d_12CPR);
 
   /* Variable declarations and calculations for Calories per Serving (CPS)*/
  m_1 = 268.1; 
  m_2 = 285.6;
  s_1 = 124.8;
  s_2 = 118.3;
  d_12CPS = (abs(m_1-m_2)) / (sqrt((s_1**2 + s_2**2)/2));
  print(d_12CPS); 
  
   /* Variable declarations and calculations for Servings per Recipe(SPR) */
  m_1 = 12.9; 
  m_2 = 12.4;
  s_1 = 13.3;
  s_2 = 14.3;
  d_12SPR = (abs(m_1-m_2)) / (sqrt((s_1**2 + s_2**2)/2));
  print(d_12SPR);
 

   /*Exercise 1 unit test, IML code */
  if(abs(d_12CPR-0.7181)<0.0001) then
    do;
      local_unit_test_points = &unit_test_points + 8;
      print(local_unit_test_points);
      call symput("unit_test_points", char(local_unit_test_points));
    end;
   else
    do;
      print 'd_12 is not assigned the correct value';
    end;
    
   if(abs(d_12CPS-0.7181)<0.0001) then
    do;
      local_unit_test_points = &unit_test_points + 8;
      print(local_unit_test_points);
      call symput("unit_test_points", char(local_unit_test_points));
    end;
   else
    do;
      print 'd_12 is not assigned the correct value';
    end;
   
    if(abs(d_12SPR-0.7181)<0.0001) then
    do;
      local_unit_test_points = &unit_test_points + 8;
      print(local_unit_test_points);
      call symput("unit_test_points", char(local_unit_test_points));
    end;
   else
    do;
      print 'd_12 is not assigned the correct value';
    end;
    
quit;

title 'Exercise 2 (R or SAS, required)';
/*
The probablity of an observation $x$, when taken from a normal population with mean $\mu$ and variance $\sigma^2$ is calculated by
$$
L (x ; \mu, \sigma^2) = \frac{1}{\sigma \sqrt{2 \pi}^{}} e^{- \frac{(x - \mu)^2}{2 \sigma^2}}
$$

Choose to use either Macro or IML, only one will be graded.
*/

%let l_1 = .;
%let l_2 = .;

/* Exercise 2 unit test, macro code   
%let difference = %sysevalf(%sysfunc(abs(&l_1-0.396952)));

%if %sysevalf(&difference<1e-6) %then
  %do;
    %let unit_test_points = %eval(&unit_test_points+4);
  %end;
%else 
  %do;
    %put 'l_1 is not assigned the correct value';
  %end;
   
%let difference = %sysevalf(%sysfunc(abs(&l_2-0.391043)));

%if %sysevalf(&difference<1e-6) %then
  %do;
    %let unit_test_points = %eval(&unit_test_points+4);
  %end;
%else 
  %do;
    %put 'l_2 is not assigned the correct value';
  %end;
 */
 
proc iml;
   /* Exercise 2 IML Code Here */
  l_1 = .;
  l_2 = .;
 
/* Exercise 2 unit test, IML code 
  local_unit_test_points = &unit_test_points;
 
  if(abs(l_1-0.396952)<1e-6) then;
    do;
      local_unit_test_points = local_unit_test_points + 4;
      print(local_unit_test_points);
    end;
    
  if(abs(l_2-0.391043)<1e-6) then;
    do;
      local_unit_test_points = local_unit_test_points + 4;
      print(local_unit_test_points);
    end;

  call symput("unit_test_points", char(local_unit_test_points));
  */
quit;

title 'Exercise 3. (R or SAS)';
/* Optional - see R Markdown */
title 'Exercise 4. (R or SAS)';
/* Optional - see R Markdown  */
title 'Exercise 5. (R or SAS)';
/* Optional - see R Markdown  */

/* Total points from unit tests */
%put 'Total points from unit tests' %eval(&unit_test_points);