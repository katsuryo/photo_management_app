# README

## 前提
Docker Desktopがインストール済みであること

## 環境構築
```
# Dockerを使用しており、web, dbのコンテナを立ち上げる。dbはmysqlを使用。
# Dockerのビルド〜seed投入まで
  make init
```

## 開発
Makefileにコマンドが記載されている
```
# Run server
  make start
   
# Run server(detached)
  make start-d
  
# Stop server
  make stop

# Down server
  make down
```

## 動作方法
必要なもの: config/credentials/development.key
↑ client_id等の機密情報については、config/credentials/development.yml.encで定義しているためローカルで動作させるためにkeyが必要。

make init により、build ~ seedデータの作成まで済ませる。
```
作成されるユーザ
①ユーザ名: test1, password: password1
②ユーザ名: test2, password: password2

```


make startで、サーバーを立ち上げ、上記ユーザでログイン可能。

注意：すでに検証で、連携アプリにいくつか投稿しているが画像はリポジトリに上げないようignoreしているため参照することはできない。新規で投稿したものについては、public/photos配下に存在するものについては表示可能。

## 保留にしたこと
- UIの調整
- Lint等の調整
- テスト
- エラーページの実装
- エラーハンドリング
- ログ設計
