# microservice-demo
coding challenge from Arcules

Written by Andrew Weimholt
Implemented using node.js and a bash-shell script

app.js was taken from the GCP hello-world tutorial, and modified by me
       to return the output of weather.sh which is called via execSync.

To run this project
1) modify app.js to change the hard-coded path to weather.sh to your chosen location
2) obtain your own key for the googlemaps API and store it in a file called 'googlemaps.key' in the same directory as weather.sh
3) if you intend to redistribute this code, please also modify the DARKSKY_API variable in weather.sh to use your own Dark Sky account.
4) make sure you have node.js, jq, and curl installed
5) type 'node app.js' to run. Listens on port 8081 (change in app.js if desired)

 



  
