#!/bin/bash

# デフォルト値の設定
BUILD_OPTION=""
EXEC_CONTAINER=false
DOWN_OPTION=false

# オプションの解析
if [[ "$#" -eq 0 ]]; then
    # オプションなしの場合
    if docker compose ps | grep -q 'humble'; then
        EXEC_CONTAINER=true
    fi
else
    while [[ "$#" -gt 0 ]]; do
        case $1 in
            -b|--build)
                BUILD_OPTION="--build"
                ;;
            -d|--down)
                DOWN_OPTION=true
                ;;
            -h|--help)
                echo "使い方:"
                echo "  -b, --build  コンテナをビルドする"
                echo "  -d,--down    コンテナを停止"
                echo "  -h, --help   このヘルプを表示する"
                echo "オプションの組み合わせは対応していません"
                exit 0
                ;;
            *)
                echo "ヘルプを表示するには -h または --help"
                echo "不明なオプション: $1" >&2
                exit 1
                ;;
        esac
        shift
    done
fi

# コンテナの操作
if [ $DOWN_OPTION != "true" ]; then
    if $EXEC_CONTAINER; then
        docker compose exec humble /bin/bash
    else
        docker compose up -d $BUILD_OPTION
        docker compose exec humble /bin/bash
    fi
fi

# コンテナの停止と削除
if $DOWN_OPTION; then
    docker compose down
fi
