# ros_docker_containers

Mac、Linux に対応したコンテナを用意しています。

- [macOS](#mac)
    - [VNC](#vnc)
    - [CUI](#cui)
- [Linux](#linux)
    - [CPU](#cpu)
    - [GPU](#gpu)

サポートしているディストロは以下の通りです。
- jazzy
- iron
- humble
- foxy
- noetic

<a id='mac'></a>
## macOS

<a id='vnc'></a>
### VNC
- 事前に **Xquartz** をインストールする必要があります。

サービス `<DISTRO>-vnc` を起動します
```bash
docker compose up <DISTRO>-vnc
```
起動後、**http://127.0.0.1:6080** にアクセスするとデスクトップにアクセスできます。

<a id='cui'></a>
### CUI
サービス `<DISTRO>-mac` を起動します
```bash
docker compose up <DISTRO>-mac
```

<a id='linux'></a>
## Linux

<a id='cpu'></a>
### CPU
サービス `<DISTRO>-base` を起動します
```bash
xhost + local:
docker compose up <DISTRO>-base
```
X11 フォアーディングが有効な場合、自動的にコンテナ用 Terminator が起動します。

<a id='gpu'></a>'
### GPU

- CUDA ドライバー、Container Tool Kit を事前にセットアップしてください。

サービス `<DISTRO>-gpu` を起動します
```bash
xhost + local:
docker compose up <DISTRO>-gpu
```
X11 フォアーディングが有効な場合、自動的にコンテナ用 Terminator が起動します。

## ビルド
最小構成 ROS を構築する場合
```bash
docker build -f Dockerfile.DISTRO -t gai313/nakalab_docker:DISTRO-base .
```
ROS-desktop を構築する場合
```bash
docker build -f Dockerfile.DISTRO -t gai313/nakalab_docker:DISTRO-desktop --build-arg REPO=desktop .
```
