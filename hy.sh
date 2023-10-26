#!/bin/bash

curl -o /etc/systemd/system/hysteria.service https://raw.githubusercontent.com/doube-ba/dobe/main/hysteria.service

curl -o /root/hysteria_config.yaml https://raw.githubusercontent.com/doube-ba/dobe/main/hysteria_config.yaml

curl -Lo hysteria https://github.com/apernet/hysteria/releases/latest/download/hysteria-linux-amd64 && chmod +x hysteria && mv -f hysteria /usr/local/bin/

# 定义要修改的 YAML 文件路径
yaml_file="/root/hysteria_config.yaml"

read -p "请输入端口(端口号前加:): " new_cert_port
# 提示用户输入新的 cert 路径
read -p "请输入新的 cert 路径: " new_cert_path

# 提示用户输入新的 key 路径
read -p "请输入新的 key 路径: " new_key_path

# 使用 sed 命令修改 YAML 文件
sed -i "s|\(listen:\).*|\1 $new_cert_port|" "$yaml_file"
sed -i "s|\(cert:\).*|\1 $new_cert_path|" "$yaml_file"
sed -i "s|\(key:\).*|\1 $new_key_path|" "$yaml_file"

echo "重载systemctl: systemctl daemon-reload"
echo "启动_hysteria: systemctl start hysteria"
echo "重启_hysteria: systemctl restart hysteria"
echo "状态_hysteria: systemctl status hysteria"
