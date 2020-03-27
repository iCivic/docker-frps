# 内网穿透软件 - frp

经常需要远程连接公司/家里的电脑，有什么办法可以穿透内网防火墙且不借助第三方软件就可以解决这个问题呢？

### Step 1. 购买低配置的云服务器，然后开启端口：80 443 7000 7500

### Step 2. 构建本地镜像
```
docker build -t idu/frps:0.29.0 .
```

### Step 3. 启动服务端容器
```
docker run -d \
--restart=always \
--network host \
-v $PWD/data:/data \
--hostname=frps \
--name frps \
idu/frps:0.29.0
```
### Step 4. 客户端启动windows服务
