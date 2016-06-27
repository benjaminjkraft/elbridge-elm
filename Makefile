
index.html: elm-package.json *.elm
	# TODO: make it as JS, embed in index.html.
	elm make Main.elm --output index.html --warn

clean:
	rm index.html elm.js
