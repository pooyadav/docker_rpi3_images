FROM resin/rpi-raspbian
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils \
wget \
bzip2 \
unzip \
pkg-config \
build-essential \
cmake \
gfortran \
libblas-dev \
liblapack-dev \
libatlas-base-dev \ 
libjpeg8-dev \
libjpeg8 \
libjpeg8-dbg \
libtiff5-dev \
libjasper-dev \
libpng12-dev \
libavcodec-dev \
libavformat-dev \
libswscale-dev \
libv4l-dev \
libxvidcore-dev \
libx264-dev \
libgtk2.0-dev \
python3-dev 
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
wget --quiet https://repo.continuum.io/miniconda/Miniconda-latest-Linux-armv7l.sh -O ~/miniconda.sh && \
bash ~/miniconda.sh -b -p /opt/conda && \
rm ~/miniconda.sh
ENV PATH /opt/conda/bin:$PATH
RUN conda install -n "root" --yes --quiet python=3.4
RUN conda install pip && \
conda install -y pillow && \
conda install -y numpy && \
conda install scipy && \
conda install scikit-learn && \
conda install six && \
conda install pandas 
COPY tensorflow-1.1.0-cp34-cp34m-linux_armv7l.whl .
RUN pip install tensorflow-1.1.0-cp34-cp34m-linux_armv7l.whl


ENV OPENCV_VERSION 3.2.0
# download latest source & contrib
RUN cd /tmp && \
	wget -O opencv.zip https://github.com/opencv/opencv/archive/$OPENCV_VERSION.zip && \
	unzip opencv.zip
	
RUN cd /tmp && \
	wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/$OPENCV_VERSION.zip && \
	unzip opencv_contrib.zip

# build opencv
RUN cd /tmp/opencv-$OPENCV_VERSION && \
	mkdir build && \
	cd build && \
	cmake -D CMAKE_BUILD_TYPE=RELEASE \
	-DCMAKE_INSTALL_PREFIX=$(python3.4 -c "import sys; print(sys.prefix)") \
	-DPYTHON_EXECUTABLE=$(which python3.4) \
	-DPYTHON_INCLUDE_DIR=$(python3.4 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
	-DPYTHON_PACKAGES_PATH=$(python3.4 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
	-DPYTHON3_NUMPY_INCLUDE_DIRS=/opt/conda/lib/python3.4/site-packages/numpy/core/include \
	-D BUILD_PYTHON_SUPPORT=ON \
	-D BUILD_NEW_PYTHON_SUPPORT=ON \
	-D INSTALL_PYTHON_EXAMPLES=ON \
	-D OPENCV_EXTRA_MODULES_PATH=/tmp/opencv_contrib-$OPENCV_VERSION/modules \
	-D BUILD_EXAMPLES=ON .. && \
	make -j4 && \
	make && \
	make install && \
	# ldconfig && \
	make clean
	
# cleanup source
RUN cd /tmp && rm -rf opencv-$OPENCV_VERSION


CMD ["/bin/bash"]
