ods listing file='/home/peterclaussen1/summer2018/presentations/presentation8.txt';

/*
Processing Text
*/

/* Slide 5 */
proc iml;
 RecipeName = 'Baked Apples Stuffed with Sausage';
 print(length(RecipeName));
 print(RecipeName[2]);
quit;

/* Slide 13 */
data BeefStroganoff1997;
input Amount Measure $ 5-7 Ingredient $ 9-50;
datalines;
1.5 lb  beef roast, tenderloin, raw, 0" trim
3.5 Tbs butter, salted
1.0 Tbs flour, all purpose, self rising, enriched
1.0 cup stock, beef, prepared from recipe
3.0 Tbs sour cream, cultured
1.0 tsp mustard, dijon
run;

data BeefStroganoff2006;
input Amount Measure $ 5-7 Ingredient $ 9-50;
datalines;
2   lb  beef roast, tenderloin, raw, 0" trim
2   Tbs oil, canola
3   Tbs butter, salted
1   ea  onion, yellow, fresh, medium, 2 1/2"
1   lb  mushrooms, fresh
1   cup stock, beef, prepared from recipe
3   cup sour cream, cultured
1   Tbs mustard, dijon
run;

proc print data=BeefStroganoff1997;
run;

/* Slide 14 */
proc iml;
  Ingredient = {'beef roast, tenderloin, raw, 0" trim',
                'butter, salted',
                'flour, all purpose, self rising, enriched',
                'stock, beef, prepared from recipe',
                'sour cream, cultured',
                'mustard, dijon'};
  do i = 1 to 6;
  current = Ingredient[i,1];
    print(nleng(current))[label=current];
  end;
quit;

/* Slide 26 */
proc iml;
 RecipeName = "Baked Apples Stuffed with Sausage";
 print(substr(RecipeName, 2, 4));
 print(substr(RecipeName, 2, 1));
quit;

/* Slide 27 */
%let RecipeName = Baked Apples Stuffed with Sausage;
%put %substr(&RecipeName, 2, 4);

%let RecipeName = "Baked Apples Stuffed with Sausage";
%put %substr(&RecipeName, 2, 4);

%let RecipeName = 'Baked Apples Stuffed with Sausage';
%put %substr(&RecipeName, 2, 4);

/* Slide 28 */
/* Bad 
%let BeefRoast = beef roast, tenderloin, raw, 0" trim;
%put &BeefRoast;
*/

