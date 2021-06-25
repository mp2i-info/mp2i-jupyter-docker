FROM ubuntu
MAINTAINER Quentin Fortier <qpfortier@gmail.com>

RUN apt-get update && apt install -y software-properties-common && add-apt-repository ppa:avsm/ppa \
    && apt-get install -y zlib1g-dev libffi-dev libgmp-dev libzmq5-dev pkg-config build-essential curl sudo \
    && apt-get install -y ocaml opam python3-pip  

# RUN apt-get install -y camlp4-extra libcairo2-dev
RUN curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -bfp /usr/local \
    && rm -rf /tmp/miniconda.sh 

RUN pip3 install notebook sos sos-notebook
RUN python3 -m sos_notebook.install

RUN conda install -c conda-forge xeus-cling
ENV PATH /opt/conda/bin:$PATH

RUN useradd -rm -d /home/student -G sudo -s /bin/bash -u 1001 student 
USER student
WORKDIR /home/student

RUN opam init -a -y --disable-sandboxing \
    && opam update \
    && opam upgrade -y \
    && eval $(opam env) \
    && opam install -y merlin jupyter \
    && opam exec -- ocaml-jupyter-opam-genspec \
    && jupyter kernelspec install --user --name ocaml-jupyter "$(opam config var share)/jupyter"

CMD [ "jupyter", "notebook", "--no-browser", "--ip=*" ]
