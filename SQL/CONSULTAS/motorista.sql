--========================== MOTORISTA ==========================--

-- 1 - Que motorista fez manuntenção no seu carro no último mês?
select U.cpf, U.pnome, U.unome, M.num_conta
from USUARIO as U inner join MOTORISTA as M
on U.cpf = M.cpf
where U.cpf in (select cpf_dono
from MANUTENCAO inner join VEICULO
on MANUTENCAO.placa_veiculo = VEICULO.placa
where datediff( now(), MANUTENCAO.data_realizacao ) <= 30); 

-- 2 - Quantos motorista foram denunciados por um passageiro?
select count(*)
from DENUNCIA as D
where D.cpf_denunciado in (select distinct cpf from MOTORISTA)
and D.cpf_denunciou in (select distinct cpf from PASSAGEIRO);

-- 3 - Que motorista dirigiu uma carona cujo veículo tem placa "***"?
select U.cpf, U.pnome, U.unome 
from USUARIO as U
inner join CARONA as C on C.cpf_motorista = U.cpf
where placa_veiculo = '607oqp';

-- 4 - Qual motorista dirigiu uma carona cuja duração da carona é mais que 2 horas?
select U.pnome, U.unome, U.cpf, M.num_conta
from CARONA as C
inner join MOTORISTA as M on M.cpf = C.cpf_motorista
inner join USUARIO   as U on U.cpf = M.cpf
where timediff(C.duracao, '02:00:00') > '00:00:00';

-- 5 - Que motorista fez alguma denúncia cuja descrição da mesma envolva a palavra "assédio"?
select U.pnome, U.unome, U.cpf, M.num_conta
from DENUNCIA as D
inner join MOTORISTA  as M on M.cpf = D.cpf_denunciou
inner join USUARIO 	  as U on U.cpf = D.cpf_denunciou
where D.descricao like "%assédio%";

-- 6 - Que motorista dirigiram em caronas mais caras do que a média do dia no dia "***"?
select U.pnome, U.unome, U.cpf, M.num_conta
from CARONA as C
inner join MOTORISTA as M on M.cpf = C.cpf_motorista
inner join USUARIO   as U on U.cpf = M.cpf
where C.custo > (
  select avg(custo)
  from CARONA
  where data_corrida = "***"
);

-- 7 - Que motorista não fez nenhuma carona da no último mês?
select U.pnome, U.unome, U.cpf, M.num_conta
from MOTORISTA as M 
inner join USUARIO as U on U.cpf = M.cpf
where U.cpf not in (select distinct cpf_motorista from CARONA);

-- 8 - Que motorista cujo custo da carona ultrapassou R$100,00 para uma duração de 1 hora?
select U.pnome, U.unome, U.cpf, M.num_conta
from MOTORISTA as M 
inner join USUARIO as U on U.cpf = M.cpf
inner join CARONA  as C on C.cpf_motorista = M.cpf
where C.custo > 100.0;
and timediff(C.duracao, '01:00:00') < 0;

-- 9 - Que motorista dirigiu uma carona pegada por um passageiro que fez alguma denúnia a outro motorista?
select M.pnome, M.unome, M.cpf
from CARONA as C 
inner join USUARIO as M on M.cpf = C.cpf_motorista
inner join PASSAGEIRO as P on P.cpf = C.cpf_passageiro
where P.cpf in (
  select distinct Pa.cpf 
  from PASSAGEIRO as Pa
  inner join DENUNCIA as De on Pa.cpf = De.cpf_denunciou
  inner join MOTORISTA as Mo on Mo.cpf = De.cpf_denunciado
);

-- 10 - Que motorista possui o veículo que foi utilizado na carona da data "***" e que recebeu uma denuncia cuja descrição envolveu a palavra "custo" ou "preço"?
select U.pnome, U.unome, U.cpf
from USUARIO as U 
inner join MOTORISTA as M on M.cpf = U.cpf
inner join CARONA as C on C.cpf_motorista = M.cpf
inner join DENUNCIA as D on D.cpf_denunciado = M.cpf
where C.data_corrida = now()
and (D.descricao like "%custo%" or D.descricao like "%preço%")
and D.cpf_denunciado = M.cpf;

-- 11 - Que motoristas do sexo masculino dirigiram uma carona cujo custo dessa última foi maior que alguma carona com a mesma duração cuja motorista é mulher?
select M.pnome, M.unome, M.cpf
from USUARIO as M 
inner join CARONA as C on C.cpf_motorista = M.cpf
where M.sexo = 'M'
and C.custo > any (
  select Ca.custo
  from USUARIO as Us
  inner join CARONA as Ca on Us.cpf = Ca.cpf_passageiro
  where Us.sexo = 'F'
  and Ca.duracao = C.duracao
);

-- 12 - Quantos motoristas foram denunciados por usuarios do mesmo sexo?
select M.sexo as 'Sexo', count(*) as 'qtd'
from USUARIO as M 
inner join CARONA as C   on C.cpf_motorista = M.cpf 
inner join DENUNCIA as D on D.cpf_denunciado = M.cpf
inner join USUARIO as P  on D.cpf_denunciou = P.cpf 
where P.sexo = M.sexo
group by M.sexo;

-- 13 - Que motoristas cadrastrados na plataforma pegou carona alguma vez com outro motorista cadrastrado na plataforma?
select U.pnome, U.unome, U.cpf
from USUARIO as U 
inner join MOTORISTA as M on M.cpf = U.cpf
inner join PASSAGEIRO as P on P.cpf = U.cpf;

-- 14 - Em números absolutos e percentualmente, quantos quantos motoristas do sexo masculino e do sexo feminino estão cadrastrados na plataforma?
select 
  U.sexo as 'Sexo', 
  count(*) as 'Quantidade', 
  (count(*) / (select count(cpf) from MOTORISTA))*100 as 'Porcentagem'
from MOTORISTA as M 
inner join USUARIO as U on U.cpf = M.cpf 
group by U.sexo;

-- 15 - Que motorista dirigiu carona somente para passageiros do mesmo sexo que o seu?
select M.cpf, M.pnome, M.unome, M.sexo
from CARONA as C 
inner join USUARIO as M on M.cpf = C.cpf_motorista
inner join USUARIO as P on P.cpf = C.cpf_passageiro
where M.sexo = P.sexo;
