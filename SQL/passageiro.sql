-- ========================== MOTORISTA ========================== --

-- -------------------- BUSCAS AUXILIARES ----------------------------

-- lista de cpf dos motoristas
select cpf
from MOTORISTA;

-- lista de cpf dos passageiros
select cpf
from PASSAGEIRO;

-- lista de cpf que fizeram manutenção no ultimo mês
select cpf_dono
from MANUTENCAO inner join VEICULO
on MANUTENCAO.placa_veiculo = VEICULO.placa
where datediff( now(), MANUTENCAO.data_realizacao ) <= 30;

-- cpf de todos os motoristas que deram carona
select distinct M.cpf
from MOTORISTA as M 
inner join CARONA as C on C.cpf_motorista = M.cpf;

-- ultima manutenção de um veículo
select max(M.data_realizacao)
from MANUTENCAO as M 
inner join VEICULO as V on M.placa_veiculo = V.placa
where V.placa = 'PQN3609';

-- ---------------------- BUSCAS FINAIS ------------------------------

-- 1 - Que passageiro pegou carona no local de partida "***" na data de "***" ?
select U.cpf, U.pnome, U.unome
from USUARIO as U
inner join CARONA as C on C.cpf_passageiro = U.cpf
where C.local_partida = '%%%' and datediff( '%%%', C.data_corrida ) = 0;

-- 2 - Que passageiro pegou carona no veículo de placa "***" e tipo "***" ?
select U.cpf, U.pnome, U.unome
from USUARIO as U
inner join CARONA as C  on C.cpf_passageiro = U.cpf
inner join VEICULO as V on V.placa = C.placa_veiculo
where V.placa = '%%%' and V.tipo = '%%%';

-- 3 - Que passageiro pegou carona com o motorista "***" ?
select P.pnome, P.unome, P.cpf
from CARONA as C
inner join USUARIO as P on C.cpf_passageiro = P.cpf
inner join USUARIO as M on C.cpf_motorista  = M.cpf
where M.pnome = 'Lucas';

-- 4 - Que passageiro pegou carona com um veículo com a manutenção feita a mais de 6 meses atrás ?
select P.pnome, P.unome, P.cpf
from CARONA as C 
inner join USUARIO as P on C.cpf_passageiro = P.cpf
inner join VEICULO as V on C.placa_veiculo  = V.placa
inner join MANUTENCAO as M on V.placa = M.placa_veiculo
where datediff(  )
