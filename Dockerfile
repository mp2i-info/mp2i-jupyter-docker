FROM akabe/ocaml-jupyter:debian8_ocaml4.02.3

RUN pip install --user jupyter_c_kernel
RUN install_c_kernel --user

RUN pip install --user sos
RUN pip install --user sos-notebook
RUN python -m sos_notebook.install

CMD [ "jupyter", "notebook", "--no-browser", "--ip=*" ]
