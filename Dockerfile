FROM rabits/qt:5.14-desktop

LABEL IMAGE_NAME=""
LABEL MAINTAINER=""

RUN sudo apt update \
   && sudo apt install -y --no-install-recommends \
      g++ \
      wget \
      gfortran \
      zlib1g-dev \
      libfftw3-dev \
      liblapack-dev \
      libopenblas-dev \
      ca-certificates \
   && sudo apt clean 
   #&& rm -rf /var/lib/apt/lists/*

RUN sudo update-ca-certificates

WORKDIR /home/user
RUN wget --no-check-certificate "https://www.geopsy.org/download/archives/geopsypack-src-3.4.2.tar.gz"
RUN tar -xf geopsypack-src-3.4.2.tar.gz 
RUN rm geopsypack-src-3.4.2.tar.gz 
RUN mkdir geopsy 

WORKDIR /home/user/geopsypack-src-3.4.2 
RUN ./configure -prefix /home/user/geopsy/ -march native --accept-license
RUN make
RUN sudo make install

WORKDIR /home/user
RUN rm -rf geopsypack-src-3.4.2

ENV PATH=/home/user/geopsy/bin/:$PATH
