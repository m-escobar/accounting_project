# README

## Faça a instalação do MySQL através do Docker
### Pré-requisito:necessária ter o docker instalado

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

