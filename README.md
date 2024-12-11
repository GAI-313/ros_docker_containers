# jazzy
## build
- CPU<br>
    ```bash
    docker build -f Dockerfile.jazzy -t gai313/nakalab_docker:jazzy-cpu-base .

    ```

## container bringup
detach
- CPU<br>
    ```bash
    docker compose up -d jazzy-cpu
    ```

## container entry
detach
- CPU<br>
    ```bash
    docker compose exec jazzy-cpu bash
    ```
