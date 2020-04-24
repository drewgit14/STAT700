/* options macrogen symbolgen mprint mlogic; */

/*
 * General Instructions.
 * This file includes unit test code for Exercise 1 and 2. You can use
 * PROC IML or Macro language for either exercise, but you must choose exactly one
 * for each exercise.
 * 
 * There is also template code for Exercise 4.
 * 
 * Write your own code for the sections labelled 'Code Here'. Write code to compute
 * and assign values to pass the unit tests - do not change the hard-coded
 * numeric constants.
 * 
 * You must upload your SAS log to D2L to get credit for unit test points.
 */
%let unit_test_points = 0;

%macro fisher_lsd(s_i, n_i, s_j, n_j, alpha=0.05);
  %let s2  = ((&n_i-1)*&s_i**2 + (&n_j-1)*&s_j**2) / ((&n_i-1)+(&n_j-1));
  %let critical_t = %sysfunc(quantile(T,1 - &alpha/2,&n_i+&n_j-2));
  %let lsd = %sysevalf(&critical_t*%sysfunc(sqrt(&s2*(1/&n_i + 1/&n_j))));
  &lsd;
%mend;

title 'Exercise 1 (R and SAS, required)';
/*
Choose to use either Macro or IML, only one will be graded.
Unit tests are protected by comment blocks for these exercises;
move the comments to execute the unit tests for the code you wish
to be graded.

Be sure to upload the SAS log as well as results if you choose the Macro option.
*/

/* Exercise 1 Macro Code Here */
%let d_12 = 0;

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
  d_12 = 0;
  print(d_12);
  
  /* Exercise 1 unit test, IML code 
  if(abs(d_12-0.7181)<0.0001) then
    do;
      local_unit_test_points = &unit_test_points + 8;
      print(local_unit_test_points);
      call symput("unit_test_points", char(local_unit_test_points));
    end;
   else
    do;
      print 'd_12 is not assigned the correct value';
    end;
   */
quit;

title 'Exercise 2 (R or SAS, required)';
/*
Choose to use either Macro or IML, only one will be graded.
*/

%let l_1 = 0;
%let l_2 = 0;

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

  l_1 = 0;
  l_2 = 0;
  print(l_1);
  print(l_2);
 
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
/* Optional - see R Markdown  */

title 'Exercise 4. (R or SAS)';
/* Optional.
Write a macro to compute upper and lower bounds for a count mean, using
the formula in the R Markdown. Your macro should take `x` and `alpha` as
parameters, with `alpha` being optional and equal to 0.05.

Inside the macro, assign values to normal variables, not macro variables. 
Implement the formula as you would in PROC IML. Your macro should
compute the same values in both PROC IML and DATA code fragments below.

Compare your results to the values from the R function in the markdown 
document.
*/

/*
proc iml;
  %chi_ci(12);
  print(Lower);
  print(Upper);
  
  %chi_ci(13);
  print(Lower);
  print(Upper);
quit;

data counts;
  input x;
  %chi_ci(x);
  datalines;
  12
  13
run;

proc print data=counts;
run;
*/

title 'Exercise 5. (R or SAS)';
/* Optional - see R Markdown  */

/* Total points from unit tests */
title 'Unit Test Points';
%put 'Total points from unit tests' %eval(&unit_test_points);
proc iml;
  print(&unit_test_points); 
quit;