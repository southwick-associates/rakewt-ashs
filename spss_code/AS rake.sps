****Be sure that to remove duplicate SGUID-TABLECAT combinations before running!.


***ANGLER SURVEY****.
*RAKE WEIGHTS BASED ON ANGLERS -- 2016 NATIONAL SURVEY*


WEIGHT OFF.
USE ALL.
COMPUTE filter_$=(Tablecat=1).
VARIABLE LABELS filter_$ 'Tablecat1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

SPSSINC RAKE DIM1 = region 1 0.1373 2 0.2004 3 0.0775 4 0.226 5 0.238 6 0.1209
DIM2=agex2 1 0.231 2 0.384 3 0.385
DIM3=hincomex2 1 0.258 2 0.295 3 0.447 
DIM4=fish_avidity 1 0.531 2 0.214 3 0.105 4 0.149
FINALWEIGHT=rake_wt_TC1      
/OPTIONS ITERATIONS=20 CONVERGENCE=.0001 DELTA=.5 SHOW=NO.
EXECUTE.

WEIGHT OFF.
USE ALL.
COMPUTE filter_$=(Tablecat=2).
VARIABLE LABELS filter_$ 'Tablecat2 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

SPSSINC RAKE DIM1 = region 1 0.1373 2 0.2004 3 0.0775 4 0.226 5 0.238 6 0.1209
DIM2=agex2 1 0.231 2 0.384 3 0.385
DIM3=hincomex2 1 0.258 2 0.295 3 0.447 
DIM4=fish_avidity 1 0.531 2 0.214 3 0.105 4 0.149
FINALWEIGHT=rake_wt_TC2      
/OPTIONS ITERATIONS=20 CONVERGENCE=.0001 DELTA=.5 SHOW=NO.
EXECUTE.

WEIGHT OFF.
USE ALL.
COMPUTE filter_$=(Tablecat=3).
VARIABLE LABELS filter_$ 'Tablecat3 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

SPSSINC RAKE DIM1 = region 1 0.1373 2 0.2004 3 0.0775 4 0.226 5 0.238 6 0.1209
DIM2=agex2 1 0.231 2 0.384 3 0.385
DIM3=hincomex2 1 0.258 2 0.295 3 0.447 
DIM4=fish_avidity 1 0.531 2 0.214 3 0.105 4 0.149
FINALWEIGHT=rake_wt_TC3     
/OPTIONS ITERATIONS=20 CONVERGENCE=.0001 DELTA=.5 SHOW=NO.
EXECUTE.

WEIGHT OFF.
USE ALL.
COMPUTE filter_$=(Tablecat=4).
VARIABLE LABELS filter_$ 'Tablecat4 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

SPSSINC RAKE DIM1 = region 1 0.1373 2 0.2004 3 0.0775 4 0.226 5 0.238 6 0.1209
DIM2=agex2 1 0.231 2 0.384 3 0.385
DIM3=hincomex2 1 0.258 2 0.295 3 0.447 
DIM4=fish_avidity 1 0.531 2 0.214 3 0.105 4 0.149
FINALWEIGHT=rake_wt_TC4      
/OPTIONS ITERATIONS=20 CONVERGENCE=.0001 DELTA=.5 SHOW=NO.
EXECUTE.

WEIGHT OFF.
USE ALL.


RECODE rake_wt_TC1 rake_wt_TC2 rake_wt_TC3 rake_wt_TC4 (SYSMIS=0).
EXECUTE.
COMPUTE rake_wt = rake_wt_TC1+rake_wt_TC2+rake_wt_TC3+rake_wt_TC4.
EXECUTE.
RECODE rake_wt (0.00=SYSMIS).
EXECUTE.