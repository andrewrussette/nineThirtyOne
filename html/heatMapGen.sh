#!/bin/bash

# Heat Map Generator
printf "heatMapGen\n"

mysqlCommon="mysql -B -N -unineThirtyOne -pnineThirtyOne1# -D denver_accidents -e "
#mysql -B -N -unineThirtyOne -pnineThirtyOne1# -D denver_accidents -e "select LAT,LON from accidents_2017_08 where REPORTED_DATE LIKE '2017-08%';" | awk -F"\t" '{print "new google.maps.LatLng("$1","$2"),"}'

#echo $mysqlCommon

cat /home/flash/Scott/nineThirtyOne/html/googleMaps-HeatMapHeader.head > /home/flash/Scott/nineThirtyOne/html/2017_08_heatMap.html ;

echo " " >> /home/flash/Scott/nineThirtyOne/html/2017_08_heatMap.html ;

$mysqlCommon "select LAT,LON from accidents_2017_08 where REPORTED_DATE LIKE '2017-08%' AND OFFENSE_CODE = '5441';" \
| awk -F"\t" '{print "new google.maps.LatLng("$1","$2"),"}' \
| tr -d "\n" \
| sed -e 's/,$//' -e 's/,new/,\nnew/g' >> /home/flash/Scott/nineThirtyOne/html/2017_08_heatMap.html ;

echo " " >> /home/flash/Scott/nineThirtyOne/html/2017_08_heatMap.html ;

cat /home/flash/Scott/nineThirtyOne/html/googleMaps-HeatMapFooter.foot >> /home/flash/Scott/nineThirtyOne/html/2017_08_heatMap.html ;