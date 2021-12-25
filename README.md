This is a Docker image to run a Jupyter notebook with OCaml, C++, and Python kernels.

## Prerequisite

- [Docker](https://www.docker.com/)

## Usage

```
docker run -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes -v "${PWD}":/home/jovyan/work qfortier/mp2i:2.0.0
```

Then open the given link.  
[SoS](https://vatlab.github.io/sos-docs/notebook.html) is a kernel for multi-language notebooks.

![jupyter-mp2i](https://user-images.githubusercontent.com/49362475/147386173-c475ca0f-2f8f-467b-87ae-47fbebbd3d36.png)
