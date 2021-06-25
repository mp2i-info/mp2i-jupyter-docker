FROM ubuntu

RUN apt-get update # cache busting
RUN apt install -y software-properties-common

RUN add-apt-repository ppa:avsm/ppa
RUN apt-get update && apt-get install -y ocaml opam && apt-get -y install sudo
RUN apt install -y zlib1g-dev libffi-dev libgmp-dev libzmq5-dev pkg-config build-essential python3-pip
RUN apt-get install -y camlp4-extra libcairo2-dev

RUN pip3 install notebook

# RUN useradd -rm -d /home/qf -G sudo -s /bin/bash -u 1001 qf 
# USER qf
# WORKDIR /home/qf

RUN opam init -a -y --disable-sandboxing
RUN opam update 
RUN opam upgrade -y
RUN eval $(opam env)

# ENV PATH="/qf/.local/bin:$PATH"
RUN mkdir -p /home/opam/.jupyter
RUN opam install -y jupyter
# RUN opam install -y jupyter-archimedes
RUN eval $(opam env)
RUN opam exec -- ocaml-jupyter-opam-genspec
RUN jupyter kernelspec install --name ocaml-jupyter /root/.opam/default/share/jupyter
# RUN jupyter kernelspec install --user --name ocaml-jupyter "$(opam config var share)/jupyter"

# RUN conda install xeus-cling -c conda-forge

RUN pip3 install --user sos
RUN pip3 install --user sos-notebook
RUN python3 -m sos_notebook.install

CMD [ "jupyter", "notebook", "--no-browser", "--allow-root", "--ip=*" ]
