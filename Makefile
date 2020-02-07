
all: build

build: pymumble_py3/mumble_pb2.py

clean:
	rm -rf build

.PHONY: all build clean


PROTOFILE_URL:=https://raw.githubusercontent.com/mumble-voip/mumble/master/src/Mumble.proto

build/Mumble.proto:
	mkdir -p $(@D)
	curl -sLo $@ $(PROTOFILE_URL)

build/Mumble_pb2.py: build/Mumble.proto
	protoc --python_out=. $<  # protoc automatically dumps to a "build" subdir

pymumble_py3/mumble_pb2.py: build/Mumble_pb2.py
	cp -f $< $@

.INTERMEDIATE: build/Mumble_pb2.py
