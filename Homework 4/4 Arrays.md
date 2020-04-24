<style>
.tiny-code pre code {
  font-size: 1.0em;
}
.small-code pre code {
  font-size: 1.2em;
}
.medium-code pre code {
  font-size: 1.4em;
}
</style>



Arrays
========================================================
autosize: true
font-family: 'Garamond'

## Statistical Programming

Concepts
========================================================

- Arrays, Vectors and Matrices
- Array Creation
- Array Access
- Array Arithmetic
- Array Functions


Arrays, Vectors and Matrices
========================================================
In programming, an array is a collection of values or variables that can be accessed by at least one index. If there is only one index, the term **vector** is generally used, while **matrices** are accessed using two indices.

========================================================
While it is possible to create arrays with more than two dimensions, it's not that common in statistics. More commonly, multidimensional data are represented in tables with columns or indicator variables representing a different dimension. 


========================================================
We could, for example, represent Wansink Table 1 in three dimensions, using calories per recipe as the first dimension, calories per serving as the second dimension and servings per recipe as the third dimension. The year 1936 would be a point in this three-dimensional space,

$$y_{i j k} = \left\{ 2123.8, 268.1, 12.9 \right\}$$

Thus, for now, we'll restrict our discussion to vectors and matrices.

========================================================
In our example, we have a vector that represents calories per recipe,
$$\mathbf{y} =  \left\{ 2123.8, 2122.3, 2089.9, 2250.0, 2234.2, 2249.6, 3051.9\right\}$$

If we want to reference a specific years value, we might write this as

$$y_2 = 2122.3$$

Vector Creation
========================================================

This we do simply as

```r
CaloriesPerRecipeMean = c(2123.8, 2122.3, 2089.9, 2250.0, 2234.2, 2249.6, 3051.9)
CaloriesPerRecipeMean[2]
```

```
[1] 2122.3
```

in R, and


========================================================

```
CaloriesPerRecipeMean = {2123.8 2122.3 2089.9 2250.0 2234.2 2249.6 3051.9};
print(CaloriesPerRecipeMean[2]);
```

in SAS IML;

========================================================
A word of caution. In R, vectors are one-dimensional entities that are different than arrays/matrices, while in SAS IML, a vector is a matrix with one row or column. 


Sequences
========================================================

We can use the `:` operator as a short cut to create vectors with numeric values in order:


```r
n <- length(CaloriesPerRecipeMean)
1:(n-1)
```

```
[1] 1 2 3 4 5 6
```

```r
2:n
```

```
[1] 2 3 4 5 6 7
```

========================================================
We can also use the sequence function:


```r
sequence(n)
```

```
[1] 1 2 3 4 5 6 7
```
Sequences can be descending, and include negative integers.


```r
2:-2
```

```
[1]  2  1  0 -1 -2
```

Repetition
========================================================
class: small-code
A related function is `rep`, which duplicates values:


```r
rep(1:4,4)
```

```
 [1] 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4
```

```r
rep(1:4,each=4)
```

```
 [1] 1 1 1 1 2 2 2 2 3 3 3 3 4 4 4 4
```

```r
rep(-2:2,length.out=16)
```

```
 [1] -2 -1  0  1  2 -2 -1  0  1  2 -2 -1  0  1  2 -2
```

========================================================

The (roughly) equivalent function is SAS is `repeat`. However, `repeat` will typically be used to create matrices, accepting as parameters the number of repeated rows and repeated columns.

```
print(repeat(1:4,3,2));
print(repeat({1 2, 3 4}, 3,2));
```

`repeat` will also accept a vector of frequencies, representing the number of times each element is to be repeated.

```
print(repeat(1:4,{2,3,1,2}));
```

Concatenation
========================================================

Think of `c` as shorthand for *concatenate*.


```r
c(1936, 1946, 1951, 1963, 1975, 1997, 2006)
```

```
[1] 1936 1946 1951 1963 1975 1997 2006
```

Concatenation can be nested and used to merge vectors.


```r
c(1936, c(1946, 1951, 1963), c(1975, 1997), 2006)
```

```
[1] 1936 1946 1951 1963 1975 1997 2006
```


========================================================

Concatentation in SAS is done using the `||` and `//` operators. 

These are  horizontal and vertical matrix concatentations, and as such require conforming matrices - matrices that are the same length in either the horizontal and vertical dimensions. 

========================================================
Thus,

