drop   database CARONEIRO;
create database CARONEIRO;

use CARONEIRO;

create table USUARIO(
  cpf      char(11) not null,
  pnome    varchar(30) not null,
  unome    varchar(30) not null,
  telefone char(11),
  email    varchar(40) not null,

  primary key (cpf)
) ENGINE=InnoDB;

create table DENUNCIA (
  cpf_denunciado char(11) not null,
  cpf_denunciou  char(11) not null,
  descricao      varchar(60) not null,

  primary key (cpf_denunciado, cpf_denunciou),
  foreign key (cpf_denunciado) references USUARIO(cpf),
  foreign key (cpf_denunciou)  references USUARIO(cpf)
) ENGINE=InnoDB;

create table MOTORISTA (
  cpf       char(11) not null,
  num_conta char(16) not null,

  primary key (cpf),
  foreign key (cpf) references USUARIO(cpf)
) ENGINE=InnoDB;

create table PASSAGEIRO (
  cpf        char(11) not null,
  num_cartao char(16) not null,

  primary key (cpf),
  foreign key (cpf) references USUARIO(cpf)
) ENGINE=InnoDB;

create table VEICULO (
  placa     char(7) not null,
  nome      varchar(30),
  categoria varchar(20),
  cpf_dono  char(11) not null,

  primary key (placa),
  foreign key (cpf_dono) references MOTORISTA(cpf)
) ENGINE=InnoDB;

create table MANUTENCAO (
  tipo            varchar(20) not null,
  descricao       varchar(60) not null,
  data_realizacao date not null,
  placa_veiculo   char(7) not null,

  primary key (data_realizacao, placa_veiculo),
  foreign key (placa_veiculo) references VEICULO(placa)
) ENGINE=InnoDB;

create table CARONA (
  cpf_motorista   char(11) not null,
  cpf_passageiro  char(11) not null,
  data_corrida    date not null,
  placa_veiculo   char (7) not null,
  av_motorista    float(2,1) not null,
  av_passageiro   float(2,1) not null,
  duracao         time,
  local_partida   varchar(100) not null,
  local_destino   varchar(100) not null,

  primary key (cpf_motorista, cpf_passageiro, data_corrida),
  foreign key (cpf_motorista) references USUARIO(cpf),
  foreign key (cpf_motorista) references USUARIO(cpf),
  foreign key (placa_veiculo) references VEICULO(placa)
) ENGINE=InnoDB;