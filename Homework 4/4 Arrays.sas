
/*
Arrays
*/

/* Slide 8 */
proc iml;
  CaloriesPerRecipeMean = {2123.8 2122.3 2089.9 2250.0 2234.2 2249.6 3051.9};
  print(CaloriesPerRecipeMean[2]);
quit;

/* Slide 13 */
proc iml;
  print(repeat(1:4,3,2));
  print(repeat({1 2, 3 4}, 3,2));
  print(repeat(1:4,{2,3,1,2}));
quit;


/* Slide 16 */ 
proc iml;
  CaloriesPerRecipeMean = {2123.8 2122.3} || {2089.9 2250.0 2234.2} || {2249.6 3051.9};
  print(CaloriesPerRecipeMean);
  CaloriesPerRecipeMean = {2123.8 2122.3}` // {2089.9 2250.0 2234.2}` // {2249.6 3051.9}`;
  print(CaloriesPerRecipeMean);
quit;

/* Slide 17 */ 
proc iml;
 /* Error */
 CaloriesPerRecipeMean = {2123.8 2122.3} // {2089.9 2250.0 2234.2} // {2249.6 3051.9};
 CaloriesPerRecipeMean = {2123.8 2122.3}` || {2089.9 2250.0 2234.2}` || {2249.6 3051.9};
quit;
  
/* Slide 26 */
proc iml;
  MeansMatrix = {2123.8 268.1 12.9,
                 2122.3 271.1 12.9,
                 2089.9 280.9 13.0,
                 2250.0 294.7 12.7,
                 2234.2 285.6 12.4,
                 2249.6 288.6 12.4,
                 3051.9 384.4 12.7};
  print(MeansMatrix);
quit; 

/* Slide 27 */
proc iml;
  MeansMatrix = {2123.8 2122.3 2089.9 2250.0 2234.2 2249.6 3051.9,
                 268.1 271.1 280.9 294.7 285.6 288.6 384.4, 
                 12.9 12.9 13.0 12.7 12.4 12.4 12.7}`;
  print(MeansMatrix);
quit;


/* Slide 30 */
proc iml;
  CaloriesPerRecipeMean = {2123.8 2122.3 2089.9 2250.0 2234.2 2249.6 3051.9};
  MeansMatrix = {2123.8 2122.3 2089.9 2250.0 2234.2 2249.6 3051.9,
                 268.1 271.1 280.9 294.7 285.6 288.6 384.4, 
                 12.9 12.9 13.0 12.7 12.4 12.4 12.7};
  print(dimension(CaloriesPerRecipeMean));
  print(dimension(MeansMatrix));
  show allnames;
quit;


/* Slide 32 */
proc iml;
  MeansMatrix = {2123.8 2122.3 2089.9 2250.0 2234.2 2249.6 3051.9,
                 268.1 271.1 280.9 294.7 285.6 288.6 384.4, 
                 12.9 12.9 13.0 12.7 12.4 12.4 12.7}`;

  print(MeansMatrix[2,2]);
  print(MeansMatrix[1,]);
  print(MeansMatrix[,2]);
  print(MeansMatrix[8]);
quit;

/* Slide 34 */
proc iml;
  MeansMatrix = {2123.8 2122.3 2089.9 2250.0 2234.2 2249.6 3051.9,
                 268.1 271.1 280.9 294.7 285.6 288.6 384.4, 
                 12.9 12.9 13.0 12.7 12.4 12.4 12.7}`;

  print(MeansMatrix[2:4,]);
  print(MeansMatrix[{2 4 3},]);
  print(MeansMatrix[repeat(2,3),]);
quit;

/* Slide 38 */
proc iml;
  ServingsPerRecipeSD = {13.3 13.3 14.5 14.6 14.3 14.3 13.0};
  print(sum(ServingsPerRecipeSD));
  print(min(ServingsPerRecipeSD)); 
  print(max(ServingsPerRecipeSD)); 
  
  print(log(ServingsPerRecipeSD));
  print(mean(ServingsPerRecipeSD)); /*surprise?*/
  print(sqrt(ServingsPerRecipeSD)); 
quit;


/* Slide 42 */
proc iml;
  ServingsPerRecipeSD = {13.3 13.3 14.5 14.6 14.3 14.3 13.0};
  print(ServingsPerRecipeSD * ServingsPerRecipeSD`); 
  print(ServingsPerRecipeSD` * ServingsPerRecipeSD);
quit;

proc iml;
   /*Error*/
  ServingsPerRecipeSD = {13.3 13.3 14.5 14.6 14.3 14.3 13.0};
  print(ServingsPerRecipeSD * ServingsPerRecipeSD);
quit;
 
/* Slide 43 */
proc iml;
  ServingsPerRecipeSD = {13.3 13.3 14.5 14.6 14.3 14.3 13.0};
  print(ServingsPerRecipeSD**2);
quit;


/* Slide 44 */
proc iml;
  ServingsPerRecipeSD = {13.3 13.3 14.5 14.6 14.3 14.3 13.0};
  print(ServingsPerRecipeSD#ServingsPerRecipeSD); 
  print(ServingsPerRecipeSD##2);
quit;

/*
 * ods listing close;
 */