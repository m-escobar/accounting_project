# README

## Faça a instalação do MySQL -- utilizei o Docker
### Pré-requisito:necessária ter o docker instalado
OBS: caso prefira veja as instruções completas no link abaixo:
https://hub.docker.com/_/mysql

### Download e inicie a instância
sudo docker run --name mysqlsrv -e MYSQL_ROOT_PASSWORD=1234 -d mysql:latest

### Verifique se o docker foi iniciado corretamente
docker ps

## Clone este projeto para sua máquina e execute os comandos abaixo:
bundle exec rake db:drop
bundle exec rake db:create
bundle exec rake db:migrate

Execute o rails e faça as chamdas da api conforme abaixo. Caso prefira está incluso na raiz do projeto o arquivo 'Insomnia_accounting.json' que pode ser importado no Insomnia e contém os exemplos de chamadas.

O projeto possui as seguintes funcionalidades:
- Criar Conta (post)
- Verificar Saldo (get)
- Efetuar Transferências (post)

Para cada funcionalidade são necessários os seguintes parâmetros:
- Criar Conta - /api/v1/account
  * account_id (opcional)
  * account_name (Nome do proprietário da conta)
  * initial_amount (saldo inicial)
  
    Serão retornadas as informações de {account_id} e {token} (necessário para acessar as outras funções)
    
- Verificar Saldo - /api/v1/balance
  * account_id
  * token
  
    Será retornado {balance}
  
- Efetuar Transferências - /api/v1/transfer
  * source_account_id
  * destination_account_id
  * amount
  * token

