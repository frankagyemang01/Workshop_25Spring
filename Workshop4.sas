/* Create the dataset */
DATA apples;
    INPUT weight @@;
    DATALINES;
    198 202 205 197 200 204
    ;
RUN;

/* Perform one-sample t-test */
PROC TTEST DATA=apples H0=200;
    VAR weight;
RUN;


/* Create the dataset */
DATA website_data;
    INPUT Group $ TimeSpent @@;
    DATALINES;
    A 5.2  A 5.1  A 4.9  A 5.3  A 5.0  A 4.8
    B 4.2  B 4.3  B 4.5  B 4.1  B 4.6  B 4.4
    ;
RUN;

/* Perform one-tailed two-sample t-test */
PROC TTEST DATA=website_data SIDES=U;
    CLASS Group;
    VAR TimeSpent;
RUN;


/* Create the dataset */
DATA diet_data;
    INPUT Before After;
    DATALINES;
    85 82
    90 87
    78 76
    88 86
    92 91
    80 78
    ;
RUN;

proc print data=diet_data;
run;

/* Perform the paired t-test */
PROC TTEST DATA=diet_data SIDES=L;
    PAIRED Before*After;
RUN;










