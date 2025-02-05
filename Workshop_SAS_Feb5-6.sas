*SC3L's Weekly Workshops;
*Title: Getting Started with SAS OnDemand: A Hands-On Introduction;


*Activity 1;
DATA example;
    Input Name $ Age Height;
    DATALINES;
    John 25 5.8
    Sarah 30 5.5
    Mike 28 6.0
    ;
RUN;
PROC PRINT DATA=example;
RUN;


*Activity 2: Importing;
FILENAME REFFILE '/home/u62241626/sasuser.v94/SC3LWorkshop/Dataset1.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=mydata;
	GETNAMES=YES;
RUN;

*Activity 2: Exploring;
PROC CONTENTS DATA=mydata; RUN;

proc print data= mydata; run;


*Activity 2: Exporting;
PROC EXPORT DATA=mydata
    OUTFILE="/home/u62241626/sasuser.v94/SC3LWorkshop/mydataexp.csv"
    DBMS=CSV REPLACE;
 	PUTNAMES=YES;
RUN;


*Activity 3: Instructor;
*Add a new variable;
DATA mydata_add;
    SET mydata;
    Wt_kgs = Wt_lbs * 0.454;
RUN;
PROC PRINT DATA= mydata_add;

*Filter observations;
DATA filtered_data;
    SET mydata_add;
    WHERE Age > 20;
RUN;

PROC PRINT DATA = filtered_data;


*ACTIVITY 4 (Instructor);
PROC SGPLOT DATA=mydata;
    SCATTER X=Ht_in Y=Wt_lbs;
    TITLE "Scatterplot of Height and Weight";
    XAXIS LABEL="Height (inches)";
    YAXIS LABEL="Weight (inches)";
RUN;


*ACTIVITY 4 (Participants);   
PROC SGPLOT DATA=work.mydata;
    VBAR Sex / DATALABEL FILLATTRS=(COLOR=blue);
    TITLE "Bar Chart of Sex";
    XAXIS LABEL="Sex";
    YAXIS LABEL="Frequency";
RUN;

*ACTIVITY 4 (Participants);   
PROC SGPLOT DATA=work.mydata;
    HISTOGRAM Ht_in/BINWIDTH = 0.5;
    TITLE "Histogram of Height";
    XAXIS LABEL="Height";
    YAXIS LABEL="Frequency";
RUN;

*ACTIVITY 5 (Instructor);
PROC MEANS DATA=mydata MEAN MEDIAN STD MIN MAX;
    VAR Ht_in;
RUN;

*ACTIVITY 5 (PARTICIPANTS);
PROC MEANS DATA=mydata MEAN MEDIAN STD MIN MAX;
    VAR Wt_lbs;
    VAR Age;
    VAR BMI;
RUN;

*ACTIVITY 5 (Instructor);
PROC UNIVARIATE DATA=mydata;
VAR Ht_in;
RUN;

*ACTIVITY 5 (PARTICIPANTS);
PROC UNIVARIATE DATA=mydata;
VAR Ht_in;
VAR Wt_lbs;
VAR BMI;
RUN;

*ACTIVITY 5 (Instructor);
PROC FREQ DATA=mydata;
TABLE Sex;
RUN;

*ACTIVITY 5 (Participants);
PROC FREQ DATA=mydata;
TABLES Sex Fav_animal;
RUN;

*ACTIVITY 6 (Instructor);
%MACRO summarize(data=);
    PROC MEANS DATA=&data;
    RUN;
    
%MEND summarize;

%summarize(data=mydata);


*ACTIVITY 6 (PARTICIPANTS);
%MACRO tabulate(data=);
   
    PROC FREQ DATA=&data;
    TABLES _ALL_;
    RUN;
%MEND tabulate;

%tabulate(data=mydata);







