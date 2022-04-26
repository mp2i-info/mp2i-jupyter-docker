FROM jupyter/base-notebook:2021-08-09

USER root

RUN apt-get update && apt install -y software-properties-common && \
    add-apt-repository ppa:avsm/ppa && \
    apt install -y --no-install-recommends zlib1g-dev libffi-dev libgmp-dev libzmq5-dev libcairo2-dev \
    pkg-config build-essential ocaml opam && \
    rm -rf /var/lib/apt/lists/

USER ${NB_USER}
ENV OPAMROOT=${CONDA_DIR}/.opam

RUN conda install -c conda-forge nbgitpuller xeus-cling && \
    opam init -a -y --disable-sandboxing && \
    opam update && \
    opam upgrade -y && \
    eval $(opam env) && \
    opam install -y jupyter cairo2 graphics archimedes jupyter-archimedes ppx_inline_test batteries core && \
    opam exec -- ocaml-jupyter-opam-genspec && \
    jupyter kernelspec install --user --name ocaml-jupyter "$(opam var share)/jupyter" && \
    rsync -a "${HOME}/.local/share/jupyter/kernels" "${CONDA_DIR}/share/jupyter"

RUN git clone https://github.com/fortierq/mp2i-library.git && \
    opam install -y ./mp2i-library && \
    echo '#use "topfind";;' >> ~/.ocamlinit && \
    echo '#require "mp2i";;' >> ~/.ocamlinit && \
    echo 'open Mp2i;;' >> ~/.ocamlinit

WORKDIR ${HOME}
