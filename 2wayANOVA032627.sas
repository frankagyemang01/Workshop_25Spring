*Email @ 'bpoudel2@huskers.unl.edu' for Workshop Presentation document;

*Example 1: All qualitative factors;
*Two brands of fertilizer are applied at low and high levels to individual pots of plants, measuring the height;
*The experiment is replicated 4 times;
*Dataset name: example1-agriculture.csv;
*Response of interest: height;

*Importing the dataset;


FILENAME REFFILE '/home/u62241626/sasuser.v94/SC3LWorkshop/2wayANOVA/example1-agriculture.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=agri;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=agri; RUN;
proc print data= agri;

*Model;
*To obtain the ANOVA table use method=type3;
proc mixed data=agri method=type3;
class rep fertilizer brand;
model height = fertilizer|brand;
lsmeans fertilizer*brand / slice=brand cl pdiff cl;
run;

*to obtain the interaction plot: A neat way to get all necessary information;
proc glimmix data=agri;
class rep fertilizer brand;
model height = fertilizer|brand;
lsmeans fertilizer|brand/slicediff=(fertilizer brand) plots=meanplot(sliceby=brand join cl);
run;
*Significant interaction. Avoid interpreting main effects;


*Example 2: All quantitative factors;
*Effect of pH and salt concentration on bacterial growth;
*Replication: 4 times
*Dataset name: example2-bacteria.csv;
*Response of interest: logcfu;

FILENAME REFFILE '/home/u62241626/sasuser.v94/SC3LWorkshop/2wayANOVA/example2-bacteria.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=bacteria;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=bacteria; RUN;

proc print data=bacteria;run;

/* Model 1: pH and salt as factors to assess trends and trt significance */

proc glimmix data=bacteria;
	class pH salt;
	model logcfu = pH|salt / s htype=3;
	lsmeans pH / plots=meanplot(join) cl;
	lsmeans salt / plots=meanplot(join) cl;
	lsmeans pH*salt / diff plots=meanplot(sliceby=salt join) cl;
run;

*Create and add pH_fct and salt_fct as factor variables of pH and salt in the dataset;
data bacteria;
	set work.bacteria;
	pH_fct = ph;
	salt_fct = salt;
run;
proc print data=bacteria;
run;

/* Model 2: model based off observations of Model 1 */;
proc glimmix data=bacteria;
	class pH_fct salt_fct;
	model logcfu = pH|pH salt / s htype=1;
run;


*Alternative way: Fitting all possible terms;
proc glimmix data=bacteria;
	model logcfu= ph salt ph*ph salt*salt ph*salt ph*salt*salt ph*ph*salt ph*ph*salt*salt/s htype=1;
run;

*Model from Alternative model;
proc glimmix data=bacteria;
	model logcfu= ph salt ph*ph/s htype=1;
run;


*Hence final model;
/* Model 2: model based off observations of Model 1 */;
proc glimmix data=bacteria;
	class pH_fct salt_fct;
	model logcfu = pH|pH salt / s htype=1;
run;

*Required response surface;
data c;
	do pH=6 to 8 by .1; 
		do salt=15 to 25 by 1; 
			logcfu = -6.7233 + 2.2308*pH -0.1475*pH*pH + 0.03242*salt; 
			output; 
		end; 
	end; 
run; 
proc g3d; 
plot pH*salt=logcfu; 
run;













