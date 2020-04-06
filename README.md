# README

## Faça a instalação do MySQL através do Docker
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


