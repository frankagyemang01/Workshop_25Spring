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

/* Step 1: Create the dataset */
DATA sprint_times;
    INPUT athlete before after;
    DIFF = before - after;  /* Compute the differences */
    DATALINES;
1 11.2 10.8
2 10.9 10.5
3 11.5 11.1
4 12.0 11.4
5 11.8 11.3
6 10.7 10.4
7 11.0 10.6
8 12.2 11.8
;
RUN;

proc print data=sprint_times;
run;


/* Step 2: Perform the Paired t-Test */

PROC TTEST DATA=sprint_times SIDES=L ALPHA=0.05;
    PAIRED before*after;
RUN;









