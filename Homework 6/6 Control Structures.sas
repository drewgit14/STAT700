/*
 Control Structures
*/

/* Slide 16 */
proc IML;
  if(1) then print('1 is true');
  if(2) then print('2 is also true');
  if(^0) then print('0 is false');
quit;

/* Slide 17 */
proc IML;
  if(1) then print('1 is true'); else print('1 is false');
quit;

proc IML;
  if(1) then print('1 is true') else print('1 is false');
quit;

/* Slide 18 */
proc IML;
  if(1) then print('1 is true'); 
  else print('1 is false');
quit;

/* Slide 19 */
proc IML;
  if(1) then do;
      print('1 is true');
    end; 
  else do;
      print('1 is false');
    end;
quit;

/* Slide 20 */
proc iml;
  if(1) then print('1 is true');
  if({1}) then print('{1} is true');
  if({1,0,0}) then print('{1,0,0} is true');
quit;

/* Slide 21 */
proc iml;
  a = normal(123);
  b = normal(312);
  print(a);
  print(b);
  bigger = ifn (a > b, a,b);
  print(bigger);
quit;

/* Slide 32 */
%web_drop_table(JoyOfCooking);
filename JoyFile '/home/peterclaussen1/summer2018/data/JoyOfCookingSAS.csv';

proc import datafile=JoyFile
  dbms=csv
  out=JoyOfCooking;
  getnames=yes;
run;

data JoyOfCooking;
  set JoyOfCooking;
  if(CaloriesperServing1936 ^= .) then output;
run;

proc iml;
  JoyTbl = TableCreateFromDataSet("JoyOfCooking"); 
  x = TableGetVarData(JoyTbl, {"CaloriesperServing1936"});
  k = nrow(x);
  sum_x = 0;
  do i = 1 to k; 
    sum_x = sum_x + x[i];
  end;
  bar_x = sum_x/k;
  
  ss_x = 0;
  do i = 1 to k; 
    ss_x = ss_x + (x[i]-bar_x)**2;
  end;
  s_x = ss_x/(k-1);
  
  print(sum_x);
  print(sum(x));
  
  print(bar_x);
  print(mean(x));
  
  print(sqrt(s_x));
  print(std(x));
quit;

/* Slide 42 */
%web_drop_table(JoyOfCooking);
filename JoyFile '/home/peterclaussen1/summer2018/data/JoyOfCookingSAS.csv';

proc import datafile=JoyFile
  dbms=csv
  out=JoyOfCooking;
  getnames=yes;
run;

proc iml;
  JoyTbl = TableCreateFromDataSet("JoyOfCooking"); 
  x = TableGetVarData(JoyTbl, {"CaloriesperServing1936"});
  rows = nrow(x);
  sum_x = 0;
  k = 0;
  do i = 1 to rows;
    if(x[i] ^= .) then do;
        sum_x = sum_x + x[i];
        k = k+1;
      end;
  end;
  bar_x = sum_x/k;
  
  print(bar_x);
  print(mean(x));

quit;

options macrogen symbolgen mprint mlogic;

/* Good recursive macro */
%macro FactMacro(n);
  %if &n<2 %then
    1;
  %else
    &n*%FactMacro(%eval(&n-1));
%mend;

%let fac5 = %FactMacro(5);
%put Factorial 5 = %eval(&fac5);

/* Bad recursive macro */
%macro FactMacro(n);
  %if &n<2 %then
    1;
  %else
    &n*%FactMacro(&n-1);
%mend;

%let fac5 = %FactMacro(5);
%put Factorial 5 = %eval(&fac5);
