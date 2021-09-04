#!/bin/bash

# download cpr and dependencies
echo 'Now downloading dependencies. Sit tight! This might take a few minutes!'
git clone https://github.com/Microsoft/vcpkg.git
cd vcpkg
./bootstrap-vcpkg.sh
./vcpkg integrate install
./vcpkg install cpr
cd ..

# set up build directory
echo 'Now building, compiling, and running project.'
mkdir build
cd build
echo '#!/bin/bash

cmake .. "-DCMAKE_TOOLCHAIN_FILE=../vcpkg/scripts/buildsystems/vcpkg.cmake"
cmake --build .' > build.sh
chmod +x build.sh

./build.sh
echo 'Successfully built! now wrapping up'

cd ..
# confirm and print out confirmation message + instructions.
echo '#!/bin/bash
set -e

cd build
./build.sh
cd ..
./build/main' > build_and_run.sh
chmod +x build_and_run.sh

echo 'From now on, all you have to do to compile, build, and run your project
is to run "./build_and_run.sh" (without the quotes) and hit enter.
If you run into any issues and want to quit out of the program, press the ctrl and c key
at the same time!'

