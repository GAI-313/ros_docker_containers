# jazzy
## container bringup
リポジトリからイメージが Pull されます.
- **CPU**<br>
    ```bash
    docker compose up -d jazzy-cpu
    ```

## container entry
- **CPU**<br>
    ```bash
    docker compose exec jazzy-cpu bash
    ```

## build
```bash
docker build -f Dockerfile.jazzy -t gai313/nakalab_docker:jazzy-base .

```
