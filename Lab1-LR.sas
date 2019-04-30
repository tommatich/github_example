libname class '/home/u37312318/my_courses/nicholassoulakis0/lib/ipps';



proc freq data=class.cms_ipps_2011 order=freq;
	tables DRG_Definition;
	
	
data ipps; set class.cms_ipps_2011;
where index(DRG_Definition,'149') > 0;
run;

data ipps; set class.cms_ipps_2011;
where index(DRG_Definition,'149') > 0
and Provider_State='CA';
run;

/*****************************************/;
*sl reg for average_total_payments/
/****************************************;


ods graphics on;
   
proc reg;
      model Average_Covered_Charges = Average_Total_Payments
	  / ss1 ss2 stb clb;   
   run;
   
ods graphics off;

/*****************************************/;
*sl reg for total_charges/
/****************************************;


ods graphics on;
   
proc reg;
      model Average_Covered_Charges = Total_Discharges
	  / ss1 ss2 stb clb;   
   run;
   
ods graphics off;

/*****************************************/;
*sl reg for average_medicare payments/
/****************************************;


ods graphics on;
   
proc reg;
      model Average_Covered_Charges = Average_Medicare_Payments
	  / ss1 ss2 stb clb;   
   run;
   
ods graphics off;

/*****************************************/
*ml reg with avg. medicare payments and total discharges/
/****************************************;


ods graphics on;
   
proc reg;
      model Average_Covered_Charges = Average_Medicare_Payments Total_Discharges
	  / ss1 ss2 stb clb;   
   run;
   
ods graphics off;

/*****************************************/
*ml reg with avg. medicare payments and avg total payments/
/****************************************;

proc reg;
      model Average_Covered_Charges = Average_Medicare_Payments Average_Total_Payments
	  / ss1 ss2 stb clb;   
   run;
   
ods graphics off;

/*****************************************/
*ml reg with avg. medicare payments and avg total payments and total discharges/
/****************************************;

proc reg;
      model Average_Covered_Charges = Average_Medicare_Payments Average_Total_Payments Total_Discharges
	  / ss1 ss2 stb clb;   
   run;
   
ods graphics off;


data trainipps;
set ipps(firstobs=1 obs=28);
run;


data testipps;
set ipps(firstobs=29 obs=58);
run;

proc glm data=trainipps;
model Average_Covered_Charges = Average_Total_Payments Total_Discharges;
run;
quit;

proc glm data=testipps;
model Average_Covered_Charges = Average_Total_Payments Total_Discharges;
run;
quit;