#
# This example assumes webawesome is in a subdirectory with this makefile called 'webawesome'--be it via
# git submodule or otherwise.
#

SSH_CONN := example@example.com
REMOTE_PATH := /home/example/example.com
REMOTE_SERVICE := example.com

include webawesome/vars.mk

ALL_ARTIFACTS := 	dist/node_modules \
					dist/server.js \
					dist/public/index.html.gz \
					$(ALL_JS:.js=.min.js).gz \
					$(ALL_CSS:.css=.min.css).gz \
					# $(ALL_JS:.js=.min.js).map \
					#

JS_DEPS := 	dist/public/js/libs/jquery-1.9.1.js \
			dist/public/js/libs/handlebars-1.0.0-rc.3.js \
			dist/public/js/libs/bootstrap.js \
			dist/public/js/libs/ember-latest.js \
			dist/public/js/libs/ember-data-latest.js \
			dist/public/js/libs/require.js \
			#

CSS_DEPS := 	dist/public/css/normalize.css \
				dist/public/css/bootstrap.css \
				dist/public/css/bootstrap-responsive.css \
				#

TSD_LIBS := 	node \
				express \
				connect \
				jquery \
				ember \
				nodemailer \
				#


include webawesome/targets.mk