FROM ubuntu

RUN apt-get update # cache busting
RUN apt install -y software-properties-common

RUN add-apt-repository ppa:avsm/ppa
RUN apt-get update && apt-get install -y ocaml opam

RUN opam update
RUN opam install -y merlin ocaml-migrate-parsetree jupyter

RUN jupyter kernelspec install --user --name ocaml-jupyter "$(opam config var share)/jupyter"

RUN conda install xeus-cling -c conda-forge

RUN pip3 install --user sos
RUN pip3 install --user sos-notebook
RUN python3 -m sos_notebook.install

CMD [ "jupyter", "notebook", "--no-browser", "--ip=*" ]
