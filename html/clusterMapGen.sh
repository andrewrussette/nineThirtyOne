#!/bin/bash

# Cluster Map Gen
printf "clusterMapGen\n"

mysqlCommon="mysql -B -N -unineThirtyOne -pnineThirtyOne1# -D denver_accidents -e "
#mysql -B -N -unineThirtyOne -pnineThirtyOne1# -D denver_accidents -e "select LAT,LON from accidents_2017_08 where REPORTED_DATE LIKE '2017-08%';" | awk -F"\t" '{print "new google.maps.LatLng("$1","$2"),"}'

#echo $mysqlCommon

cat /home/flash/Scott/nineThirtyOne/html/googleMaps-ClusterMapHeader.head > /home/flash/Scott/nineThirtyOne/html/2017_08_clusterMap.html ;

echo "" >> /home/flash/Scott/nineThirtyOne/html/2017_08_clusterMap.html ;

$mysqlCommon "select LAT,LON from accidents_2017_08 where REPORTED_DATE LIKE '2017-08%' AND OFFENSE_CODE = '5441';" \
| awk -F"\t" '{print "{lat: "$1", lng:"$2"},"}' \
| tr -d "\n" \
| sed -e 's/,$//' -e 's/},/},\n/g' >> /home/flash/Scott/nineThirtyOne/html/2017_08_clusterMap.html ;

echo " " >> /home/flash/Scott/nineThirtyOne/html/2017_08_clusterMap.html ;

#| awk -F"\t" '{print "{"$1","$2"\},"}' \
#| sed -e 's/,$//' -e 's/},/},\n/g' >> /home/flash/Scott/nineThirtyOne/html/2017_08_clusterMap.html ;

cat /home/flash/Scott/nineThirtyOne/html/googleMaps-ClusterMapFooter.foot >> /home/flash/Scott/nineThirtyOne/html/2017_08_clusterMap.html ;