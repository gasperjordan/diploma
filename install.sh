#! /bin/bash

### Installation of Reconstruction (by Kristian Žarn)

### README ############################################
# Made by Gašper Jordan using Linux Ubuntu 18.04 LTS  #
# with nvidia-driver-460-server (proprietary, tested) #
# GCC-6 and G++-6 compilers needed for colmap build   #
# Administrator privileges required                   #
# Nvidia graphics card with CUDA support needed       #
# sudo bash install.sh to run the script              #
# Intel i7-4700MQ, Nvidia Geforce 745m, 16GB DDR3 RAM #
#######################################################

## TheiaConfig FIX ##############################################
# sudo nano /usr/local/share/Theia/TheiaConfig.cmake  		#
# In the 46th line there should be elseif instead of just else! #
# else (Theia_FIND_REQUIRED) => elseif (Theia_FIND_REQUIRED) 	#
#################################################################


cd "/home/$(whoami)"
mkdir diploma && cd diploma

###################
### Prerequisites #
###################

### GIT
sudo apt-get install -y git
### CMAKE
sudo apt-get install -y cmake
### Compilers
sudo apt-get install -y build-essential





##############################
### THEIA SFM & dependencies #
##############################

### Glog (Ceres)
sudo apt-get install -y libgoogle-glog-dev

### Gflags (Ceres)
sudo apt-get install -y libgflags-dev

### BLAS & LAPACK (Ceres)
sudo apt-get install -y libatlas-base-dev

### Eigen (Ceres)
sudo apt-get install -y libeigen3-dev

### Suitesparse (Ceres)
sudo apt-get install -y libsuitesparse-dev


### Ceres (Theia)
#sudo apt-get -y install libceres-dev
git clone https://ceres-solver.googlesource.com/ceres-solver
cd ceres-solver
git checkout 1.14.0	# baje verzija 2.0.0 uporablja c++14 compiler zato je treba uporabit starejšo
mkdir build
cd build
cmake ..
make -j4
make install
cd ../..



### OpenImageIO (Theia)
sudo apt-get install -y libopenimageio-dev

### RocksDB (Theia)
sudo apt-get install -y librocksdb-dev

### Rapid JSON (Theia)
sudo apt-get install -y rapidjson-dev

### Jpeg (Theia)
sudo apt-get install -y libjpeg-dev

### openGL (Theia)
sudo apt-get install -y libgl1-mesa-dev

### GLUT (Theia)
sudo apt-get install -y freeglut3-dev

### HDF5 (Theia)
sudo apt-get install -y libhdf5-serial-dev


### Theia SfM
echo $'\n\n\n\n Theia SfM \n\n\n\n'
git clone https://github.com/sweeneychris/TheiaSfM.git
cd TheiaSfM
mkdir build
cd build
cmake ..
make -j4
#make test
make install
cd ../..


### CURL
sudo apt-get install -y libcurl4-openssl-dev

### COLMAP
sudo apt-get install -y \
    #libboost-all-dev \
    libboost-program-options-dev \
    libboost-filesystem-dev \
    libboost-graph-dev \
    libboost-system-dev \
    libboost-test-dev \
    libfreeimage-dev \
    libglew-dev \
    qtbase5-dev \
    libqt5opengl5-dev \
    libcgal-dev

### Under Ubuntu 16.04/18.04 the CMake configuration scripts of CGAL are broken and you must also install the CGAL Qt5 package 
sudo apt-get -y install libcgal-qt5-dev

### CUDA - this step requires nvidia drivers (mentioned on top) and nvidia graphics card with CUDA support
sudo apt-get install -y nvidia-cuda-toolkit

### Colmap
echo $'\n\n\n\n Colmap \n\n\n\n'
git clone https://github.com/colmap/colmap.git
cd colmap
git checkout master
mkdir build
cd build
cmake -DCMAKE_C_COMPILER=gcc-6 -DCMAKE_CXX_COMPILER=g++-6 .. # older compiler needed
make -j4
sudo make install
cd ../..


##############################
### OPENMVS & dependencies ###
##############################

sudo apt-get -y install git cmake libpng-dev libjpeg-dev libtiff-dev libglu1-mesa-dev
sudo apt-get -y install libboost-iostreams-dev libboost-program-options-dev libboost-system-dev libboost-serialization-dev
sudo apt-get -y install libopencv-dev
git clone https://github.com/cdcseacave/VCG.git vcglib
sudo apt-get -y install freeglut3-dev libglew-dev libglfw3-dev


### OpenMVS
echo $'\n\n\n\n OpenMVS \n\n\n\n'
git clone https://github.com/cdcseacave/openMVS.git openMVS
mkdir openMVS_build && cd openMVS_build
cmake . ../openMVS -DCMAKE_BUILD_TYPE=Release -DVCG_ROOT="/home/$(whoami)/diploma/vcglib" -DBUILD_SHARED_LIBS=ON #glej 100. vrstico
#If you want to use OpenMVS as shared library, add to the CMake command:
#-DBUILD_SHARED_LIBS=ON
make -j2 && sudo make install

### opencv2 in opecv4 directory - makes link (for Linux Ubuntu 20.04 LTS)
# sudo ln -s ./opencv4/opencv2 ./opencv2
sudo apt-get install -y libglm-dev




####################
### Reconstruction #
####################
echo $'\n\n\n\n Reconstruction \n\n\n\n'
git clone https://github.com/KristianZarn/Reconstruction.git
cd Reconstruction
mkdir build
cd build
cmake ..
make -j4
cd ../..

