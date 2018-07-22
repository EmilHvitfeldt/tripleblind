
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tripleblind

The goal of tripleblind is to allow for easy annonomitation of the data
before EDA to reduce biases.

**VERY EARLY WIP, expect mayor changes and the framework falls into
place**

## Installation

You can install ggpage from github with:

``` r
# install.packages("devtools")
devtools::install_github("EmilHvitfeldt/tripleblind")
```

## Example

Under the hood it will label data that can be anamonitied.

``` r
library(tripleblind)

strip(iris$Sepal.Length)
#> $data
#>   [1] 5.1 4.9 4.7 4.6 5.0 5.4 4.6 5.0 4.4 4.9 5.4 4.8 4.8 4.3 5.8 5.7 5.4
#>  [18] 5.1 5.7 5.1 5.4 5.1 4.6 5.1 4.8 5.0 5.0 5.2 5.2 4.7 4.8 5.4 5.2 5.5
#>  [35] 4.9 5.0 5.5 4.9 4.4 5.1 5.0 4.5 4.4 5.0 5.1 4.8 5.1 4.6 5.3 5.0 7.0
#>  [52] 6.4 6.9 5.5 6.5 5.7 6.3 4.9 6.6 5.2 5.0 5.9 6.0 6.1 5.6 6.7 5.6 5.8
#>  [69] 6.2 5.6 5.9 6.1 6.3 6.1 6.4 6.6 6.8 6.7 6.0 5.7 5.5 5.5 5.8 6.0 5.4
#>  [86] 6.0 6.7 6.3 5.6 5.5 5.5 6.1 5.8 5.0 5.6 5.7 5.7 6.2 5.1 5.7 6.3 5.8
#> [103] 7.1 6.3 6.5 7.6 4.9 7.3 6.7 7.2 6.5 6.4 6.8 5.7 5.8 6.4 6.5 7.7 7.7
#> [120] 6.0 6.9 5.6 7.7 6.3 6.7 7.2 6.2 6.1 6.4 7.2 7.4 7.9 6.4 6.3 6.1 7.7
#> [137] 6.3 6.4 6.0 6.9 6.7 6.9 5.8 6.8 6.7 6.7 6.3 6.5 6.2 5.9
#> 
#> $conversion
#> [1] NA

strip(iris$Species)
#> $data
#>   [1] level3 level3 level3 level3 level3 level3 level3 level3 level3 level3
#>  [11] level3 level3 level3 level3 level3 level3 level3 level3 level3 level3
#>  [21] level3 level3 level3 level3 level3 level3 level3 level3 level3 level3
#>  [31] level3 level3 level3 level3 level3 level3 level3 level3 level3 level3
#>  [41] level3 level3 level3 level3 level3 level3 level3 level3 level3 level3
#>  [51] level2 level2 level2 level2 level2 level2 level2 level2 level2 level2
#>  [61] level2 level2 level2 level2 level2 level2 level2 level2 level2 level2
#>  [71] level2 level2 level2 level2 level2 level2 level2 level2 level2 level2
#>  [81] level2 level2 level2 level2 level2 level2 level2 level2 level2 level2
#>  [91] level2 level2 level2 level2 level2 level2 level2 level2 level2 level2
#> [101] level1 level1 level1 level1 level1 level1 level1 level1 level1 level1
#> [111] level1 level1 level1 level1 level1 level1 level1 level1 level1 level1
#> [121] level1 level1 level1 level1 level1 level1 level1 level1 level1 level1
#> [131] level1 level1 level1 level1 level1 level1 level1 level1 level1 level1
#> [141] level1 level1 level1 level1 level1 level1 level1 level1 level1 level1
#> Levels: level3 level2 level1
#> 
#> $conversion
#> $conversion$old
#> [1] "setosa"     "versicolor" "virginica" 
#> 
#> $conversion$new
#> [1] "level3" "level2" "level1"

strip(sample(c(TRUE, FALSE), 10, replace = TRUE))
#> $data
#>  [1] "logical1" "logical2" "logical2" "logical1" "logical2" "logical2"
#>  [7] "logical1" "logical1" "logical1" "logical1"
#> 
#> $conversion
#> $conversion$old
#> [1]  TRUE FALSE
#> 
#> $conversion$new
#> [1] "logical1" "logical2"
```

In the final release should be working on full datasets

``` r
out <- purrr::map(iris, strip)
purrr::map_df(out, "data")
#> # A tibble: 150 x 5
#>    Sepal.Length Sepal.Width Petal.Length Petal.Width Species
#>           <dbl>       <dbl>        <dbl>       <dbl> <fct>  
#>  1          5.1         3.5          1.4         0.2 level3 
#>  2          4.9         3            1.4         0.2 level3 
#>  3          4.7         3.2          1.3         0.2 level3 
#>  4          4.6         3.1          1.5         0.2 level3 
#>  5          5           3.6          1.4         0.2 level3 
#>  6          5.4         3.9          1.7         0.4 level3 
#>  7          4.6         3.4          1.4         0.3 level3 
#>  8          5           3.4          1.5         0.2 level3 
#>  9          4.4         2.9          1.4         0.2 level3 
#> 10          4.9         3.1          1.5         0.1 level3 
#> # ... with 140 more rows

purrr::map(out, "conversion")
#> $Sepal.Length
#> [1] NA
#> 
#> $Sepal.Width
#> [1] NA
#> 
#> $Petal.Length
#> [1] NA
#> 
#> $Petal.Width
#> [1] NA
#> 
#> $Species
#> $Species$old
#> [1] "setosa"     "versicolor" "virginica" 
#> 
#> $Species$new
#> [1] "level3" "level2" "level1"
```
