#!/bin/bash
ver=1.3
ver2=$ver
rm lib/DynmapCore-*.jar
cp ~/DynmapCore/target/DynmapCore-$ver.jar lib
cp ~/DynmapCoreAPI/target/DynmapCoreAPI-$ver.jar lib
cat Version.java.template | sed s/_VERSION_/$ver2/ > src/minecraft/org/dynmap/forge/Version.java
./recompile.sh
./reobfuscate.sh
rm -r -f zip
mkdir zip
cd zip
unzip ../lib/DynmapCore-$ver.jar
rm -r -f META-INF
unzip ../lib/DynmapCoreAPI-$ver.jar
rm -r -f META-INF
mkdir -p org/dynmap/forge
cp ../reobf/minecraft/org/dynmap/forge/* org/dynmap/forge
cp ../configuration.txt .
cat ../src/minecraft/mcmod.info | sed s/_VERSION_/$ver2/ > mcmod.info 
rm ../Dynmap-$ver.zip
zip -r ../Dynmap-$ver.zip *
cd ..
rm -r -f zip2
mkdir zip2
cd zip2
unzip ~/dynmap/target/dynmap-$ver-bin.zip
rm dynmap.jar
mkdir mods
cp ../Dynmap-$ver.zip mods
echo "var dynmapversion = \"$ver2\";" > dynmap/web/version.js
rm ../dynmap-$ver2-forge-6.5.0.zip
zip -r ../dynmap-$ver2-forge-6.5.0.zip *
cd ..
 
