/* 
 * Section 2. Basic Calculations in SAS
 */

/* Slide 4 */
proc iml;
  s_i = 1078.6; s_j = 1496.2;
quit;

proc iml;
  s_i = 1078.6; s_j = 1496.2
quit;

/* Slide 8 */
proc iml;
  s_i = 1078.6;
  print(s_i);
  print(s_j);
quit;


/* Slide 14 */
data numbers;
  m_i = 2123.8;
  m_j = 3.0519e3;
  n_i = 18;
  year = "Year";
  bool = 0;
run;

proc contents data=numbers out=numberTypes;
run;

proc print data=numberTypes;
run;

/* Slide 16 */
proc iml;
  print(constant("pi"));
  print(CONSTANT('BIG'));
  print(CONSTANT('MACEPS'));
quit;

proc print data=numbers;
  format real_value integer_value scientific1 scientific2 12.9;
run;

/* Slide 18 */
proc iml;
  print(sqrt(-1));
  print(1/0);
quit;

/* Slide 36 */
options macrogen symbolgen mprint mlogic;
%let s_i = 1050.0;
%let s_j = 1496.2;
%let n_i = 18;
%let n_j = %eval(&n_i);
%let s2  = ((&n_i-1)*&s_i**2 + (&n_j-1)*&s_j**2) / ((&n_i-1)+(&n_j-1));
%put %sysevalf(&s2);


