# ros_docker_containers
- devel macOS

 Ubuntu でも利用可能だが、[ubuntu-develブランチ](https://github.com/GAI-313/ros_docker_containers/tree/ubuntu-devel)のほうを使用することを推奨する。

- Windows の方は [windows-devel](https://github.com/GAI-313/ros_docker_containers/tree/windows-devel)を参照してください。
## 前提
- Docker をインストールする
## インストール
```bash
git clone -b mac_devel https://github.com/GAI-313/ros_docker_containers.git
```
## 起動
- humble
    ```bash
    docker compose --env-file humble/.env up --build humble
    ```
- noetic
    ```bash
    docker compose --env-file noetic/.env up --build noetic
    ```
