FROM jupyter/base-notebook:2021-08-09

USER root

RUN apt-get update && apt install -y software-properties-common && add-apt-repository ppa:avsm/ppa \
    && apt install -y --no-install-recommends zlib1g-dev libffi-dev libgmp-dev libzmq5-dev \
    pkg-config build-essential ocaml opam \
    && rm -rf /var/lib/apt/lists/

USER ${NB_USER}

RUN pip3 install nbgitpuller sos-notebook && \
    fix-permissions "${CONDA_DIR}" "${HOME}"

RUN python3 -m sos_notebook.install && \
    fix-permissions "${CONDA_DIR}" "${HOME}"

RUN conda install -c conda-forge jupyterlab-sos xeus-cling && \
    fix-permissions "${CONDA_DIR}" "${HOME}"

ENV OPAMROOT=${CONDA_DIR}/.opam

RUN opam init -a -y --disable-sandboxing && \
    opam update && \
    opam upgrade -y && \
    fix-permissions "${HOME}" && \
    eval $(opam env) && \
    opam install -y jupyter && \
    opam exec -- ocaml-jupyter-opam-genspec && \
    jupyter kernelspec install --user --name ocaml-jupyter "$(opam var share)/jupyter" && \
    mv "${HOME}/.local/share/jupyter/kernels/ocaml-jupyter"* "${CONDA_DIR}/share/jupyter/kernels/" && \
    chmod -R go+rx "${CONDA_DIR}/share/jupyter" && \
    fix-permissions "${CONDA_DIR}/share/jupyter"

WORKDIR "${HOME}"
