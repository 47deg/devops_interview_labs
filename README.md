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


Open a browser on http://0.0.0.0:5801 to access your coding environment.
You can find the password on the terminal.
