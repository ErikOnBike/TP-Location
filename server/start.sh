#!/bin/bash
if [ -f server.image ];
then
	SERVER_URL=ws://localhost:8080/io APP=tool-paradise-location-data CODE_PARADISE_ENV=production node server.js server.image
else
	SERVER_URL=ws://localhost:8080/io APP=tool-paradise-location-data CODE_PARADISE_ENV=development node server.js ../www/app.image
fi
