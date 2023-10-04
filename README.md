# Xebia DevOps Interview Labs

## Project folders

``` shell
% tree
.
├── README.md
├── coder
│   ├── Dockerfile
│   ├── docker-compose.yaml
│   └── entrypoint.sh
├── dind
│   ├── Dockerfile
│   ├── entrypoint.sh
│   └── prepare-kubeconfig.sh
└── docker-compose.yaml
```

## Run it locally

``` sh
docker compose up --build
```

### Not there yet
This section will be removed when everything is automated.
Entrypoint from dind collides with the entrypoint defined for the project.

``` sh
docker compose up --build
```

On a separate terminal

``` sh
docker compose exec matryoshka sh ./dind/entrypoint.sh
```

