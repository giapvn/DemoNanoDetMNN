# How to run NanoDet model with C++ using MNN framework?</br>
Here, we use QtCreator as an IDE with C/C++ on NVIDIA Jetson Nano module.</br>
## Step 1: Prepare environment</br>
- The default version of OpenCV is 4.1.1.</br>
`sudo apt-get install cmake` (required >= 3.10)</br>
`sudo apt-get install libprotobuf-dev protobuf-compiler` (required >= 3.0)</br>
`sudo apt-get install gcc` (required >= 3.0)</br>
`sudo apt-get install libglew-dev`</br>
`sudo ln -s /usr/lib/aarch64-linux-gnu/libGLESv2.so /usr/lib/aarch64-linux-gnu/libGLESv3.so`
## Step 2: Install MNN framework</br>
- Create a directory as the working location for all project related to MNN framework.</br>
```mkdir awl && cd awl```
- Download and build MNN:</br>
```
git clone https://github.com/alibaba/MNN.git
cd MNN
./schema/generate.sh
mkdir build && cd build
cmake -D CMAKE_BUILD_TYPE=Release -D MNN_BUILD_QUANTOOLS=ON -D MNN_BUILD_CONVERTER=ON \
      -D MNN_OPENGL=ON -D MNN_VULKAN=ON -D MNN_CUDA=ON -D MNN_TENSORRT=OFF \
      -D MNN_BUILD_DEMO=ON -D MNN_BUILD_BENCHMARK=ON ..
make -j4
sudo make install
sudo cp ./source/backend/cuda/*.so /usr/local/lib/
sudo cp ./libMNN.so /usr/local/lib/
export LD_LIBRARY_PATH="/usr/local/lib/libMNN.so"
sudo ldconfig
```
## Step 3: Build and run NanoDet MNN with C++</br>
- Go the `awl/` directory and then run command lines as below:</br>
```
git clone https://github.com/RangiLyu/nanodet.git
cd demo_mnn
```
- Download NanoDet model from [this link](https://github.com/RangiLyu/nanodet/releases/download/v1.0.0-alpha-1/nanodet-plus-m_416_mnn.mnn)</br> 
```
wget https://github.com/RangiLyu/nanodet/releases/download/v1.0.0-alpha-1/nanodet-plus-m_416_mnn.mnn
```
- Open and edit `CMakeLists.txt`</br>
```
cmake_minimum_required(VERSION 3.9)
project(nanodet-mnn)

set(CMAKE_CXX_STANDARD 11)

# find_package(OpenCV REQUIRED PATHS "/work/dependence/opencv/opencv-3.4.3/build")
find_package(OpenCV REQUIRED PATHS path_to_OpenCV_build_directory)
include_directories(path_to_MNN_header_files_directory)

link_directories(path_to_MNN_libs_directory)

add_executable(nanodet-mnn main.cpp nanodet_mnn.cpp)
target_link_libraries(nanodet-mnn MNN ${OpenCV_LIBS})
```
- Open and edit `main.cpp` file: Comment this line: `#define __SAVE_RESULT__`</br>
- Build and run MNN:</br>
```
mkdir build && cd build
cmake ..
make -j4
# run NanoDet detector
./nanodet-mnn "1" "path_to_images"
```
- After that we can receive some results as below:</br>
