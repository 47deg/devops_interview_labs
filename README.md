# Xebia DevOps Interview Labs

## Project folders

``` shell
% tree
.
├── README.md
├── coder
│   ├── Dockerfile
│   ├── docker-compose.yaml
│   └── load-kubeconfig.sh
├── dind
│   ├── Dockerfile
│   ├── entrypoint.sh
│   ├── prepare-kubeconfig.sh
│   └── wait-for-docker.sh
├── docker-compose.yaml
└── exercises
    └── 00-welcome.lab
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

Then you should be able to open a browser on http://0.0.0.0:5801 and see your coding environment ready.
You can find the password on the terminal.
Once `exec` command finish it displays the password.
