#!/bin/sh

# Remove build directory
cd ..
rm -Rf build/

# Clean and build CocosBuilder
cd CocosBuilder/
xcodebuild -alltargets clean
xcodebuild -target CocosBuilder -configuration Debug build

# Clean and build Plugins
PLUGINSPATH="../PlugIn Nodes/"
cd "$PLUGINSPATH"
for pluginDirName in $(ls .)
do
    if test -d "$pluginDirName"
    then
	cd "$pluginDirName"
	for pluginProject in $(ls *.xcodeproj)
	do
	    if test -d $pluginProject
	    then
		xcodebuild -configuration Debug build
	    fi
	done
	cd ..
    fi
done









