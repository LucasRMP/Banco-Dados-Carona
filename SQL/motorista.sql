# ========================== MOTORISTA ========================== #

# -------------------- BUSCAS AUXILIARES --------------------------#

# lista de cpf dos motoristas
select cpf
from MOTORISTA;

# lista de cpf dos passageiros
select cpf
from PASSAGEIRO;

# lista de cpf que fizeram manutenção no ultimo mês
select cpf_dono
from MANUTENCAO inner join VEICULO
on MANUTENCAO.placa_veiculo = VEICULO.placa
where datediff( now(), MANUTENCAO.data_realizacao ) <= 30;


# ---------------------- BUSCAS FINAIS ----------------------------#

# 1 - Que motorista fez manuntenção no seu carro no último mês?
select U.cpf, U.pnome, U.unome, M.num_conta 
from USUARIO as U inner join MOTORISTA as M
on U.cpf = M.cpf
where U.cpf in (select cpf_dono
				from MANUTENCAO inner join VEICULO
				on MANUTENCAO.placa_veiculo = VEICULO.placa
				where datediff( now(), MANUTENCAO.data_realizacao ) <= 30;); 

# 2 - Quantos motorista foram denunciados por um passageiro?
select count(*)
from DENUNCIA as D
inner join MOTORISTA  as M on D.cpf_denunciado = M.cpf
inner join PASSAGEIRO as P on D.cpf_denunciou  = P.cpf;

# 3 - Que motorista dirigiu uma carona cujo veículo tem placa "***"?
select U.cpf, U.pnome, U.unome 
from USUARIO as U
inner join CARONA as C on C.cpf_motorista = U.cpf
where placa_veiculo = 'OGP3609';

# 4 - Qual motorista dirigiu uma carona cuja duração da carona é mais que 2 horas?
select U.pnome, U.unome, U.cpf, M.num_conta
from CARONA as C
inner join MOTORISTA as M on M.cpf = C.cpf_motorista
inner join USUARIO   as U on U.cpf = M.cpf
where timediff(C.duracao, '02:00:00') > '00:00:00';

# 5 - Que motorista fez alguma denúncia cuja descrição da mesma envolva a palavra "assédio"?
select U.pnome, U.unome, U.cpf, M.num_conta
from DENUNCIA as D
inner join MOTORISTA  as M on M.cpf = D.cpf_denunciou
inner join PASSAGEIRO as P on P.cpf = D.cpf_denunciado
inner join USUARIO 	  as U on U.cpf = D.cpf_denunciou
where D.descricao like "%assédio%";