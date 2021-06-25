FROM ubuntu
MAINTAINER Quentin Fortier <qpfortier@gmail.com>

RUN apt-get update # cache busting
RUN apt install -y software-properties-common

RUN add-apt-repository ppa:avsm/ppa
RUN apt-get update && apt-get install -y ocaml opam && apt-get -y install sudo
RUN apt install -y zlib1g-dev libffi-dev libgmp-dev libzmq5-dev pkg-config build-essential python3-pip curl
RUN apt-get install -y camlp4-extra libcairo2-dev
RUN curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -bfp /usr/local \
    && rm -rf /tmp/miniconda.sh 
ENV PATH /opt/conda/bin:$PATH

RUN pip3 install notebook

RUN useradd -rm -d /home/eleve -G sudo -s /bin/bash -u 1001 eleve 
USER eleve
WORKDIR /home/eleve

RUN opam init -a -y --disable-sandboxing
RUN opam update 
RUN opam upgrade -y
RUN eval $(opam env)

RUN opam install -y merlin jupyter
RUN eval $(opam env)
RUN opam exec -- ocaml-jupyter-opam-genspec
RUN jupyter kernelspec install --user --name ocaml-jupyter "$(opam config var share)/jupyter"

RUN pip3 install --user sos
RUN pip3 install --user sos-notebook
RUN python3 -m sos_notebook.install

USER root
RUN conda install -c conda-forge xeus-cling

USER eleve
CMD [ "jupyter", "notebook", "--no-browser", "--ip=*" ]