```
CaloriesPerRecipeMean = {2123.8 2122.3} || 
                        {2089.9 2250.0 2234.2} || 
                        {2249.6 3051.9};
print(CaloriesPerRecipeMean);
CaloriesPerRecipeMean = {2123.8 2122.3}` // 
                        {2089.9 2250.0 2234.2}` // 
                        {2249.6 3051.9}`;
print(CaloriesPerRecipeMean);

```

========================================================

```
proc iml;
 /* Errors */
 CaloriesPerRecipeMean = {2123.8 2122.3} // {2089.9 2250.0 2234.2} // {2249.6 3051.9};
 CaloriesPerRecipeMean = {2123.8 2122.3}` || {2089.9 2250.0 2234.2}` || {2249.6 3051.9};
run;
```


========================================================

Note the transpose operator (backtick). In R, this is `t()`


```r
t(CaloriesPerRecipeMean)
```

```
       [,1]   [,2]   [,3] [,4]   [,5]   [,6]   [,7]
[1,] 2123.8 2122.3 2089.9 2250 2234.2 2249.6 3051.9
```


========================================================
Transpose is a matrix function, so R converts a vector to a matrix

```r
class(CaloriesPerRecipeMean)
```

```
[1] "numeric"
```

```r
class(t(CaloriesPerRecipeMean))
```

```
[1] "matrix"
```


========================================================
In R, most values, unless otherwise specified, are vectors. A single number is simply contained in a vector of length 1


```r
length(2123.8)
```

```
[1] 1
```

```r
length(c(2123.8))
```

```
[1] 1
```


Matrix Creation
========================================================

Suppose we want to create a matrix that matches Wansink Table 1 - specifically, a matrix of means in columns, each row a year. This requires some extra information, related to dimensions. How many rows, and how many columns are to be in the matrix?


========================================================
We use the `matrix` function in R to convert data in vectors to matrices. This function requires two of three pieces of information. 

If we have values in a vector, we only need to specify the number of rows or the number of columns:


```r
MeansMatrix = matrix(c(2123.8, 2122.3, 2089.9, 2250.0, 2234.2, 2249.6, 3051.9, 268.1, 271.1, 280.9, 294.7, 285.6, 288.6, 384.4, 12.9, 12.9, 13.0, 12.7, 12.4, 12.4, 12.7), ncol=3)
MeansMatrix
```

```
       [,1]  [,2] [,3]
[1,] 2123.8 268.1 12.9
[2,] 2122.3 271.1 12.9
[3,] 2089.9 280.9 13.0
[4,] 2250.0 294.7 12.7
[5,] 2234.2 285.6 12.4
[6,] 2249.6 288.6 12.4
[7,] 3051.9 384.4 12.7
```

========================================================

Or a number of rows,


```r
matrix(c(2123.8, 2122.3, 2089.9, 2250.0, 2234.2, 2249.6, 3051.9, 268.1, 271.1, 280.9, 294.7, 285.6, 288.6, 384.4, 12.9, 12.9, 13.0, 12.7, 12.4, 12.4, 12.7), nrow=7)
```

```
       [,1]  [,2] [,3]
[1,] 2123.8 268.1 12.9
[2,] 2122.3 271.1 12.9
[3,] 2089.9 280.9 13.0
[4,] 2250.0 294.7 12.7
[5,] 2234.2 285.6 12.4
[6,] 2249.6 288.6 12.4
[7,] 3051.9 384.4 12.7
```

========================================================
or a single value, and the dimensions required:


```r
matrix(0, nrow=7,ncol=3)
```

```
     [,1] [,2] [,3]
[1,]    0    0    0
[2,]    0    0    0
[3,]    0    0    0
[4,]    0    0    0
[5,]    0    0    0
[6,]    0    0    0
[7,]    0    0    0
```


========================================================
Matrices in R are column-major; values in the vector fill down. If we want to fill across, we use


```r
matrix(c(2123.8, 2122.3, 2089.9, 2250.0, 2234.2, 2249.6, 3051.9, 268.1, 271.1, 280.9, 294.7, 285.6, 288.6, 384.4, 12.9, 12.9, 13.0, 12.7, 12.4, 12.4, 12.7), ncol=7,byrow=TRUE)
```

```
       [,1]   [,2]   [,3]   [,4]   [,5]   [,6]   [,7]
[1,] 2123.8 2122.3 2089.9 2250.0 2234.2 2249.6 3051.9
[2,]  268.1  271.1  280.9  294.7  285.6  288.6  384.4
[3,]   12.9   12.9   13.0   12.7   12.4   12.4   12.7
```




========================================================
In IML, we enter values in row-major order, with rows separated by commas

```
MeansMatrix = {2123.8 268.1 12.9,
               2122.3 271.1 12.9,
               2089.9 280.9 13.0,
               2250.0 294.7 12.7,
               2234.2 285.6 12.4,
               2249.6 288.6 12.4,
               3051.9 384.4 12.7};
