FROM perl:5.24-slim
RUN apt-get update && apt-get install -y \
  g++ \
  libboost-thread-dev \
  libboost-system-dev \
  libboost-filesystem-dev \
  libboost-all-dev \
  libtbb-dev \
  wget \
  make \
  git \
  && mkdir -p /usr/src/ \
  && rm -rf /var/lib/apt/lists/*
WORKDIR /usr/src/
RUN git clone -b 'origin/stable' --single-branch --depth 1 https://github.com/alexrj/Slic3r.git
WORKDIR /usr/src/Slic3r
RUN export LDLOADLIBS=-lstdc++ \
  && perl Build.PL
COPY . .
RUN chmod +x slic3r
ENTRYPOINT [ "/usr/src/Slic3r/slic3r", "--no-gui" ] 
CMD ["--help"]
