# webawesome.mk
# Harlan Iverson


#
# Vars
#

DTS_REPO := https://github.com/borisyankov/DefinitelyTyped.git


#
# Client
#


ALL_JS := dist/public/js/all.js
ALL_CSS := dist/public/css/all.css


HBS_JS := dist/public/scripts/hbs.js
CLIENT_JS := dist/public/scripts/client.js

GENERATED_JS := $(HBS_JS) \
			 $(CLIENT_JS) \
			#


#
# Server
#

SERVER_JS := dist/server.js