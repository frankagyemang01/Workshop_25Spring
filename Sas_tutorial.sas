/* Reading in Data */
/* Two ways to read in Data - Manually setting up the data Using PROC DATA
- Importing the data */

/* Manual Set Up */
DATA file_name;
  Input variety $ y;
  DATALINES;
    rawhide 14.3
    rawhide 14.5
    rawhide 11.5
    rawhide 13.6
    durum 18.0
    durum 17.8
    durum 12.6
    durum 11.2
    scout 11.0 
    scout 12.1
    scout 10.5
    scout 12.8
   ;
RUN;

PROC PRINT DATA= file_name;
RUN;

/* Reading In Data */
proc import out= work.file_name 
 datafile= "file_path.csv" 
 dbms=csv replace;
 getnames=yes;
 datarow=2; 
run;

/* Proc import: This SAS procedure is used to import external data files (e.g., CSV, Excel, TXT).*/
/* out= work.file_name:  Specifies the output dataset name.*/
/* work.file_name: means the dataset will be stored in the WORK library (temporary storage, deleted when the session ends).*/
/* file_name: is the name of the dataset */
/* datafile="file_path.csv": Specifies the full path of the CSV file you want to import */
/* dbms=csv: Tells SAS that the file format is CSV (Comma-Separated Values).*/
/* getnames=yes: Uses the first row of the CSV file as variable (column) names.*/

data filename;
 infile 'c:\.....\s802e1.txt'; /*file location*/
input patient diet loss ; /* variables under consideration*/
proc print;


PROC SGPLOT DATA= file_name;
    SCATTER X= variety Y= y;
    TITLE "Plot of y and variety";
    XAXIS LABEL="variety";
    YAXIS LABEL="y";
RUN; 

/* Histograms*/
 proc sgplot data= file_name; 
 histogram y; 
 run; 
 proc sgplot;

/* Descriptive Statistics */
 proc univariate data=wheat;
  class loc;
  var yield;      /* computes descriptive statisitcs */
  histogram yield / nrows=3 odstitle="PROC UNIVARIATE with CLASS statement";
  ods select histogram; /* display on the histograms */
run;


/* Analysis of the data */
proc mixed data=file_name method=type3;
class variety;
model y = variety;
run;
/*proc mixed → Calls the MIXED procedure for fitting mixed-effects models.*/
/* method=type3 → Uses Type III Sum of Squares, which is common for unbalanced data in fixed-effects models.*/
/* class variety; → Declares variety as a categorical (class) variable.*/
/*model y = variety; → Defines the linear model*/
/* run; - executes the program */

proc mixed data=file_name method=type3;
class variety;
model y = variety;
lsmeans variety / diff; /* for fixed effects*/
run;


