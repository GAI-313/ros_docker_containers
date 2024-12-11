# ros_docker_containers

> [!CAUTION]
> jazzy-vnc は開発中で、正常に機能しない場合があります。

## container bringup
リポジトリからイメージが Pull されます.
- **MAC**<br>
    ```bash
    docker compose up -d DISTRO-mac
    ```
- **GPU**<br>
    ```bash
    xhost + local:
    docker compose up -d DISTRO-gpu
    ```

## container entry
- **MAC**<br>
    ```bash
    docker compose exec DISTRO-mac bash
    ```
- **GPU**<br>
    ```bash
    docker compose exec DISTRO-gpu bash
    ```

## build
```bash
docker build -f Dockerfile.DISTRO -t gai313/nakalab_docker:DISTRO-base .

```
