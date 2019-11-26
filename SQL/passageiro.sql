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

# 1 - Que passageiro pegou carona no local de partida "***" na data de "***" ?
select U.cpf, U.pnome, U.unome
from USUARIO as U
inner join CARONA as C on C.cpf_passageiro = U.cpf
where C.local_partida = '%%%' and datediff( '%%%', C.data_corrida ) = 0;

# 2 - Que passageiro pegou carona no veículo de placa "***" e tipo "***" ?
select U.cpf, U.pnome, U.unome
from USUARIO as U
inner join CARONA as C  on C.cpf_passageiro = U.cpf
inner join VEICULO as V on V.placa = C.placa_veiculo
where V.placa = '%%%' and V.tipo = '%%%';

# 3 - Que passageiro pegou carona com o motorista "***" ?
 