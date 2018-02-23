#!/bin/bash
#
#

SCRIPTDIR=`dirname ${BASH_SOURCE[0]}`
GOOGLE_MAPS_API="https://maps.googleapis.com/maps/api/geocode/json"
GOOGLE_MAPS_KEY=`cat ${SCRIPTDIR}/googlemaps.key`
DARKSKY_API="https://api.darksky.net/forecast/77db57efdc25dd0156609225bca84f19"
DARKSKY_LINK="https://darksky.net/poweredby/"

# 
# default values
#

LAT=33.3333
LNG=-117.7777

#
# convert raw location to LAT,LNG 
#

MAP_RESULTS=""
RAW_LOCATION=`echo $* |sed s/\ /+/g`
[ -z ${RAW_LOCATION} ] || MAP_RESULTS=`curl -s ${GOOGLE_MAPS_API}?address=${RAW_LOCATION}&key=${GOOGLE_MAPS_KEY}`
if [ ! -z "${MAP_RESULTS}" ];then
  LAT=`echo ${MAP_RESULTS}|jq -r '.results[0].geometry.location.lat'`
  LNG=`echo ${MAP_RESULTS}|jq -r '.results[0].geometry.location.lng'`
fi
LOCATION="${LAT},${LNG}"

#
# Get Current Date in Second since Epoch format
#

CURRDATE=`date +%s`

#
# output HTML
#

echo -e "<HTML><BODY><H3><FONT face=\"courier\">"

echo -e "Past Week's Weather @ ${LOCATION} : ${*}<BR><BR>"

for DAYS in 6 5 4 3 2 1 0
do
	DATE=$((${CURRDATE}-${DAYS}*86400))
        EXCLUDE="currently,minutely,hourly,alerts,flags"
        JSON=`curl -s ${DARKSKY_API}/${LOCATION},${DATE}?exclude=${EXCLUDE}`
	TIMEZONE=`echo $JSON|jq -r '.timezone'`
        SUMMARY=`echo  $JSON|jq -r '.daily.data[0].summary'`
        echo -e `TZ=${TIMEZONE} date --date=@${DATE}` "&nbsp;&nbsp;&nbsp;" ${SUMMARY}
	echo -e "<br>"
done

echo -e "<br><br><a href=\"${DARKSKY_LINK}\">Powered by Dark Sky</a><br>"

echo -e "</FONT></H2></BODY></HTML>"

