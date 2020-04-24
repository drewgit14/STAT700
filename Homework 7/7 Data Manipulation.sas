/*
 * Data Manipulation
*/

%web_drop_table(JoyOfCooking);
filename reffile '/home/peterclaussen1/summer2018/data/JoyOfCookingSAS.csv';

proc import datafile=reffile
  dbms=csv
  out=JoyOfCooking;
  getnames=yes;
run;

/* Slide 10 */
data X;
  set JoyOfCooking;
  if(CaloriesperServing1936 ^= .) then output;
run;

proc print data=X;
run;

proc sql;
  create table X as select * from JoyOfCooking 
    where(CaloriesperServing1936 ^= .);
quit;

/* Slide 11 */
proc sql;
  create table X as select CaloriesperServing1936, RecipeName from JoyOfCooking 
    where(CaloriesperServing1936 ^= .);
quit;

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

/* Slide 25 */
data BeefStroganoff;
  set BeefStroganoff1997 BeefStroganoff2006;
run;

proc print data=BeefStroganoff;
run;

data BeefStroganoff;
  merge BeefStroganoff1997 BeefStroganoff2006;
run;

/* Slide 26 */
proc sort data=BeefStroganoff1997 out=BeefStroganoff1997;
  by Ingredient;
run;

proc sort data=BeefStroganoff2006 out=BeefStroganoff2006;
  by Ingredient;
run;

data BeefStroganoff1997;
  set BeefStroganoff1997;
  AmountX = Amount;
  drop amount;
run;

proc print data=BeefStroganoff1997;
run;

data BeefStroganoff2006;
  set BeefStroganoff2006;
  AmountY = amount;
  drop Amount;
run;

proc print data=BeefStroganoff1997;
run;

data BeefStroganoff;
  merge BeefStroganoff1997 BeefStroganoff2006;
  by Ingredient;
run;

proc print data=BeefStroganoff;
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

/* Slide 35 */
proc sort data=CookingTooMuch out=SortedCooking;
  by CaloriesPerRecipeMean;
run;

proc print data=SortedCooking;
run;

/* Slide 36 */
proc rank data=CookingTooMuch out=RankCooking;
  var CaloriesPerRecipeMean;
  ranks CaloriePerRecipeRank;
run;

proc print data=RankCooking;
run;

/* Slide 59 */
proc sort data=JoyOfCooking out=SortedJoy;
  by RecipeName TooMuch;
run;
proc transpose data=SortedJoy out=CaloriesperServingTemp(
    rename=(col1=CaloriesperServing))
  name=CaloriesperServingYear;
  var CaloriesperServing1936 CaloriesperServing2006;
  by RecipeName TooMuch;
run;

proc print data=CaloriesperServingTemp;
run;

/* Slide 60 */
proc transpose data=JoyOfCooking out=CaloriesperServingTemp(
    rename=(col1=CaloriesperServing))
  name=CaloriesperServingYear;
  var CaloriesperServing1936 CaloriesperServing2006;
  by RecipeName TooMuch;
run;

/* Slide 61 */
proc transpose data=SortedJoy out=CaloriesperServingTemp;
  by RecipeName;
run;

proc print data=CaloriesperServingTemp;
run;

/* Slide 62 */
proc transpose data=SortedJoy out=CaloriesperServingTemp;
  var CaloriesperServing1936 CaloriesperServing2006;
  by RecipeName;
run;

proc print data=CaloriesperServingTemp;
run;

/* Slide 63 */
proc transpose data=SortedJoy out=CaloriesperServingTemp;
  var CaloriesperServing1936 CaloriesperServing2006;
  by RecipeName TooMuch;
run;

proc print data=CaloriesperServingTemp;
run;


/* Slide 64 */
proc transpose data=SortedJoy out=CaloriesperServingTemp
  name=CaloriesperServingYear;
  var CaloriesperServing1936 CaloriesperServing2006;
  by RecipeName TooMuch;
run;

proc print data=CaloriesperServingTemp;
run;

/* Slide 65 */
proc transpose data=SortedJoy out=CaloriesperServingTemp(
    rename=(col1=CaloriesperServing))
  name=CaloriesperServingYear;
  var CaloriesperServing1936 CaloriesperServing2006;
  by RecipeName TooMuch;
run;

proc print data=CaloriesperServingTemp;
run;

