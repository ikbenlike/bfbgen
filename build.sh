./bin/bf2c $1 --prefix src/gen/prefix.c --postfix src/gen/postfix.c -o src/kernel/kernel/kernel.c
cd src/kernel
make clean
make
mv bfbgen.kernel ../isodir/boot
cd ..
ls
./mk_iso.sh
mv builds/bfbgen.iso ../
