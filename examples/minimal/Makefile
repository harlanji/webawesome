#
# This example assumes webawesome is in a subdirectory with this makefile called 'webawesome'--be it via
# git submodule or otherwise.
#

SSH_CONN := example@example.com
REMOTE_PATH := /home/example/example.com
REMOTE_SERVICE := example.com

include webawesome/vars.mk

ALL_ARTIFACTS := 	dist/public/index.html.gz \
					$(ALL_JS:.js=.min.js).gz \
					$(ALL_CSS:.css=.min.css).gz \
					$(GENERATED_JS) \
					# $(ALL_JS:.js=.min.js).map \
					#

JS_DEPS := 	dist/public/js/libs/thirdparty.js \
			#

CSS_DEPS := 	dist/public/css/thirdparty.css \
				#

TSD_LIBS := 	node \
				express \
				#


include webawesome/targets.mk