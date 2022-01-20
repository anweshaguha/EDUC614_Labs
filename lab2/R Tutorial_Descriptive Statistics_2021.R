###############################################################################
#
#                    Descriptive Statistics using R
#
###############################################################################

####################### Importing Data ########################################

# There are many ways of importing data into R depending on your taste and style. 
# In Lab 1, you practiced how to import data using `Import Dataset` functionality 
# under the Environment tab. If you prefer doing it, go ahead and import the 
# Add.csv file into R following the same instruction in Lab 1. 

# Make sure you name the data object as Add because the rest of the code will 
# assume your data object name in the Environment is Add.

# In addition, I would also like to show you how you can import the same file 
# with base functions using syntax. Below is how you can import the Add.csv file
# using the `read.csv` function. For more information, you can type `?read.csv` 
# in the R console and read more about how to use this function.


  Add <- read.csv(file   = "B:/UO Teaching/EDUC614/Winter21/Week 3/Add.csv",
                  header = TRUE)

    
# Note that "Add <- " indicates that we are asking R to create a new object with
# a name Add using the syntax followed by assignment sign, "<-". 

# There are many arguments `read.csv` function can take. 
# Here, I use two main arguments. The first one is indicating that the location 
# of the file in my computer.
# file = "B:/UO Teaching/EDUC614/Winter21/Week 3/Add.csv" provides the path for 
# R to find the file I want to import. 

# The second argument is "header=TRUE". 
# This argument is a `logical` argument and can take only two values: TRUE or FALSE. 
# In this case, we set header=TRUE` because the first line of the file has the 
# column labels so R reads the first line as column names, then reads the rest 
# of the lines as data. If you run this code in your console, you will see that 
# it imports the file, and you will a new data object created in your Environment.




# You can always do some quick checks when you import a new dataset. 
# You use str() function to check the internal structure of an R object.

  str(Add)


# This indicates that "Add" is a data.frame object, 
# has 88 observations (number of rows) and 8 variables (number of columns). 
# It also provides a list of the variables in this data frame. 
# You can see the name of the variables, type of the variables, and 
# the first few values of the variables.


# You can also explicitly call the names of the columns in this dataset using 
# colnames() function.

  colnames(Add)

# If you want to see the whole data in your Console, you can just type the name 
# of the data object and hit Enter in your Console.

  Add

# It is not always efficient to try to look your whole data in your console.
# You can always run the following code, and it will open your data as a new tab
# next to your Source code. You can't edit or manipulate your data in this tab.
# You can only look at it.

  View(Add)

  
###################### Dealing with Missing Data ###############################

# Suppose, that you have certain values for certain variables that represent missing
  # data. 
  
  # In this dataset, we know that there are two variables with missingness
  # Repeat and Dropout
  
  # 9  and 99 represent missingness for Sex
  # 999 represents missingness for Dropout
  
  # So, I will recode the data such that these values for this particular columns
  # are converted to NA, the internal code R recognizes missingess. 
  
  
# To recode any variable, we can use recode function from the car package.
  
  # First, install the car package to your computer.
    # You have to do it only once.
  
  # install.packages('car')
  
  # Next, you have to load the car package to the R environment
  # You have to do it every time you close and reopen RStudio, and when you need
  # to use a function from the car package
  
  require(car)

    # Alternatively, library(car) does the same thing.
  
  # to learn more about the recode function
  
  ?recode
  
# What we will do is we will create a new column by recoding an already existing
  # variable, using the recode function and providing a coding scheme 
  
  Add$Sex2 <- recode(var     = Add$Sex,
                     recodes = "9 = NA;99 = NA")
  
  
    # Add$Sex2 <- , indicates that we want to create a new column in the Add
    # dataset with a name Sex2 using the following operations
    
  
    # var    = Add$Sex      argument tells R that we want to recode the Sex column in Add dataset
    # recodes = "9=NA;99=NA" argument tells R that we want to recode 9 and 99 as NA
  
  
    # If you check the dataset, you will see that there is a new column appended
    # at the end with a name Sex2, and this column is identical to Sex variable
    # with the exception that 9 and 99 are now coded as NA.
  
     View(Add)
  
