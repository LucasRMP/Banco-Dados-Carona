drop database CARONEIRO;
create database CARONEIRO;
use CARONEIRO;

create table USUARIO(
  id      char(11) not null,
  sexo     char(1) not null,
  pnome    varchar(30) not null,
  unome    varchar(30) not null,
  telefone char(11),
  email    varchar(40) not null,

  primary key (id)
) ENGINE=InnoDB;

create table DENUNCIA (
  id_denunciado char(11) not null,
  id_denunciou  char(11) not null,
  descricao      varchar(60) not null,

  primary key (id_denunciado, id_denunciou),
  foreign key (id_denunciado) references USUARIO(id),
  foreign key (id_denunciou)  references USUARIO(id)
) ENGINE=InnoDB;

create table MOTORISTA (
  id       char(11) not null,
  num_conta char(16) not null,

  primary key (id),
  foreign key (id) references USUARIO(id)
) ENGINE=InnoDB;

create table PASSAGEIRO (
  id        char(11) not null,
  num_cartao char(16) not null,

  primary key (id),
  foreign key (id) references USUARIO(id)
) ENGINE=InnoDB;

create table VEICULO (
  id     char(7) not null,
  nome      varchar(30),
  categoria varchar(20),
  id_dono  char(11) not null,

  primary key (id),
  foreign key (id_dono) references MOTORISTA(id)
) ENGINE=InnoDB;

create table MANUTENCAO (
  tipo            varchar(20) not null,
  descricao       varchar(60) not null,
  data_realizacao date not null,
  placa_veiculo   char(7) not null,

  primary key (data_realizacao, placa_veiculo),
  foreign key (placa_veiculo) references VEICULO(id)
) ENGINE=InnoDB;

create table CARONA (
  id_motorista   char(11) not null,
  id_passageiro  char(11) not null,
  data_corrida    date not null,
  placa_veiculo   char (7) not null,
  av_motorista    float(2,1) not null,
  av_passageiro   float(2,1) not null,
  duracao         time,
  local_partida   varchar(100) not null,
  local_destino   varchar(100) not null,

  primary key (id_motorista, id_passageiro, data_corrida),
  foreign key (id_motorista) references USUARIO(id),
  foreign key (id_motorista) references USUARIO(id),
  foreign key (placa_veiculo) references VEICULO(id)
) ENGINE=InnoDB;