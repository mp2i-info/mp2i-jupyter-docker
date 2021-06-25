FROM akabe/ocaml-jupyter

RUN sudo pip install jupyter_c_kernel
RUN install_c_kernel --user

CMD [ "jupyter", "notebook", "--no-browser", "--ip=*" ]