/* Good */
%let BeefRoast = %Str(beef roast, tenderloin, raw, 0%" trim);
%put &BeefRoast;

/* Slide 39 */
proc iml;
  print('Apples' = 'Oranges');

  print('Apples' = 'apples');
  print(lowcase('Apples') = lowcase('apples'));
quit;


/* Slide 40 */
%put Apples = Apples;
%put %eval(Apples=Apples);
%put %eval(Apples = Apples);
%put %eval(Apples = Oranges);
%put %eval(Apples = apples);
%put %eval(%lowcase(Apples) = %lowcase(apples));

/* Slide 42 */
proc iml;
  print('apples' < 'baked');
  print('apples' < 'Baked');
  print('apples' < 'Apples');
  print('apples' > 'Apples');
quit;

/* Slide 53 */
data Flour;
  input Description $ 1-50;
  NumAdjectives = countw(Description, ','); 
  do i = 1 to NumAdjectives; 
    Adjective = trim(scan(Description, i, ','));
    output;
  end;
  drop i NumAdjectives Description;
  datalines;
flour, all purpose, self rising, enriched
run;

/* Slide 54 */
options macrogen symbolgen mprint mlogic;
data Flour;
  input Description $ 1-50;
  i=1;
  do while (trim(scan(Description, i, ',')) ne ''); 
    Adjective = trim(scan(Description, i, ','));
    output;
    i=i+1;
  end;
  drop i Description;
  datalines;
flour, all purpose, self rising, enriched
run;


/* Slide 55 */
data BeefStroganoff2006;
  input Amount Measure $ 5-7 IngredientDescription $ 9-50;
  Ingredient = scan(IngredientDescription, 1, ',');
  NumAdjectives = countw(IngredientDescription, ','); 
  do i = 2 to NumAdjectives; 
    Descriptor = trim(scan(IngredientDescription, i, ','));
    output;
  end;
  drop i NumAdjectives Amount Measure IngredientDescription;
  datalines;
2   lb  beef roast, tenderloin, raw, 0" trim
2   Tbs oil, canola
3   Tbs butter, salted
1   ea  onion, yellow, fresh, medium, 2 1/2"
1   lb  mushrooms, fresh
1   cup stock, beef, prepared from recipe
3   cup sour cream, cultured
1   Tbs mustard, dijon
run;


/* Slide 56 */
%let RecipeName = Baked Apples Stuffed with Sausage;

%macro CountWords(WordList);
  %local i NextWord;
  %let i=1;
  %do %while (%scan(&WordList, &i) ne );
    %let NextWord = %scan(&WordList, &i);
    %let i = %eval(&i + 1);
  %end;
  /* The ith word was empty, so subtract one from count. */
  %let count = %eval(&i - 1);
  &count;
%mend;

%let count = %CountWords(&RecipeName);
%put &count words in this recipe name.;

options macrogen symbolgen mprint mlogic;

/* Slide 57 */
%macro CountWords(WordList, charlist=%str( ));
  %local i NextWord;
  %let i=1;
  %do %while (%qscan(&WordList, &i, &charlist) ne );
    %let NextWord = %scan(&WordList, &i);
    %let i = %eval(&i + 1);
  %end;
  /* The ith word was empty, so subtract one from count. */
  %let count = %eval(&i - 1);
  &count;
%mend;

%let Ingredient = %str(beef roast, tenderloin, raw, 0 trim);
%let count = %CountWords(&Ingredient, charlist=%str(,));
%put &count words in this ingredient.;

%let Ingredient = 'beef roast, tenderloin, raw, 0 trim';
   %CountWords(beef roast, tenderloin, raw, 0 trim, charlist=%str(,));
   
/*
%let Ingredient = 'beef roast, tenderloin, raw, 0 trim';
 Problem: macro resolves this to
   %CountWords(beef roast, tenderloin, raw, 0 trim, charlist=%str(,));
 */

/*
%let Ingredient = %str('beef roast, tenderloin, raw, 0" trim');
 Problem: macro resolves this to
   %CountWords(beef roast, tenderloin, raw, 0 trim, charlist=%str(,));
 */

/* Slide 70 */
data BeefStroganoff;
input Year Amount Measure $ 10-12 Ingredient $ 14-55;
datalines;
1997 1.5 lb  beef roast, tenderloin, raw, 0" trim
1997 3.5 Tbs butter, salted
1997 1.0 Tbs flour, all purpose, self rising, enriched
1997 1.0 cup stock, beef, prepared from recipe
1997 3.0 Tbs sour cream, cultured
1997 1.0 tsp mustard, dijon
1997 2   lb  beef roast, tenderloin, raw, 0" trim
1997 2   Tbs oil, canola
1997 3   Tbs butter, salted
1997 1   ea  onion, yellow, fresh, medium, 2 1/2"
1997 1   lb  mushrooms, fresh
1997 1   cup stock, beef, prepared from recipe
1997 3   cup sour cream, cultured
1997 1   Tbs mustard, dijon
run;

proc sql;
  select * from BeefStroganoff where Ingredient like 'a%';
  select * from BeefStroganoff where Ingredient like 'b%';
  select * from BeefStroganoff where Ingredient like 'B%';
  select * from BeefStroganoff where upcase(Ingredient) like 'B%';
quit;


/* Slide 72 */
proc sql;
  select * from BeefStroganoff where Ingredient like 'beef';
  select * from BeefStroganoff where Ingredient like '%beef%';
  select * from BeefStroganoff where Ingredient contains 'beef';
quit;

/* Slide 75 */
proc sql;
  select Measure from BeefStroganoff where Measure like '_b_';
  select Measure from BeefStroganoff where Measure like '_b';
  select Measure from BeefStroganoff where trim(Measure) like '_b_';
quit;


/* Slide 75 */
proc sql;
/* three letter words, middle letter is e */
  select Ingredient from BeefStroganoff where trim(Ingredient) like '_e_';
quit;

proc sql;
/* e is the second letter, any number of other letters*/
  select Ingredient from BeefStroganoff where trim(Ingredient) like '_e%';
quit;

proc sql;
/* e is the second to last letter, any number of preceding letters*/
  select Ingredient from BeefStroganoff where trim(Ingredient) like '%e_';
quit;

proc sql;
/* e is anywhere in the text */
  select Ingredient from BeefStroganoff where trim(Ingredient) like '%e%';
quit;


%web_drop_table(JoyOfCooking);
filename reffile '/home/peterclaussen1/summer2018/data/JoyOfCookingSAS.csv';

proc import datafile=reffile
  dbms=csv
  out=JoyOfCooking;
  getnames=yes;
run;

proc sql;
  select RecipeName from JoyOfCooking where lowcase(RecipeName) like '%with%and%';
quit;

/* hmm, SAS truncates recipe names */
proc sql;
  select RecipeName from JoyOfCooking where lowcase(RecipeName) contains 'ham';
quit

proc sql;
  select RecipeName from JoyOfCooking;
quit;

