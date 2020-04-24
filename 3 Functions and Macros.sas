/*
Functions and Macros
*/

options macrogen symbolgen mprint mlogic;

/* Slide 9 */
%macro fisher_lsd(s_i, n_i, s_j, n_j, alpha=0.05);
  %let s2  = ((&n_i-1)*&s_i**2 + (&n_j-1)*&s_j**2) / ((&n_i-1)+(&n_j-1));
  %let critical_t = %sysfunc(quantile(T,1 - &alpha/2,&n_i+&n_j-2));
  %let lsd = %sysevalf(&critical_t*%sysfunc(sqrt(&s2*(1/&n_i + 1/&n_j))));
  &lsd;
%mend;

%let lsd_ij = %fisher_lsd(1050.0,18,1496.2,18);
%put &lsd_ij;

%let lsd_2 = %fisher_lsd(s_i=1050.0, s_j=1496.2, n_i=18, n_j=18);
%put &lsd_2;

/* Slide 25 */
%macro change_a();
  %let a = 2;
%mend;

%let a = 1;
%change_a();
%put &=a;

/* Slide 26 */
%macro change_a();
  %local a;
  %let a = 2;
%mend;

%let a = 1;
%change_a();
%put &=a;

/* IML function vs subroutine */
proc iml;
  a = 1;
  start change_a(new=2);
    a=new;
    return 0;
  finish;
  b=change_a();
  print(a);
quit;

proc iml;
  start change_a;
    a=2;
  finish;
  a = 1;
  call change_a;
  print(a);
quit;

/* Code Reuse */
/* include */
filename LSDMacro '/home/peterclaussen1/summer2018/library/fisherlsd.sas';
%include LSDMacro;
%let lsd_j = %fisherlsd(s_i=1050.0, n_i=18, s_j=1496.2, n_j=18);
%put %sysevalf(&lsd_j);

/* Autocall */
filename JoyLib '/home/peterclaussen1/summer2018/library/';
options mautosource SASAUTOS=(SASAUTOS JoyLib);

%let lsd_j = %fisherlsd(s_i=1050.0, n_i=18, s_j=1496.2, n_j=18);
%put %sysevalf(&lsd_j);

/* Compiled */
options mstored sasmstore=JoyLib;

%macro fisherlsdstored(s_i, n_i, s_j, n_j, alpha=0.05) / store;
  %let s2  = ((&n_i-1)*&s_i**2 + (&n_j-1)*&s_j**2) / ((&n_i-1)+(&n_j-1));
  %let critical_t = %sysfunc(quantile(T,1 - 0.05/2,&n_i+&n_j-2));
  %let lsd = &critical_t*%sysfunc(sqrt(&s2*(1/&n_i + 1/&n_j)));
  &lsd;
%mend;


options mstored sasmstore=JoyLib;
%let lsd_j = %fisherlsdstored(&s_i,&n_i,&s_j,&n_j);
%put %sysevalf(&lsd_j);
