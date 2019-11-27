-- ========================== PASSAGEIROS ========================== --

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
where datediff( now(), (
  select max(Ma.data_realizacao)
  from MANUTENCAO as Ma 
  inner join VEICULO as Vi on Ma.placa_veiculo = Vi.placa
  where Vi.placa =  V.placa
)) > 180;

-- 5 - Quantos passageiros denunciaram o motorista cujo cpf é "***"? 
select count(distinct P.cpf) as 'Quantidade'
from DENUNCIA as D 
inner join PASSAGEIRO as P on D.cpf_denunciou = P.cpf
where D.cpf_denunciado = '***';

-- 6 - Que passageiro denunciado alguma vez fez uma denúncia a um motorista?
select distinct P.cpf, U.pnome, U.unome, U.sexo
from PASSAGEIRO as P
inner join USUARIO  as U on U.cpf = P.cpf
inner join DENUNCIA as D on D.cpf_denunciou = P.cpf;

-- 7 - Que passageiro foi denunciado mais de uma vez?
select P.cpf, count(*) as 'count'
from PASSAGEIRO as P
inner join DENUNCIA as D on D.cpf_denunciado = P.cpf
group by P.cpf
having count(P.cpf) > 1;

-- 8 - Que passageiro pegou carona com um veículo que que não fez nenhuma manuntenção?
select P.cpf, U.pnome, U.unome, U.sexo
from PASSAGEIRO as P 
inner join USUARIO as U on U.cpf = P.cpf
inner join CARONA  as C on C.cpf_passageiro = P.cpf
inner join VEICULO as V on C.placa_veiculo  = V.placa 
where V.placa not in (
  select distinct VEICULO.placa
  from VEICULO 
  inner join MANUTENCAO
  on MANUTENCAO.placa_veiculo = VEICULO.placa
);

-- 9 - Que passageiro pegou mais 5 caronas na última semana?
select P.cpf, U.pnome, U.unome, U.sexo
from PASSAGEIRO as P 
inner join USUARIO as U on U.cpf = P.cpf 
inner join CARONA  as C on C.cpf_passageiro = P.cpf
where (
  select count(*)
  from USUARIO
  inner join CARONA on USUARIO.cpf = CARONA.cpf_passageiro
  where USUARIO.cpf = P.cpf and datediff(now(), CARONA.data_corrida) <= 7
) > 5;

-- 10 - Que passageiro pegou carona cujo veículo ultilizado fez uma manutenção cuja descrição envolveu a palavra "ignição"?
select P.cpf, U.pnome, U.unome, U.sexo
from PASSAGEIRO as P 
inner join USUARIO as U on U.cpf = P.cpf
inner join CARONA  as C on C.cpf_passageiro = P.cpf
inner join VEICULO as V on C.placa_veiculo  = V.placa 
inner join MANUTENCAO as M on M.placa_veiculo = V.placa
where M.descricao like "%ignição%";

-- 11 - Que passageiro pegou carona cuja a mesma teve custo entre R$20,00 e R$100,00 em que a avaliação feita por ele foi maior que 1?
select P.cpf, U.pnome, U.unome, U.sexo
from PASSAGEIRO as P 
inner join USUARIO as U on U.cpf = P.cpf
inner join CARONA as C on C.cpf_passageiro = P.cpf
where C.custo between 20.00 and 100.00
and C.av_motorista > 1;

-- 12 - Que passageiro pegou carona cujo o tipo do veículo utilizado foi "***" e a avaliação da mesma foi maior que 4?
select distinct C.cpf_passageiro, U.pnome, U.unome, U.sexo 
from CARONA as C
inner join USUARIO as U on U.cpf = C.cpf_passageiro
inner join VEICULO as V on C.placa_veiculo = V.placa
where V.categoria = '***';

-- 13 - Qual é a media das avaliações dadas por passageiros por sexo?
select U.sexo, avg(C.av_motorista) as 'média'
from CARONA as C
inner join USUARIO as U on U.cpf = C.cpf_passageiro
group by U.sexo;

-- 14 - Qual é o tempo mais rapido, mais lento e o tempo medio de chegada de um passageiro no seu destino?
select min(C.duracao), max(C.duracao), avg(C.duracao)
from CARONA as C;

-- 15 - Quantas passageiras registraram denuncias que envolvem assédio, estupro ou teor sexual no último ano?
select count(distinct cpf_denunciou) as 'quantidade'
from DENUNCIA as D
inner join USUARIO as U on U.cpf = cpf_denunciou
where (D.descricao like '%assédio%' or D.descricao like '%estupro%' or '%sexual%') 
and U.sexo = 'F';

-- 16 - Quantas caronas homens e mulheres pegaram na ultima semana?
select U.sexo as 'sexo', count(*) as 'quantidade'
from CARONA as C 
inner join USUARIO as U on C.cpf_passageiro = U.cpf
group by U.sexo;