```

========================================================
or we could resuse our vectors and the transpose operators

```
MeansMatrix = {2123.8 2122.3 2089.9 2250.0 2234.2 2249.6 3051.9,
               268.1 271.1 280.9 294.7 285.6 288.6 384.4, 
               12.9 12.9 13.0 12.7 12.4 12.4 12.7}`;
```

  
Length vs dimension
========================================================
class: small-code
Vectors are by convention arrays with only one dimension, while matrices are two-dimensional arrays. Thus, in R, 


```r
length(CaloriesPerRecipeMean)
```

```
[1] 7
```

```r
dim(CaloriesPerRecipeMean)
```

```
NULL
```

```r
nrow(CaloriesPerRecipeMean)
```

```
NULL
```

```r
ncol(CaloriesPerRecipeMean)
```

```
NULL
```

========================================================
class: small-code
versus


```r
length(MeansMatrix)
```

```
[1] 21
```

```r
dim(MeansMatrix)
```

```
[1] 7 3
```

```r
nrow(MeansMatrix)
```

```
[1] 7
```

```r
ncol(MeansMatrix)
```

```
[1] 3
```


========================================================
In IML, all are matrices

```
print(dimension(CaloriesPerRecipeMean));
print(dimension(MeansMatrix));
```


Array Access
========================================================
class: small-code
As we've seen, array access is through the `[ ]` operators. We can use this, in both R and SAS IML, to access cells, rows and columns:

```r
MeansMatrix[2,2]
```

```
[1] 271.1
```

```r
MeansMatrix[1,]
```

```
[1] 2123.8  268.1   12.9
```

```r
MeansMatrix[,2]
```

```
[1] 268.1 271.1 280.9 294.7 285.6 288.6 384.4
```

```r
MeansMatrix[8]
```

```
[1] 268.1
```

IML
========================================================
```
print(MeansMatrix[2,2]);
print(MeansMatrix[1,]);
print(MeansMatrix[,2]);

print(MeansMatrix[8]);
```



========================================================
class: tiny-code

We can also use vectors or sequences, and they can be to index rows or columns out of order, or repeated


```r
MeansMatrix[2:4,]
```

```
       [,1]  [,2] [,3]
[1,] 2122.3 271.1 12.9
[2,] 2089.9 280.9 13.0
[3,] 2250.0 294.7 12.7
```


```r
MeansMatrix[c(2,4,3),]
```

```
       [,1]  [,2] [,3]
[1,] 2122.3 271.1 12.9
[2,] 2250.0 294.7 12.7
[3,] 2089.9 280.9 13.0
```


```r
MeansMatrix[rep(2,3),]
```

```
       [,1]  [,2] [,3]
[1,] 2122.3 271.1 12.9
[2,] 2122.3 271.1 12.9
[3,] 2122.3 271.1 12.9
```


IML
========================================================

```
print(MeansMatrix[2:4,]);
print(MeansMatrix[{2 4 3},]);
print(MeansMatrix[repeat(2,3),]);
```


========================================================
Boolean values can also be used.


```r
Year[c(TRUE,FALSE,TRUE,FALSE,FALSE,TRUE,TRUE)]
```

```
[1] 1936 1951 1997 2006
```

```r
MeansMatrix[c(TRUE,FALSE,TRUE,FALSE,FALSE,TRUE,TRUE),
            c(TRUE,FALSE,TRUE)]
```

```
       [,1] [,2]
[1,] 2123.8 12.9
[2,] 2089.9 13.0
[3,] 2249.6 12.4
[4,] 3051.9 12.7
```


Array and functions
========================================================
class: tiny-code

We should note that there are some functions that accept arrays as parameter and return a single value:

```r
sum(ServingsPerRecipeSD)
```

```
[1] 97.3
```

```r
mean(ServingsPerRecipeSD)
```

```
[1] 13.9
```

```r
min(ServingsPerRecipeSD)
```

```
[1] 13
```

```r
max(ServingsPerRecipeSD)
```

```
[1] 14.6
```


========================================================

while other functions, that typically accept single values, return arrays when given arrays as values


```r
log(ServingsPerRecipeSD)
```

```
[1] 2.587764 2.587764 2.674149 2.681022 2.660260 2.660260 2.564949
```

```r
sqrt(ServingsPerRecipeSD)
```

```
[1] 3.646917 3.646917 3.807887 3.820995 3.781534 3.781534 3.605551
```

