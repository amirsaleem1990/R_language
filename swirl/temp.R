> shape_mat <- sapply(flag_shapes, range)
> shape_mat
# circles crosses saltires quarters sunstars
# [1,]       0       0        0        0        0
# [2,]       4       2        1        4       50


# confirm that shape_mat is a matrix.
> class(shape_mat)
# [1] "matrix"


# As we've seen, sapply() always attempts to simplify the result given by lapply(). It has been successful in doing so for each of the examples we've looked at so far. Let's look at an example where sapply() can't figure out how to simplify the result and thus returns a list, no different from lapply().


# Occasionally, you may need to apply a function that is not yet defined, thus requiring you to write your own.
lapply(unique_vals, function(elem) elem[2]) # return a list containing the second item from each element of the unique_vals list.



11: vapply and tapply
# In the last lesson, you learned about the two most fundamental members of R's *apply family of functions: lapply() and sapply(). Both take a list as input, apply a function to each element of the list, then combine and return the result. lapply() always returns a list, whereas sapply() attempts to simplify the result.

# What if you had forgotten how unique() works and mistakenly thought it returns the *number* of unique values contained in the object passed to it? Then you might have incorrectly expected sapply(flags, unique) to return a numeric vector, since each element of the list returned would contain a single number and sapply() could then simplify the result to a vector.
# When working interactively (at the prompt), this is not much of a problem, since you see the result immediately and will quickly recognize your mistake. However, when working non-interactively (e.g. writing your own functions), a misunderstanding may go undetected and cause incorrect results later on. Therefore, you may wish to be more careful and that's where vapply() is useful
# Whereas sapply() tries to 'guess' the correct format of the result, vapply() allows you to specify it explicitly. If the result doesn't match the format you specify, vapply() will throw an error, causing the operation to stop. This can prevent significant problems in your code that might be caused by getting unexpected return values from sapply().
# vapply(flags, unique, numeric(1)), which says that you expect each element of the result to be a numeric vector of length 1. Since this is NOT actually the case, YOU WILL GET AN ERROR. Once you get the error

# Recall from the previous lesson that sapply(flags, class) will return a character vector containing the class of each column in the dataset.

> sapply(flags, class)
# name   landmass       zone       area population   language   religion       bars    stripes    colours        red      green 
# "factor"  "integer"  "integer"  "integer"  "integer"  "integer"  "integer"  "integer"  "integer"  "integer"  "integer"  "integer" 
# blue       gold      white      black     orange    mainhue    circles    crosses   saltires   quarters   sunstars   crescent 
# "integer"  "integer"  "integer"  "integer"  "integer"   "factor"  "integer"  "integer"  "integer"  "integer"  "integer"  "integer" 
# triangle       icon    animate       text    topleft   botright 
# "integer"  "integer"  "integer"  "integer"   "factor"   "factor" 

# If we wish to be explicit about the format of the result we expect, we can use vapply(flags, class, character(1)). The 'character(1)' argument tells R that we expect the class function to return a character vector of length 1 when applied to EACH column of the flags dataset.

> vapply(flags, class, character(1))
# name   landmass       zone       area population   language   religion       bars    stripes    colours        red      green 
# "factor"  "integer"  "integer"  "integer"  "integer"  "integer"  "integer"  "integer"  "integer"  "integer"  "integer"  "integer" 
# blue       gold      white      black     orange    mainhue    circles    crosses   saltires   quarters   sunstars   crescent 
# "integer"  "integer"  "integer"  "integer"  "integer"   "factor"  "integer"  "integer"  "integer"  "integer"  "integer"  "integer" 
# triangle       icon    animate       text    topleft   botright 
# "integer"  "integer"  "integer"  "integer"   "factor"   "factor" 

# since our expectation was correct (i.e. character(1)), the vapply() result is identical to the sapply() result

# You might think of vapply() as being 'safer' than sapply(), since it requires you to specify the format of the output in advance, instead of just allowing R to 'guess' what you wanted. In addition, vapply() may perform faster than sapply() for large datasets. However, when doing data analysis interactively (at the prompt), sapply() saves you some typing and will often be good enough.

# As a data analyst, you'll often wish to split your data up into groups based on the value of some variable, then apply a function to the members of each group. The next function we'll look at, tapply(), does exactly that.

#  The 'landmass' variable in our dataset takes on integer values between 1 and 6, each of which represents a different part of the world.
> table(flags$landmass)
# 1  2  3  4  5  6 
# 31 17 35 52 39 20 

# The 'animate' variable in our dataset takes the value 1 if a country's flag contains an animate image (e.g. an eagle, a tree, a human hand) and 0 otherwise.
> table(flags$animate)
# 0   1 
# 155  39 

# to apply the mean function to the 'animate' variable separately for each of the six landmass groups, thus giving us the proportion of flags containing an animate image WITHIN each landmass group.
> tapply(flags$animate, flags$landmass, mean)
# 1         2         3         4         5         6 
# 0.4193548 0.1764706 0.1142857 0.1346154 0.1538462 0.3000000 

# we can look at a summary of population values (in round millions) for countries with and without the color red on their flag
> tapply(flags$population, flags$red, summary)
# $`0`
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 0.00    0.00    3.00   27.63    9.00  684.00 
# 
# $`1`
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 0.0     0.0     4.0    22.1    15.0  1008.0 

# to use the same approach to look at a summary of population values for each of the six landmasses.
> tapply(flags$population, flags$landmass, summary)
# $`1`
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 0.00    0.00    0.00   12.29    4.50  231.00 
# 
# $`2`
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 0.00    1.00    6.00   15.71   15.00  119.00 
# 
# $`3`
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 0.00    0.00    8.00   13.86   16.00   61.00 
# 
# $`4`
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 0.000   1.000   5.000   8.788   9.750  56.000 
# 
# $`5`
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 0.00    2.00   10.00   69.18   39.00 1008.00 
# 
# $`6`
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 0.00    0.00    0.00   11.30    1.25  157.00 

