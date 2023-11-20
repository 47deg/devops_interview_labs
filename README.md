# Xebia DevOps Interview Labs
## Overview
This project is designed for DevOps interview preparation, offering hands-on
labs and exercises. It's a collection of Docker and Kubernetes-based tasks to
test and enhance DevOps skills.

## Prerequisites
- Docker and Docker Compose
- Basic understanding of Kubernetes

## Installation
1. Clone the repository
``` sh
git clone https://github.com/47deg/devops_interview_labs.git
```

2. Navigate to the cloned directory:
``` sh
cd devops_interview_labs
```


## Project Structure
The project consists of several key directories:

`coder`
: Contains Dockerfiles and scripts for setting up the coding environment.

`dind`
: Docker in Docker related files.

`exercises`
: Lab exercises for hands-on practice.

## Running the Labs
To start the labs, run:

``` sh
docker compose up --build
```

After running, access the coding environment at http://0.0.0.0:5801. The
password is displayed on the terminal.

## Contributing
Contributions to enhance or extend lab exercises are welcome. Please follow the
standard GitHub pull request process.

## License
This project is open-sourced under the Apache License.

## Contact
For questions or feedback, please open an issue in the GitHub repository.
