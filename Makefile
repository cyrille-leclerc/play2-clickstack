#! /bin/bash
build_dir = ./build
plugin_name = play2-plugin


compile:
	mkdir -p $(build_dir)
	chmod 755 setup
	zip -r $(build_dir)/$(plugin_name).zip setup control/*

package: compile

clean:
	rm -rf $(build_dir)

clean-all: clean
