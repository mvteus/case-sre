#!/usr/bin/env bash

### CRUD endpoints ###

echo "CRUD endpoints:
(1) Para adicionar endpoints;
(2) Para remover endpoints;
(3) Para listar endpoints."

read crudOption

case "$crudOption" in
    1) echo "Digite o endpoint para adicionar:"
        read endpointToAdd
        sudo echo "- targets: ['$endpointToAdd']" >> /etc/prometheus/prometheus.yml ;;
    2) echo "Digite o endpoint para remover:"
        read endpointToRemove
        sudo sed -i '/$endpointToRemove/d' /etc/prometheus/prometheus.yml ;;
    3) curl http://localhost:9090/api/v1/targets | jq ;;
    *) echo "Opção não encontrada.\n Encerrando." && exit 0 ;;
    # jq é uma ferramenta que faz parsing JSON. Caso não tenha instalado, execute sudo apt install -y jq
esac