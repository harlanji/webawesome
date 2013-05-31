# webawesome.mk
# Harlan Iverson


#
# Default target (everything)
#

all: dist/public dist/node_modules $(SERVER_JS) $(ALL_ARTIFACTS)


#
# Project dependencies
#

d.ts:
	tsd install $(TSD_LIBS)

node_modules:
	npm install


#
# Static stuff
#

dist:
	mkdir dist

dist/public: dist public
	cp -R public $@

dist/node_modules: dist node_modules
	cp -R node_modules $@


dist/public/scripts:
	mkdir -p $@


#
# TypeScript -> JS
#

# FIXME separate into server Makefile.
$(SERVER_JS): d.ts src/common/*.ts src/server/*.ts
	tsc --module commonjs --out $@ src/common/*.ts src/server/*.ts

$(CLIENT_JS): d.ts dist/public/scripts src/common/*.ts src/client/*.ts
	tsc --module amd -sourcemap --out $@ src/common/*.ts src/client/*.ts



#
# Handlebars templates -> JS
#

$(HBS_JS): dist/public/scripts src/client/hbs/*.hbs
	# http://stackoverflow.com/questions/12409504/how-can-i-consume-handlebars-command-line-generated-templates-with-ember
	touch $@
	handlebars src/client/hbs/*.hbs -f $@ -k each -k if -k unless
	


#
# Concat JS and Source Maps
#


$(ALL_JS): $(JS_DEPS)
	cat $+ > $@

$(ALL_JS).map: $(ALL_JS) $(CLIENT_JS:.js=.js.map)
	touch $@
	# FIXME translate source maps.. this is clearly wrong!
	#cat $(JS_DEPS:.js=.js.map) $< > $@



#
# Uglify JS and Source Maps
#
$(ALL_JS:.js=.min.js): $(ALL_JS) $(ALL_JS:.js=.js.map)
	uglifyjs $< -o $@ -mc --source-map $@.map # --in-source-map $(ALL_JS:.js=.js.map)

$(ALL_JS:.js=.min.js).map: $(ALL_JS:.js=.min.js)
	# this is handled by uglifyjs
	touch $@



#
# Compile SASS to CSS
#

dist/public/css/client.css: src/client/client.scss
	node-sass $< $@


#
# Minify and Optimize CSS
# Note: CSS maps are coming: https://wiki.mozilla.org/DevTools/Features/CSSSourceMap
#

$(ALL_CSS): dist/public/css/client.css $(CSS_DEPS)
	cat $(CSS_DEPS) $< > $@

$(ALL_CSS:.css=.min.css): $(ALL_CSS)
	csso $< $@


# GZip!

%.gz: %
	gzip -c $< > $@


#
# Utilities / Misc
#

remote: all
	rsync -avz -e ssh dist/* $(SSH_CONN):$(REMOTE_PATH)


remote-restart:
	ssh $(SSH_CONN) "sudo restart $(REMOTE_SERVICE)"
	ssh $(SSH_CONN) "sudo service nginx reload"

ssh:
	ssh -L5858:localhost:5858 -L1337:localhost:1337 -L8080:localhost:8080 $(SSH_CONN)

clean:
	rm -rf dist


#
# Voodoo
#

.DEFAULT_GOAL := all

.PHONY: clean