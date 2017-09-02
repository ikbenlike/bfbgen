./bin/bf2c $1 --prefix src/gen/prefix.c --postfix src/gen/postfix.c -o src/kernel/kernel/kernel.c
cd src/kernel
make
mv bfbgen.kernel ../..
