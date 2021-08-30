This is a Docker image to run a Jupyter notebook with OCaml, C++, and Python kernels.

## Prerequisite

- [Docker](https://www.docker.com/)

## Usage

```
docker run -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes -v "${PWD}":/home/jovyan/work qfortier/mp2i:2.0.0
```

Then open the given link.  
[SoS](https://vatlab.github.io/sos-docs/notebook.html) is a kernel for multi-language notebooks.

![jupyter-mp2i](https://user-images.githubusercontent.com/49362475/123551574-afc37d00-d772-11eb-8917-94dc1759a8c2.png)