/* Slide 72-73 */
proc sql;
  create table BeefStroganoff1997
    (Amount num,
     Measure char(3),
     Ingredient varchar(50));

  create table BeefStroganoff2006
    like BeefStroganoff1997;
    
  insert into BeefStroganoff1997
    values(1.5, 'lb','beef roast, tenderloin, raw, 0" trim')
    values(3.5, 'Tbs', 'butter, salted')
    values(1.0, 'Tbs', 'flour, all purpose, self rising, enriched')
    values(1.0, 'cup', 'stock, beef, prepared from recipe')
    values(3.0, 'Tbs', 'sour cream, cultured')
    values(1.0, 'tsp', 'mustard, dijon');
    
  insert into BeefStroganoff2006
    set Amount=2, Measure='lb', Ingredient='beef roast, tenderloin, raw, 0" trim'
    set Amount=2, Measure='Tbs', Ingredient='oil, canola'
    set Amount=3, Measure='Tbs', Ingredient='butter, salted'
    set Amount=1, Measure='ea', Ingredient='onion, yellow, fresh, medium, 2 1/2"'
    set Amount=1, Measure='lb', Ingredient='mushrooms, fresh'
    set Amount=1, Measure='cup', Ingredient='stock, beef, prepared from recipe'
    set Amount=3, Measure='cup', Ingredient='sour cream, cultured'
    set Amount=1, Measure='Tbs', Ingredient='mustard, dijon'; 
quit;


/* Slide 75 */
proc sql;
  select *
    from BeefStroganoff1997;
   
  select *
    from BeefStroganoff2006;
quit;

/* Slide 76 */
proc sql;
  select Amount, Ingredient 
    from BeefStroganoff1997;
quit;

/* Slide 77 */
proc sql;
  select Amount as HowMuch, Ingredient as Stuff
    from BeefStroganoff1997;
quit;

/* Slide 78 */
proc sql;
  select *
    from BeefStroganoff1997
    where Measure = 'Tbs';
run;

/* Slide 79 */
proc sql;
  select Amount as HowMuch, Ingredient as Stuff 
    from BeefStroganoff1997
    where Measure = 'Tbs';
run;

/* Slide 80 */
proc sql;
  select Amount, Ingredient 
    from BeefStroganoff1997
    where Measure = 'Tbs'
    order by Amount;
run;

/* Slide 81 */
proc sql;
  create table Tablespoons as
    select Amount, Ingredient 
      from BeefStroganoff1997
      where Measure = 'Tbs'
      order by Amount;
run;

/* Slide 82 */
proc sql noprint;
  select Amount, Measure
    into :AmountMV, :MeasureMV
    from BeefStroganoff1997
    where Ingredient='mustard, dijon';  
%put &=AmountMV &=MeasureMV;
quit;

/* Slide 83 */
options macrogen symbolgen mprint mlogic;
proc sql noprint;
  select Amount, Ingredient
    into :AmountMV1-:AmountMV4, :IngredientMV1-:IngredientMV4
    from BeefStroganoff1997
    where Measure='Tbs';
      
%macro DisplayMV;
  %do i=1 %to 4;
    %put Ingredient&i: &&AmountMV&i &&IngredientMV&i;
  %end;
%mend DisplayMV;

%DisplayMV;

quit;

/* Slide 84 */
proc sql noprint;
  select count(*) into :rows trimmed
    from BeefStroganoff1997
    where Measure='Tbs';
      
  select Amount, Ingredient
    into :AmountMV1-:AmountMV&rows, :IngredientMV1-:IngredientMV&rows
    from BeefStroganoff1997
    where Measure='Tbs';
      
%macro DisplayMV;
  %do i=1 %to &rows;
    %put Ingredient&i: &&AmountMV&i &&IngredientMV&i;
  %end;
%mend DisplayMV;

%DisplayMV;

quit;

/* Slide 85 */
proc sql;
  select * from BeefStroganoff1997, BeefStroganoff2006;
quit;

/* Slide 86 */
proc sql;
  create table Stroganoff 
    as select * from BeefStroganoff1997;
    
  insert into Stroganoff
    select * from BeefStroganoff2006;
    
  select * from Stroganoff;
quit;

/* Slide 87*/
proc sql;
  create table Stroganoff as select * from BeefStroganoff1997;
  
  alter table Stroganoff add Year num;
    
  update Stroganoff set Year=1997;
  
  create table Working as select * from BeefStroganoff2006;
  
  alter table Working add Year num;
    
  update Working set Year=2006;
     
  insert into Stroganoff select * from Working;

  select * from Stroganoff;
  
quit;

/* Slide 88 */
proc sql;
  select BeefStroganoff1997.Ingredient, 
         BeefStroganoff1997.amount as AmountX, 
         BeefStroganoff2006.amount as AmountY
    from BeefStroganoff1997 
    left join BeefStroganoff2006
         on BeefStroganoff1997.Ingredient = 
            BeefStroganoff2006.Ingredient;
run;