# Now, we can do this for the Dropout variable. Remember that 999 represents
     # the missing value for Dropout
     
     Add$Dropout2 <- recode(var     = Add$Dropout,
                            recodes = "999=NA")
    
     # Check the dataset and confirm that there is a Dropout2 variable
     # at the end identical to original Dropout variable with the exception that
     # 999 is now coded as NA
     
  # From now on, when you analyze this data, note that you have to use the recoded
     # version of Sex and Dropout variables, not the original ones as they will
     # be misleading due to 9, 99, 999.
  
     
####################### Categorical Variables ##################################
     
# When you import a dataset, some categorical variables are labeled using strings,
# e.g. Yes/No, TRUE/FALSE, Asian/White/Hispanic/AmericanIndian/...
     
# Most of the times, however, you will see numeric codes for these variables, and
# R recognizes them as numbers, which is not appropriate.
     
# For instance, in this dataset, Repeat is coded as 0 and 1, and 0 means did not repeat,
# while 1 means repeated. Or, SocProb is also coded as 0 and 1, and 0 means No while
# 1 means Yes. 
     
# If you run str() on Add, you will see that all these variables are simply recognized
     # as a numeric or integer variable
     
     str(Add)
     
# You should always consider converting them to Factor before you move forward 
# with your analysis, as Factors are the accurate representation of categorical
# variables to R.
     
# We can convert any numeric variable to a Factor using the factor function.
     
# What we will do is we will create a new column by converting the numeric version
# of these variables to factors by creating and appending a new column to the dataset.
# I will add .f extension for the new variable names so we can distinguish them
# from the original one.
     
     
# Let's start with Sex. In this dataset, Sex is coded as 1=male,2=female. Note that
# I will use Sex2 as it is already a cleaner version with missing values replaced.
     
     Add$Sex.f <- factor(x      = Add$Sex2,
                         levels = c(1,2),
                         labels = c('Male','Female'))
     
      # Note that Add$Sex.f <- at the beginning indicates I am creating and 
      # appending a new variable to the dataset with a name Sex.f
     
      # inside the function, there are three arguments:
     
        # x = Add$Sex2, this is the original numeric variables I want to convert
        # to a factor
     
        # levels = c(1,2), this indicates that the original numeric variable 
        # contains two values in the dataset 1 and 2
     
        # labels = c('Male','Female'), this indicates the matching labels I want
        # to use for 1 and 2. These labels are arbitrary. For instance, instead,
        # you can say labels = c('M','F'), and 1 and 2 will be represented by
        # M and F labels, respectively. It is up to you.
     
        # After you run the code above, View your data and compare the Sex.f
        # column to Sex2 variable.
     
         View(Add)
     
            # You should see that all 1s are now Male, and All 2s are now Female.
         
         
         # Also, if you run str(Add) now, you should notice the new variable
         # you compute (Sex.f) is recognized as a Factor with 2 levels. So,
         # R recognized it as a categorical variable with 2 levels, and treat
         # it as such for all analysis.
         
         str(Add)
     
# Similarly, I will convert all categorical variables in the dataset by creating
# and appending a new variable at the end.
         
         
         Add$Repeat.f <- factor(x      = Add$Repeat,
                                levels = c(0,1),
                                labels = c('No','Yes'))
         
         
         
         Add$SocProb.f <- factor(x     = Add$SocProb,
                                levels = c(0,1),
                                labels = c('No','Yes'))
         
         
         Add$Dropout.f <- factor(x     = Add$Dropout2,
                                levels = c(0,1),
                                labels = c('No','Yes'))
         
         
     # Check the dataset with the new variables
         
         View(Add)
     
         
         str(Add)
     
############## Indexing into a Data Frame ######################################

# Sometimes, you just want to call certain elements from the data frame instead
# of looking at the whole data.

# For instance let's say you want to see the value on Row 32 column 6 in your data set.

  Add[32,6]
         
# This will turn 2.25. It indicates that the value for the variable in the 6th 
# column (which is GPA) for the individual on Row 32 is 2.25.

# Notice how we index the data frame using double brackets 

# [i,j]

# So, the index value before comma inside the double brackets (i) refers to the 
# row number while the index value after comma inside the double brackets refers
# to the column number. 

