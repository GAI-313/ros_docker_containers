# ros_docker_containers
- devel macOS

 Ubuntu でも利用可能だが、[ubuntu-develブランチ](https://github.com/GAI-313/ros_docker_containers/tree/ubuntu-devel)のほうを使用することを推奨する。

- Windows のかたは [windows-devel](https://github.com/GAI-313/ros_docker_containers/tree/windows-devel)を参照してください。
## 前提
- Docker をインストールする
## インストール
```bash
git clone -b mac_devel https://github.com/GAI-313/ros_docker_containers.git
```
## 起動
- 初めて起動するとき、または`Dockerfile`、`docker-compose.yaml`を編集した場合
    ```bash
    ./entry.sh -b
    ```
- 次回起動
    ```bash
    ./entry.sh
    ```
## 終了
```bash
./entry -d
```
## ヘルプ
```bash
./entry.sh -h
```
