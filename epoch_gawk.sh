#!/usr/bin/bash
# Author: Alvin Khoo
# Date: 20 May 2013
# Reference: http://stackoverflow.com/questions/16110252/need-to-compare-very-large-files-around-1-5gb-in-python/16112683#16112683
/usr/bin/gawk 'BEGIN{
  OFS = ",";
  COUNT = 0; PREV_TIME=0; EMAIL=0;
  while(( getline line<"sorted_input_data.txt") > 0 ) {
     split(line, a , "\",\"")
     if (EMAIL != a[2]) {
       EMAIL = a[2];
       COUNT = 1;
       PREV_TIME = a[7];
       print line, "1,0 day"
     } else {
       if (PREV_TIME == a[7]) {
         COUNT = COUNT + 1;
         print line, COUNT, "0 day";
       } else {
         DAYS = (a[7] - PREV_TIME)/60/60/24;
         PREV_TIME = a[7];
         COUNT = COUNT + 1;
         print line, COUNT, DAYS " days";
       }
     }
  }
}'