# See another example

  Add[10,8]

  # This should return the value in your dataset for the 10th individual (Row 10),
  # on the 8th column variable(Dropout)

# Sometimes you want to call all values in a row. If that's the case, then you
# can leave the space after comma inside double brackets empty.

# For instance, the syntax below will print all the values on the third row
# in your console as a vector

  Add[3,]

# Or, you can similarly call all values in a column. If that's the case, then you
# can leave the space before comma inside double brackets empty.

# For instance, the syntax below will print all the values on the 6th column (GPA)
# in your console as a vector

  Add[,6]

# When you want to call all the values in a column, you can also do it using the
# column label. 

  Add$GPA

  # Notice that I first put the name of the data object and then type a $ sign
  # After that, I simply typed the name of column


# There is another way of calling the same column

  Add[,'GPA']
  

# So, all these three different ways do the same thing and call the values
# of 6th column in the data frame.

    # Add[,6]
    # Add[,'GPA']
    # Add$GPA


# Sometimes, you just want to see a certain segment of data.
# For instance, let's say you want to see the the data from Row 10 to Row 20,
# and Column 2 to Column 5

  Add[10:20, 2:5]

  # 10:20 before comma indicates that we request Row 10 to Row 20
  # 2:5 after comma indicates that we request Column 2 to Column 5
  
  # So, this returns a certain segment of the whole dataset
  

# What if the rows and columns you would like to see are not consecutive?
# For instance, let's say you want to see Row 5, Row 10, Row 35, and Row 80
  
  Add[c(5,10,35,80),]
  
  # Notice that c(5,10,35,80) before comma inside the brackets provides
  # a list of row numbers I want. c() is special way in R to create a vector
  # of numbers
  
  # There is no number specified after comma inside the brackets, so it means
  # we request R to give all the columns in the data
  
  # You can also run it by itself
  
  c(5,10,35,80)
  
    # This is printing a vector with four elements in the console
    # When this goes inside a double brackets before comma, it means Row 5, 10,
    # 35, and 80
  
  
# We can do the same thing with columns.
# For instance, let's say you want to see Column 1, Column 2, and Column 6
  
  Add[,c(1,2,6)]
  
  # Notice that c(1,2,6) after comma inside the brackets provides
  # a list of column numbers I want. 
  # There is no number specified before comma inside the brackets, so it means
  # we request R to give all the rows in the data
  

# You can combine these two approaches.
# For instance, let's say you want to see Row 5, Row 10, Row 35, and Row 80
# and Column 1, Column 2, and Column 6
  
  Add[c(5,10,35,80),c(1,2,6)]
  
  # Notice that c(5,10,35,80) before comma inside the brackets provides
  # a list of row numbers I want and c(1,2,6) after comma inside the brackets 
  # provides a list of column numbers I want. 
  
 
  # There is another way of doing the same thing.
  
  Add[c(5,10,35,80),c('CaseNum','ADDSC','GPA')]

    # Instead of column numbers, I can just list the column names (with quotes) 
    # after comma inside the bracket
  

################# Computing Descriptive Statistics #############################
  

# There are many ways in R to calculate descriptive statistics. 
# The one I most like is the describe() function from the psych package. 
  
# The code below will install the psych package into your computer. 
  # You have to do it only once.
  
 # install.packages('psych')
  
# Next, you have to load the package to the R environment
  # You have to do it every time you close and reopen RStudio
  
  require(psych)

    # Alternatively, library(psych) does the same thing.
  
# Once you load the psych package into your Environment, you can now work with
  # all the function available in the package.
  
  # to learn more about the describe function
  
  ?describe

# Note that it only make sense to compute descriptive variables for numeric
# variables.

# Suppose you want to compute the descriptive statistics for GPA variable
  
  # all three versions below will only provide the descriptive statistics for 
  # GPA in this dataset
  
  describe(Add$GPA)

  describe(Add[,'GPA'])
  
  describe(Add[,6])
  
  # This will provide a number of descriptive statistics 
  # You can see sample size(n), mean, standard deviation (sd), median, minimum
  # value (min), maximum value (max), range, skewness (skew), and kurtosis.
  
