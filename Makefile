build:
	arduino \
		--board arduino:avr:leonardo \
		--port ${PORT} \
		--verbose-build \
		--verbose-upload \
		--upload Simple.sketch.cpp

.PHONY: build
