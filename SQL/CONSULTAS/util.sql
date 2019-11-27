--========================== UTILITARIAS ==========================--

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

-- quantas caronas um usuario fez na ultima semana
select count(*)
from USUARIO
inner join CARONA on USUARIO.cpf = CARONA.cpf_passageiro
where USUARIO.cpf = '11443031496' and datediff(now(), CARONA.data_corrida) <= 7;

-- lista de cpf de motoristas que fizeram alguma corrida
select distinct cpf_motorista from CARONA;

-- lista de cpf de passageiros que fizeram denuncias contra motoristas
select distinct P.cpf 
from PASSAGEIRO as P
inner join DENUNCIA as D on P.cpf = D.cpf_denunciou
inner join MOTORISTA as M on M.cpf = D.cpf_denunciado; 

-- menor preço de caronas feitas por homens com duração x
select min(C.custo)
from CARONA as C 
inner join USUARIO as M on C.cpf_motorista = M.cpf
where M.sexo = 'M' and duracao = '01:00:00';