# Or, you can compute the descriptive statistics for many variables.
  # Suppose you want to compute the descriptive statistics for ADDSC, GPA, and 
  # IQ variables in this dataset
  
  # The two version below will only provide the descriptive statistics for the 
  # listed variables
  
  describe(Add[,c('GPA','IQ','ADDSC')])
  
  describe(Add[,c(2,5,6)])
  
  
  
  
# Sometimes, you may want to compute conditional statistics.
  # For instance, suppose you want to compute the descriptive statistics of GPA
  # for students with and without Social Problems seperately.
  
  # You can use describeBy() function from the psych package. Learn more about
  # this function
  
  ?describeBy
  
  # Compute the desriprive statistics of GPA for students with and without social
  # problems
  
  describeBy(x     = Add$GPA,
             group = Add$SocProb.f)
  
    # Here, I use two arguments for describeBy() function
  
    # x = Add$GPA, specifies the outcome variable you want to compute desc. stats
    # group = Add$Dropout.f, specifies the grouping variable
  
  
  # Or, you can do the same thing for multiple variables.
  
  
  describeBy(x     = Add[,c('GPA','IQ','ADDSC')],
             group = Add$SocProb.f)
  
  
# If you want to compute quartiles (25th percentile, 50th percentile, and 
  # 75th percentile), you can use the quantile() function.
  
  ?quantile
  
  # Suppose you want to compute Q1 (25th), Q2 (50th), and Q3 (75th) for GPA
  
  
  quantile(x     = Add$GPA,
           probs = c(.25,.50,.75))
  
    # This will give you the first, second, and third quartiles.
  
  

# If you want to compute the frequencies for categorical variables, you can 
# use the table() function
  
  table(Add$Sex.f)
    
    # This indicates that there are 51 individuals in the datasets coded as Male,
    # and 31 individuals coded as Female.
  
  table(Add$SocProb.f)
  
    # This indicates that there are 78 individuals with no social problem,
    # and 10 individuals with social problem.
  

# You can use table() function to get frequencies for numeric variables as well.
  # However, it will typically return a messy table for large sample sizes.
  
  table(Add$GPA)
  
# If you want to create z-scores for numeric variables you can use scale()
  # function. Below syntax will create and append new variables for standardized
  # scores for numeric variables in the data
  
  scale()
  
  Add$GPA.z   <- scale(Add$GPA)
  
  Add$IQ.z    <- scale(Add$IQ)
  
  Add$ADDSC.z <- scale(Add$ADDSC)
  
  
  # Check the data
  
    View(Add)

  # Check the descriptive statistics for the standardized variables  
  
    describe(Add[,c('GPA.z','IQ.z','ADDSC.z')])
  
############################# Histogram #######################################
    
# You can use hist() function to create a histogram and impose a normal density 
    # on it.
    
    # Learn more about the hist function
    
    ?hist

    # Create a histogram of GPA
    
    hist(x      = Add$GPA,
         freq   = TRUE,
         col    = 'white',
         border = 'black',
         xlab   = 'Grade Point Average',
         main   = 'My first histogram')

    
      # You can change the fill color and border color, you can use any HEX value.
      # https://htmlcolorcodes.com/
    
          
          hist(x      = Add$GPA,
               freq   = TRUE,
               col    = '#BECA31',
               border = '#3152CA',
               xlab   = 'Grade Point Average',
               main   = 'My first histogram')
          
# If you want to impose a normal curve on the histogram, first, you change the 
# freq argument to FALSE. This modifies the Y-axis, so it doesn't represent
# frequency, and instead represent probability densities.

          hist(x      = Add$GPA,
               freq   = FALSE,
               col    = '#BECA31',
               border = '#3152CA',
               xlab   = 'Grade Point Average',
               main   = 'My first histogram')
     
        # then add the normal density with the same mean and std obtained from
          # GPA
          
          curve(expr = dnorm(x, mean=2.46, sd=0.86), 
                col  = "darkblue", 
                add=TRUE)
    
    
############################## Boxplot #########################################
          
# You can use hist() function to create a histogram and impose a normal density 
# on it.
          
  # Learn more about the hist function
          
      ?boxplot
          
  # Create a histogram of GPA
      
      boxplot(x       = Add$GPA,
              main    = 'My first boxplot',
              xlab    = 'Grade Point Average',
              col     = 'white')
          
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    






