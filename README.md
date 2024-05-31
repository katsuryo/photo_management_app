# README

## 前提
Docker Desktopがインストール済みであること

## 環境構築
```
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
