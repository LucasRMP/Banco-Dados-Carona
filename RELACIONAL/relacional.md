USUARIO(pnome, unome, telefone, email, **cpf**)

MOTORISTA(num_conta, **cpf**)
MOTORISTA(cpf) REFERENCES USUARIO(cpf)

PASSAGEIRO(num_cartao, **cpf**)
PASSAGEIRO(cpf) REFERENCES USUARIO(cpf)

CARONA(**cpf_motorista**, **cpf_passageiro**, **data_corrida**, av_passageiro, av_motorista, placa_veiculo, custo, duracao, local_destino, local_partida)
CARONA(cpf_motorista) REFERENCES MOTORISTA(cpf)
CARONA(cpf_passageiro) REFERENCES PASSAGEIRO(cpf)

VEICULO(nome, categoria, **placa**, cpf_dono)
VEICULO(cpf_dono) REFERENCES MOTORISTA(cpf)

MANUTENCAO(tipo, descricao, **data_realizacao**, **placa_veiculo**)
MANUTENCAO(placa) REFERENCES VEICULO(placa)

DENUNCIA(descricao, **cpf_denunciado**, **cpf_denunciou**)
DENUNCIA(cpf_denunciado) REFERENCES USUARIO(cpf)
DENUNCIA(cpf_denunciou) REFERENCES USUARIO(cpf)