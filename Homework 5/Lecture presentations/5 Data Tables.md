
<style>
.tiny-code pre code {
  font-size: 1.2em;
}
.small-code pre code {
  font-size: 1.2em;
}
.medium-code pre code {
  font-size: 1.4em;
}
</style>

Data Tables
========================================================
autosize: true
font-family: 'Garamond'

## Statistical Programming

========================================================

We've created a collection of vectors that are not logically connected to each other. As we've seen in the first homework, it's not that hard to package vectors into a data table. This simplifies working with a large number of values as a single unit.
 
Data Tables 
======================================================== 
Data tables are two-dimensional structures similar to matrices with some key differences:

1. Columns within tables are homogeneous data structures (similar to vectors) but can be heterogenous across columns (unlike matrices).

2. Columns require indentifiers, but rows do not.

3. Rows are typically assumed to represent observations from a single entity. 


Concepts
======================================================== 
1. Creating data tables
2. Importing data tables
3. Indexing data tables
4. Summarizing data tables



Creating Data Tables
========================================================

In R, we can create data tables programmatically using the `data.frame` function. This is a constructor function, that creates an instance of class `data.frame`


```r
CookingTooMuch.dat <- data.frame(
  Year=c(1936, 1946, 1951, 1963, 1975, 1997, 2006),
  CaloriesPerRecipeMean = c(2123.8, 2122.3, 2089.9, 2250.0, 2234.2, 2249.6, 3051.9),
  CaloriesPerRecipeSD = c(1050.0, 1002.3, 1009.6, 1078.6, 1089.2, 1094.8, 1496.2)
)
class(CookingTooMuch.dat)
```

```
[1] "data.frame"
```

========================================================

If we examine the structure of a data frame, we see that it is very similar to a list of vectors

```r
str(CookingTooMuch.dat)
```

```
'data.frame':	7 obs. of  3 variables:
 $ Year                 : num  1936 1946 1951 1963 1975 ...
 $ CaloriesPerRecipeMean: num  2124 2122 2090 2250 2234 ...
 $ CaloriesPerRecipeSD  : num  1050 1002 1010 1079 1089 ...
```

========================================================
class: small-code

We can construct a frame from named vectors

```r
Year <- c(1936, 1946, 1951, 1963, 1975, 1997, 2006)
CaloriesPerServingMean <- c(268.1, 271.1, 280.9, 294.7, 285.6, 288.6, 384.4)
CaloriesPerServingSD <- c(124.8, 124.2, 116.2, 117.7, 118.3, 122.0, 168.3)
CookingTooMuch2.dat <- data.frame(
  Year,
  CaloriesPerServingMean,
  CaloriesPerServingSD
)
str(CookingTooMuch2.dat)
```

```
'data.frame':	7 obs. of  3 variables:
 $ Year                  : num  1936 1946 1951 1963 1975 ...
 $ CaloriesPerServingMean: num  268 271 281 295 286 ...
 $ CaloriesPerServingSD  : num  125 124 116 118 118 ...
```

========================================================
class: small-code

Frames are typically constructed with the `=` operator. 

The scope of the `=` assignment is local, and in this case means local to the data frame object. You can create a data frame without specifying the local variable name, but then R will attempt to create a name:

```r
CookingTooMuch3.dat <- data.frame(
  Year,
  c(12.9, 12.9, 13.0, 12.7, 12.4, 12.4, 12.7)
)
str(CookingTooMuch3.dat)
```

```
'data.frame':	7 obs. of  2 variables:
 $ Year                                     : num  1936 1946 1951 1963 1975 ...
 $ c.12.9..12.9..13..12.7..12.4..12.4..12.7.: num  12.9 12.9 13 12.7 12.4 12.4 12.7
```

========================================================
class: small-code

The result is confusing if we try to use the `<-` operator


```r
CookingTooMuch4.dat <- data.frame(
  Year <- c(1936, 1946, 1951, 1963, 1975, 1997, 2006),
  CaloriesPerRecipeMean <- c(2123.8, 2122.3, 2089.9, 2250.0, 2234.2, 2249.6, 3051.9)
)
str(CookingTooMuch4.dat)
```

```
'data.frame':	7 obs. of  2 variables:
 $ Year....c.1936..1946..1951..1963..1975..1997..2006.              : num  1936 1946 1951 1963 1975 ...
 $ CaloriesPerRecipeMean....c.2123.8..2122.3..2089.9..2250..2234.2..: num  2124 2122 2090 2250 2234 ...
```

SAS Data Tables
========================================================

We've seen an example of creating a data table from matrices in PROC IML:
```
proc iml;
  Year = {1936, 1946, 1951, 1963, 1975, 1997, 2006};
  CaloriesPerRecipeMean = {2123.8, 2122.3, 2089.9, 2250.0, 2234.2, 2249.6, 3051.9};
  CaloriesPerRecipeSD = {1050.0, 1002.3, 1009.6, 1078.6, 1089.2, 1094.8, 1496.2};

  create CookingTooMuch var _all_;  
  append;
  close CookingTooMuch;
quit;
```

========================================================
More commonly, data will be entered in the data step, as we've also seen

```
data CookingTooMuch;
input Year CaloriesPerRecipeMean CaloriesPerRecipeSD;
datalines;
1936 2123.8 1050.0
1946 2122.3 1002.3
1951 2089.9 1009.6
1963 2250.0 1078.6
1975 2234.2 1089.2
1997 2249.6 1094.8
2006 3051.9 1496.2
run;
```

Data Step
========================================================
Considering general steps of compiling a SAS program, we are reminded that data tables are central to SAS, and we've seen examples of calculations and variable assignment in the data step. What we've done in this example is more typical of how the data step is used.

Processing in the DATA step
========================================================
During the compile phase, SAS will create a program data vector to hold values. There is an implicit loop in the data step that reads and processes data, one line at a time. 

========================================================
In our example above, the first line of data is
```
1936 2123.8 1050.0
```
and these values are read into the variables named
```
Year CaloriesPerRecipeMean CaloriesPerRecipeSD
```

There are no other operations for this data. 


=========================================================

But we can add operations, as we've also seen:

```
data CookingTooMuch;
input Year Mean SD;
  Lower = Mean-SD;
  Upper = Mean+SD;
datalines;
1936 2123.8 1050.0
1946 2122.3 1002.3
1951 2089.9 1009.6
1963 2250.0 1078.6
1975 2234.2 1089.2
1997 2249.6 1094.8
2006 3051.9 1496.2
run;
```



========================================================

The default behavior in the data step is move to the next data line when a 'new line' character is encountered. This can be suppressed using `@@`. This allows values to be entered in a continuous stream:

```
data CookingTooMuch;
input Year Mean SD @@;
  Lower = Mean-SD;
  Upper = Mean+SD;
datalines;
1936 2123.8 1050.0 1946 2122.3 1002.3 1951 2089.9 1009.6 1963 2250.0 1078.6
1975 2234.2 1089.2 1997 2249.6 1094.8 2006 3051.9 1496.2
run;
```

Importing Data Tables
========================================================

More commonly, we read data stored in some delimited from. I most frequently use:























































```
Error in file(file, "rt") : cannot open the connection
```
