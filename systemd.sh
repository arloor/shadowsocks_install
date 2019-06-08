#! /bin/bash

# wget --no-check-certificate -O shadowsocks-libev.sh https://raw.githubusercontent.com/arloor/shadowsocks_install/master/systemd.sh
#chmod +x systemd.sh
#./systemd.sh

#删除init.d的服务
service shadowsocks stop  # 停止服务
chkconfig --del shadowsocks  # 删除服务
rm -f /etc/init.d/shadowsocks

#创建service
cat > /lib/systemd/system/ss.service <<EOF
[Unit]
Description=ss-server
Documentation=man:shadowsocks-libev(8)
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
ExecStart=/usr/local/bin/ss-server -c /etc/shadowsocks-libev/config.json
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

systemctl enable ss
systemctl daemon-reload
systemctl start ss


echo "现在使用systemd管理shadowsocks服务"
