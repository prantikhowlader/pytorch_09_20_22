FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04
ARG PYTHON_VERSION=3.7
ARG WITH_TORCHVISION=1

RUN apt-get update && apt-get install -y --no-install-recommends \
         build-essential \
         cmake \
         git \
         curl \
         wget \
         vim \
         ca-certificates \
         libjpeg-dev \
         libpng-dev &&\
     rm -rf /var/lib/apt/lists/*
RUN apt-get install --yes python3-openslide zip libgl1-mesa-glx libgl1-mesa-dev


# ENV PYTHON_VERSION=3.
RUN wget -O ~/miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN chmod +x ~/miniconda.sh
RUN ~/miniconda.sh -b -p /opt/conda
RUN rm ~/miniconda.sh

RUN /opt/conda/bin/conda install -y python=$PYTHON_VERSION numpy pyyaml scipy ipython mkl mkl-include cython typing jupyter pandas gensim scikit-learn matplotlib seaborn hdf5 #&& \
RUN /opt/conda/bin/conda install -y -c magma-cuda100 #&& \
RUN /opt/conda/bin/conda clean -ya
ENV PATH="/opt/conda/bin:${PATH}"
RUN conda install -c conda-forge ninja
# This must be done before pip so that requirements.txt is available
WORKDIR /opt/pytorch
COPY . .

RUN git submodule update --init
#RUN TORCH_CUDA_ARCH_LIST="3.5 5.2 6.0 6.1+PTX" TORCH_NVCC_FLAGS="-Xfatbin -compress-all" \
#    CMAKE_PREFIX_PATH="$(dirname $(which conda))/../" \
#    pip install -v .
RUN apt update
# RUN apt-get install -y sudo
# RUN apt-get install -y zip

RUN conda install pytorch torchvision cudatoolkit=10.1 -c pytorch
#RUN git clone https://github.com/pytorch/vision.git && cd vision && pip install -v .

#RUN pip install --upgrade pip

#RUN pip install -U tensorflow

#RUN pip install tensorboardX

RUN conda install scikit-learn

RUN conda install scikit-image

RUN conda install -c anaconda tensorflow-gpu

RUN conda install -c conda-forge tensorboardx

RUN apt update && apt install -y libsm6 libxext6


# RUN apt-get update && apt-get install -y software-properties-common 
# RUN add-apt-repository ppa:neovim-ppa/stable && apt-get update
# RUN apt-get install -y neovim
#RUN cd ~/
#RUN curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
#RUN chmod u+x nvim.appimage
#RUN mkdir ~/nvim
#RUN mv nvim.appimage ~/nvim/
#RUN echo "alias nvim=~/nvim/nvim.appimage"
#RUN apt-get install neovim
RUN apt-get update && apt-get install -y software-properties-common 
RUN add-apt-repository ppa:neovim-ppa/stable && apt-get update
RUN apt-get install -y neovim
RUN curl https://bootstrap.pypa.io/get-pip.py -o ~/get-pip.py
RUN python ~/get-pip.py
RUN pip install pynvim pep8 flake8 black mypy pyre-check vulture pyflakes pylint isort

RUN pip install git+https://github.com/arraiyopensource/kornia
RUN pip install torchcontrib
RUN pip install six numpy scipy Pillow matplotlib scikit-image opencv-python imageio Shapely filelock networkx nvidia-ml-py3 protobuf PyWavelets PyYAML tifffile jupyterlab
RUN apt-get update
RUN apt-get install ffmpeg libsm6 libxext6  -y
RUN pip install git+https://github.com/aleju/imgaug
RUN pip install -U git+https://github.com/albu/albumentations
RUN conda init
RUN bash ~/.bashrc
#RUN conda install -c conda-forge opencv

#RUN conda install -c conda-forge dlib

RUN pip install openslide-python
RUN pip install kornia
WORKDIR /workspace
RUN chmod -R a+w /workspace 
