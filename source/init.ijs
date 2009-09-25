NB. =========================================================
NB. Addon for extending the dates.ijs system script.
NB. Ric Sherlock, 2009 09 09
NB. Some of the verbs in this script were derived from 
NB. APL+Win functions written by Davin Church.

NB. =========================================================
NB. Constants

J0Date=: 2378497   NB. add to J's dayno to get Julian dayno
NB. Note that the start of a Julian day is noon so for an 
NB. accurate representation of a Julian day/time combination 
NB. 2378496.5 should be added instead.

MS0Date=: 36522  NB. add to Microsoft date to get a J dayno.
NB. Note that the first date supported by Microsoft Excel is 1900 1 1
NB. but dates between 1900 1 1 and 1900 1 28 will not convert properly
NB. because Excel incorrectly denotes 1900 as a leap year, 
NB. http://support.microsoft.com/kb/214326
Linux0DateTime=: 62091 NB. add to Linux-style date to get a J dayno

WKDAYS=: ;:'Sunday Monday Tuesday Wednesday Thursday Friday Saturday'
MONTHS=: ''; ;:'January February March April May June July August September October November December'
DATECODES=: ;:'D DD DDD DDDD M MM MMM MMMM YY YYYY'
TIMECODES=: ;:'d h hh m mm s ss sss c cc ccc p pp'
