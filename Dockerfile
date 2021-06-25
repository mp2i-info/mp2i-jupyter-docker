FROM jupyter/base-notebook

RUN pip3 install --user sos
RUN pip3 install --user sos-notebook
RUN python3 -m sos_notebook.install

CMD [ "jupyter", "notebook", "--no-browser", "--ip=*" ]
