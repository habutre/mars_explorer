#!/bin/sh

echo "Executing MarsExplorer app"
/app/mars_explorer

echo "Go to http://localhost/MarsExplorer.html to check the project documentation"
nginx -g 'daemon off;'


