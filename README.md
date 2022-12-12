# case-sre

## Nível 1

No diretório `nivel01` há dois scripts:
1. `prometheus-config.sh` é responsável por provisionar/configurar a solução prometheus no host;

2. `crud.sh` é um script para adicionar, listar e remover endpoints.

Para complementar a solução, é usada mais duas ferramentas:

1. `jq` (Ferramenta responsável por realizar parsing JSON e exibir no stdout _human readable way_)
```
sudo apt install -y jq
```

2. `promql-cli` (Responsável por executar queries no terminal)
```
wget https://github.com/nalbury/promql-cli/releases/download/v0.2.1/promql-v0.2.1-linux-amd64.tar.gz
```

## **Exemplos de uso**

Neste contexto, estou usando as _metrics_ que o _server_ do `prometheus` dispõe. Para adicionar outros endpoints, basta incluir através do script `crud.sh`.

```
# ./crud.sh
CRUD endpoints:
(1) Para adicionar endpoints;
(2) Para remover endpoints;
(3) Para listar endpoints.
```

Para executar _query_ com o `promql-cli` para _HttpStatusCode_, exemplo abaixo é para _200_:

```
# ./promql-cli --host "localhost:9090" 'rate(promhttp_metric_handler_requests_total{code="200"}[1m])'
```
Para executar _query_ com o `promql-cli` para verificar a _latência do percentil 99_:

```
# ./promql-cli --host "localhost:9090" 'prometheus_target_interval_seconds{quantile="0.99"}'
```

Para mais informações e exemplos de _queries_, o manual do prometheus é o caminho, acesse [aqui](https://prometheus.io/docs/prometheus/latest/querying/basics/).

## Nível 2

No diretório `nivel02` há um script de provisionamento/configuração do docker no host.

Fazer o pull da imagem do `prometheus`:
```
docker pull prom/prometheus
```

+ Descreva como você irá fazer o delivery do container e da solução:

  Uma solução seria a contida [aqui](https://marllus.com/tecnologia/2020/10/14/pipeline-watchtower).

+ Documente como os times de produtos podem adicionar e remover endpoints, com um arquivo de configuração, por exemplo.

  O mesmo script do Nível 1 
  ```
  # ./crush.sh
  CRUD endpoints:
  (1) Para adicionar endpoints;
  (2) Para remover endpoints;
  (3) Para listar endpoints.
  ```

+ Dê exemplos de como coletar todas as métricas com o erro 500 do HTTP por minuto, por exemplo.

  ```
  # ./promql-cli --host "localhost:9090" 'rate(promhttp_metric_handler_requests_total{code="500"}[1m])'
  ```
