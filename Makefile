build:
	sass --update app/assets/styles/application.sass:dist/app/assets/styles/application.css
	coffee -c -o dist/app/assets/scripts app/assets/scripts
	coffee -c -o dist/server server
	mkdir -p dist/app/lib
	haml-coffee -i app/assets/scripts -o dist/app/lib/templates.js
	cp -a app/assets/images dist/app/assets
	cp -a app/lib dist/app
	cp -a app/fonts dist/app
	mkdir -p dist/app/views
	cp -a app/views/index.html dist/app/views/index.html

run: build
	node dist/server/server.js

watch:
	sass --watch app/assets/styles/application.sass:dist/app/assets/styles/application.css &
	coffee -o dist/app/assets/scripts -cw app/assets/scripts &
	coffee -o dist/server -cw server &	
	node dist/server/server.js

clean:
	rm -rf dist