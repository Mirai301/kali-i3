# はじめに
apt経由でインストールするパッケージを調整中 

# 使い方
```
docker build -t <name> ./
```
以下のコマンド実行時に出力されるコンテナIDをメモ
```
docker run -itd --rm <name>
```
```
docker exec -it <CONTAINER_ID> zsh
```
```
┌──(kali㉿hoge)-[~]
└─$ ./rdesktop.sh
```
```
docker run -p "5905:5900" -it --rm example zsh -c 'su - kali'
```
