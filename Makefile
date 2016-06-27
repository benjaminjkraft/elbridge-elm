
build/elm.js: elm-package.json src/*.elm
	# TODO: make it as JS, embed in index.html.
	elm make src/Main.elm --output build/elm.js --warn

clean:
	rm build/elm.js
