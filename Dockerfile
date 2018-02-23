FROM resin/rpi-raspbian
RUN apt-get update && apt-get install -y --no-install-recommends \
wget \
bzip2 \
gfortran \
libblas-dev \
liblapack-dev \
libatlas-base-dev
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
wget --quiet https://repo.continuum.io/miniconda/Miniconda-latest-Linux-armv7l.sh -O ~/miniconda.sh && \
bash ~/miniconda.sh -b -p /opt/conda && \
rm ~/miniconda.sh
ENV PATH /opt/conda/bin:$PATH
RUN conda install -n "root" --yes --quiet python=3.4
RUN conda install pip && \
conda install -y pillow
COPY tensorflow-1.1.0-cp34-cp34m-linux_armv7l.whl .
RUN pip install tensorflow-1.1.0-cp34-cp34m-linux_armv7l.whl

