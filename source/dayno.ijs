NB. =========================================================
NB. Verbs for converting between dates and daynumbers

NB.*toDayNumber v Extends verb "todayno" to handle time
NB. eg: toDayNumber 6!:0 ''
NB. result: numeric array as J daynos, decimals represent time
NB. y is: numeric array in date/time format specified by x
NB. x is: optional boolean specifying input format. Default 0.
NB.      0 : date/time format <yyyy mm dd hh mm ss.sss>
NB.      1 : date/time format <yyyymmdd.hhmmss.sss>
NB. Dates before 1800 1 1 are not supported
toDayNumber=: 3 : 0
  0 toDayNumber y
:
  ymd=. y
  if. x do.                      NB. form <yyyymmdd.hhmmss>
    hms=. 0 100 100 #: 1e_3 round 1e6 * 1||ymd
    ymd=. 0 100 100 #: <.ymd
  else.                          NB. form <yyyy mm dd hh mm ss.sss>
    hms=. 3({."1) 3}."1 ymd
    ymd=. 3{."1 ymd
    hms=. hms + (24 * 1|_1{."1 ymd) (,"1) 0 0  NB. add part day to hours
    ymd=. (* * <.@:|) ymd        NB. truncate part years or months
  end.
  hms=. 86400 %~ 0 60 60 #. hms  NB. to proportion of a day
  dayn=. 0 todayno ymd
  dayn+hms
)

NB.*toDateTime v Extends verb "todate" to handle time
NB. eg: 1 toDateTime toDayNumber 6!:0 ''
NB. result: numeric array in date/time format specified by x
NB. y is: array of J day numbers
NB. x is: optional boolean specifying output format. Default 0.
NB.      0 : date/time format <yyyy mm dd hh mm ss.sss>
NB.      1 : date/time format <yyyymmdd.hhmmss.sss>
NB. Dates before 1800 1 1 are not supported
toDateTime=: 3 : 0
  0 toDateTime y
:
  dayno=. y
  hms=. 1e_3 round 86400 * 1||dayno NB. get any decimal component
  dayno=. <.|dayno        NB. drop any decimal
  ymd=. x todate dayno    NB. get date component from todate
  if. x do.               NB. yyyymmdd.hhmmsssss
    hms=. 1e_6 * 0 100 100#. 0 60 60#: hms  NB. convert to 0.hhmmsssss
    ymd=. ymd + hms
  else.                   NB. yyyy mm dd hh mm ss.sss
    hms=. 0 60 60 #: hms  NB. convert to hh mm ss.sss
    ymd=. ymd ,"1 hms
  end.
  ymd
)

NB.*toJulian v converts J day number to Julian day number
NB. eg: toJulian toDayNumber 6!:0 ''
NB. Dates before 1800 1 1 are not supported
NB. Add another 0.5 to get true Julian Day number where noon is
NB. regarded as the "start" of the day.
toJulian=: +&J0Date

NB.*toJdayno v converts Julian day number to J day number
NB. eg: toJdayno toJulian toDayNumber 6!:0 ''
NB. Dates before 1800 1 1 are not supported
toJdayno=: -&J0Date
