# README

## Faça a instalação do MySQL através do Docker
### Pré-requisito:necessária ter o docker instalado
OBS: caso prefira veja as instruções completas no link abaixo:
https://hub.docker.com/r/mysql/mysql-server/

### Download e instalação da imagem
docker pull mysql/mysql-server:5.7.24

### Inicie a instância
docker run --name=mysql1 -d mysql/mysql-server:5.7.24

### Verifique se o docker foi iniciado corretamente
docker ps

### Execute o comando abaixo para gerar a senha do admin
docker logs mysql1 2>&1 | grep GENERATED

### Faça a troca da senha do root do MySQL
docker exec -it mysql1 mysql -uroot -p

#### OBS: troque a palavra 'password' pela senha desejada.
mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'password';

### Verifique o acesso do user ao db
mysql> SELECT host, user FROM mysql.user;

Procure pelo resultado abaixo:
+-----------+---------------+
| host      | user          |
+-----------+---------------+
| %         | root          |

Caso o acesso root'@' não apareça na tabela execute o comando abaixo:
Caso você esteja rodando um projeto real verifique o nível de segurança adequado!

GRANT ALL ON *.* to root@'%' IDENTIFIED BY 'password';


## Clone este projeto para sua máquina e execute os comandos abaixo:
bundle exec rake db:drop
bundle exec rake db:create
bundle exec rake db:migrate


