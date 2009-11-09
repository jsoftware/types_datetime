NB. =========================================================
NB. Verbs for date and time arithmetic

NB.*tsPlus v Adds time (y) to timestamp (x)
NB. eg: 2009 2 28 20 30 0 tsPlus 5 0 0     NB. add 5 hours to timestamp
NB. eg: 2009 2 28 20 30 0 tsPlus 34 5 0 0  NB. add 34 days, 5 hours to timestamp
NB. result: array of resulting numeric timestamp(s) in <Y M D h m s> format
NB. y is: array of numeric time(s) to add to x. Format: [[[[[Y] M] D] h] m] s
NB. x is: array of numeric timestamps to add y to. Format: Y [M [D [h [m [s]]]]]
tsPlus=: [: toDateTime@toDayNumber (6&{.@[ + _6&{.@])"1

NB.*tsMinus v Subtract time (y) from timestamp (x)
NB. eg: 2009 3 1 1 30 0 tsMinus 5 0 0   NB. subtract 5 hours from timestamp
NB. result: array of resulting numeric timestamp(s) in <Y M D h m s> format
NB. y is: array of numeric time(s) to subtract from x. Format: [[[[[Y] M] D] h] m] s
NB. x is: array of numeric timestamps to subtract y from. Format: Y [M [D [h [m [s]]]]]
tsMinus=: tsPlus -

NB.*daysDiff v Difference in days from timestamp y to timestamp x
NB. form: endtimestamp daysDiff starttimestamp
NB. result: numeric array of time difference for x-y in <Days.fraction of days> format
NB. y is: numeric start date,time in <Y M D h m s> format
NB. x is: numeric end date,time in <Y M D h m s> format
daysDiff=: -&toDayNumber

NB.tsDiff v Time periods elapsed <Y M D H m s> from timestamp y to timestamp x
NB. form: endtimestamp tsDiff starttimestamp
NB. result: numeric array of time difference for x-y in <Y M D h m s> format
NB. y is: numeric start date,time in <Y M D h m s> format
NB. x is: numeric end date,time in <Y M D h m s> format
tsDiff=: 4 : 0
  r=. -/"2 d=. _12 (_6&([\)) \ , x ,"1 y
  if. #i=. I. (+./"1) 0 > _3{."1 r do. NB. negative time
    n=. <i;2 3 4 5
    r=. (]&.(0 24 60 60&#.) n{r) n} r
  end.
  if. #i=. I. 0 > 2{"1 r do.           NB. negative days
    j=. (-/0=4 100 400 |/ (<i;1;0){d)* 2=m=. (<i;1;1){d
    j=. _1,.j + m{0 31 28 31 30 31 30 31 31 30 31 30 31
    n=. <i;1 2
    r=. (j + n{r) n} r
  end.
  if. #i=. I. 0 > 1{"1 r do.           NB. negative months
    n=. <i;0 1
    r=. (]&.(0 12&#.) n{r) n} r
  end.
  ($y) $, r
)