IML
========================================================
```
print(sum(ServingsPerRecipeSD));
print(min(ServingsPerRecipeSD)); 
print(max(ServingsPerRecipeSD)); 
  
print(log(ServingsPerRecipeSD));
print(mean(ServingsPerRecipeSD)); /*surprise?*/
print(sqrt(ServingsPerRecipeSD));
```
  
Operators and Arrays
========================================================

What about operators? We think of binary operators as functions that accept two parameters, each single values. What happens if one or more is an array?

In R, operations will be pairwise scalar. That is,
```
ServingsPerRecipeSD*10
```

is the same as
```
c(ServingsPerRecipeSD[1]*10, ServingsPerRecipeSD[2]*10, ...)
```

========================================================
This makes sense, if we think


```r
ServingsPerRecipeSD*ServingsPerRecipeSD
```

```
[1] 176.89 176.89 210.25 213.16 204.49 204.49 169.00
```

```r
ServingsPerRecipeSD^2
```

```
[1] 176.89 176.89 210.25 213.16 204.49 204.49 169.00
```

should produce the same result.

========================================================
class: small-code
If we want a matrix operation, we use %, where it make sense. That is

```r
1:4 %*% 1:4
```

```
     [,1]
[1,]   30
```

```r
1:4 %o% 1:4
```

```
     [,1] [,2] [,3] [,4]
[1,]    1    2    3    4
[2,]    2    4    6    8
[3,]    3    6    9   12
[4,]    4    8   12   16
```

```r
1:4 %x% 1:4
```

```
 [1]  1  2  3  4  2  4  6  8  3  6  9 12  4  8 12 16
```
(inner, outer and kronecker products)

========================================================
but not

```
1:4 %+% 1:4
```

========================================================
IML, in contrast, defaults to matrix operations. Thus

```
ServingsPerRecipeSD = {13.3 13.3 14.5 14.6 14.3 14.3 13.0};
print(ServingsPerRecipeSD * ServingsPerRecipeSD`); 
print(ServingsPerRecipeSD` *ServingsPerRecipeSD);
```
is a matrix multiplication (inner and outer products - note the transpose operators)

========================================================

while the power operator requires square matrices. This is an error in IML.

```
print(ServingsPerRecipeSD**2);
```

========================================================
We use `#` and `##` to specify pairwise operations:

```
print(ServingsPerRecipeSD#ServingsPerRecipeSD); 
print(ServingsPerRecipeSD##2);
```

  
Mapping Functions
======================================================== 
A mapping function, in LISP, is a function that accepts another function as a parameter and applies this function to other parameters. This can be a powerful tool for creating flexible programs.

R provides a number of mapping functions, most in the `apply` family, i.e.

- `apply`
- `lapply`
- `tapply`


apply
======================================================== 
class: small-code

Suppose I want to determine the minimum and maximum values in each column of a matrix. I could access each column, individually, by

```r
min(MeansMatrix[,1])
```

```
[1] 2089.9
```

```r
min(MeansMatrix[,2])
```

```
[1] 268.1
```

```r
min(MeansMatrix[,3])
```

```
[1] 12.4
```

Then I would need to know something about the total number of columns, and I would either need to write each column by hand, or write a loop (*6 Control Structures*)


========================================================
Or I can `apply` `min`


```r
apply(X=MeansMatrix,MARGIN=2,FUN=min)
```

```
[1] 2089.9  268.1   12.4
```

========================================================
`lapply` and related functions return lists as results. This is more commonly used in building function libraries than in common data analysis.

`tapply` and related produce *ragged* arrays using factors as indexes. This is more useful when working with data frames.


Discussion.
========================================================

- How would you create a matrix from individual vectors, i.e from

```
CaloriesPerRecipeMean = {2123.8 2122.3 2089.9 2250.0 2234.2 2249.6 3051.9};
CaloriesPerRecipeSD = {1050.0 1002.3 1009.6 1078.6 1089.2 1094.8 1496.2};
...
```

- What happens, in R and SAS IML, if the initial values specified for a matrix do not match specified dimensions?


========================================================
- What is the default "dimension" of an R vector (that is, row or column)? Hint : what are the dimensions of `t(CaloriesPerRecipeMean)`

- How would you use a vector and simple arithmetic to reverse the order of rows in a data frame?

- Are boolean indexes supported in IML?

- How are the functions `sweep` and `aggregate` related to `apply`. Does IML provide similar functions?


Scatter plots
========================================================

Scatter plots

- plot paired observations in two vectors
- plot a function against a sequence

