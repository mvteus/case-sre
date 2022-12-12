#!/usr/bin/env bash

### Configurando o Prometheus ###

sudo useradd -M -r -s /bin/false prometheus
sudo mkdir /etc/prometheus /var/lib/prometheuswget https://github.com/prometheus/prometheus/releases/download/v2.40.5/prometheus-2.40.5.linux-amd64.tar.gztar xzf prometheus-2.40.5.linux-amd64.tar.gz prometheus-2.40.5.linux-amd64/
sudo cp prometheus-2.40.5.linux-amd64/{prometheus,promtool} /usr/local/bin/
sudo chown prometheus:prometheus /usr/local/bin/{prometheus,promtool}
sudo cp -r prometheus-2.40.5.linux-amd64/{consoles,console_libraries} /etc/prometheus/
sudo cp prometheus-2.40.5.linux-amd64/prometheus.yml /etc/prometheus/prometheus.yml
sudo chown -R prometheus:prometheus /etc/prometheus
sudo chown prometheus:prometheus /var/lib/prometheus
sudo touch /etc/systemd/sytem/prometheus.service
echo -e "[Unit]
Description=Prometheus Time Series Collection and Processing Server
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \ \n
    --config.file /etc/prometheus/prometheus.yml \ \n
    --storage.tsdb.path /var/lib/prometheus/ \ \n
    --web.console.templates=/etc/prometheus/consoles \ \n
    --web.console.libraries=/etc/prometheus/console_libraries \n
    
[Install]
WantedBy=multi-user.target" >> prometheus.service