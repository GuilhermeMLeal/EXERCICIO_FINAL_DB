
CREATE DOMAIN boolea AS character(1)
CREATE DOMAIN dm_desc20 AS character varying(20);
CREATE DOMAIN dm_desc50 AS character varying(50);
CREATE DOMAIN dm_nomeclatura AS character varying(50);
CREATE TABLE departamentos (
    nome_departamentodm_desc50 NOT NULL,
    id_departamento integer NOT NULL
);
CREATE TABLE dependentes (
    cpf_pessoa character varying(14) NOT NULL,
    id_funcionario integer,
    dependente_relacao dm_desc20
);
CREATE TABLE faxineiro (
    id_faxineiro integer NOT NULL,
    cargo_faxineiro dm_desc50 NOT NULL,
    jornada_trabalho_limpeza integer NOT NULL,
    chefia integer
);

CREATE TABLE funcionarios (
    id_funcionario integer NOT NULL,
    salario_funcionario numeric(10,2),
    id_departamento integer,
    cpf_funcionario character varying(14)
);

CREATE TABLE pesquisador (
    id_pesquisador integer NOT NULL,
    area_pesquisador public.dm_desc50 NOT NULL
);

CREATE TABLE pessoas (
    sexo_pessoa character(1),
    cpf_pessoa character varying(14) NOT NULL,
    nome_pessoa dm_desc50,
    dia_nascimento integer,
    mes_nascimento integer,
    ano_nascimento integer,
    rua_pessoa dm_desc50,
    numero_casapessoa integer,
    bairro_pessoa character varying(30),
    cep_pessoa character varying(11),
    CONSTRAINT pessoas_ano_nascimento_check CHECK (((ano_nascimento >= 1918) AND (ano_nascimento <= 2023))),
    CONSTRAINT pessoas_cpf_pessoa_check CHECK ((length((cpf_pessoa)::text) = 14)),
    CONSTRAINT pessoas_dia_nascimento_check CHECK (((dia_nascimento >= 1) AND (dia_nascimento <= 31))),
    CONSTRAINT pessoas_mes_nascimento_check CHECK (((mes_nascimento >= 1) AND (mes_nascimento <= 12))),
    CONSTRAINT pessoas_sexo_pessoa_check CHECK ((sexo_pessoa = ANY (ARRAY['M'::bpchar, 'F'::bpchar])))
);

CREATE TABLE projetos (
    nome_projeto dm_desc20,
    id_projeto integer NOT NULL,
    id_departamento integer,
    periodo_projeto integer
);




CREATE TABLE secretario (
    grau_escolaridade dm_desc50 NOT NULL,
    id_secretario integer
);


ALTER TABLE secretario OWNER TO postgres;


CREATE TABLE trabalhar (
    horas_funcionario integer NOT NULL,
    id_pesquisadort integer,
    id_projetot integer
);




INSERT INTO departamentos (nome_departamento, id_departamento) VALUES ('Controle de Qualidade', 1);
INSERT INTO departamentos (nome_departamento, id_departamento) VALUES ('Tecnologia e Sistematização', 2);




INSERT INTO dependentes (cpf_pessoa, id_funcionario, dependente_relacao) VALUES ('239.993.241-00', 10, 'Filho');





INSERT INTO funcionarios (id_funcionario, salario_funcionario, id_departamento, cpf_funcionario) VALUES (10, 9000.00, 1, '239.993.241-00');
INSERT INTO  funcionarios(id_funcionario, salario_funcionario, id_departamento, cpf_funcionario) VALUES (11, 2999.00, 1, '321.321.213-10');
INSERT INTO funcionarios (id_funcionario, salario_funcionario, id_departamento, cpf_funcionario) VALUES (12, 4000.25, 2, '321.321.213-00');




INSERT INTO pesquisador (id_pesquisador, area_pesquisador) VALUES (12, 'Desenvolvedor');


INSERT INTO pessoas (sexo_pessoa, cpf_pessoa, nome_pessoa, dia_nascimento, mes_nascimento, ano_nascimento, rua_pessoa, numero_casapessoa, bairro_pessoa, cep_pessoa) VALUES ('M', '239.993.241-00', 'Guilherme Martins', 11, 2, 2004, 'Rua Euclides da Cunha', 203, 'Jardim Europa', '180.461-55');
INSERT INTO pessoas (sexo_pessoa, cpf_pessoa, nome_pessoa, dia_nascimento, mes_nascimento, ano_nascimento, rua_pessoa, numero_casapessoa, bairro_pessoa, cep_pessoa) VALUES ('F', '321.321.213-10', 'Ana Ana', 2, 3, 2009, 'Rua Marechal Teodoro', 21, 'JD Santo Augusto', '322.321-22');
INSERT INTO pessoas (sexo_pessoa, cpf_pessoa, nome_pessoa, dia_nascimento, mes_nascimento, ano_nascimento, rua_pessoa, numero_casapessoa, bairro_pessoa, cep_pessoa) VALUES ('M', '321.321.213-00', 'Lucas Teodoro', 2, 3, 2009, 'Rua Marechal Teodoro', 21, 'JD Santo Augusto', '321.321-22');




INSERT INTO secretario (grau_escolaridade, id_secretario) VALUES ('Ensino Médio completo', 10);
INSERT INTO secretario (grau_escolaridade, id_secretario) VALUES ('Graduado em Administração', 11);




ALTER TABLE dependentes
    ADD CONSTRAINT id_dependentes PRIMARY KEY (cpf_pessoa) INCLUDE (id_funcionario);



ALTER TABLE pesquisador
    ADD CONSTRAINT id_pesquisador PRIMARY KEY (id_pesquisador);



ALTER TABLE pessoas
    ADD CONSTRAINT pk_cpfpessoa PRIMARY KEY (cpf_pessoa);



ALTER TABLE faxineiro
    ADD CONSTRAINT pk_id_faxineiro PRIMARY KEY (id_faxineiro) INCLUDE (id_faxineiro);




ALTER TABLE ONLY funcionarios
    ADD CONSTRAINT pk_id_funcionario PRIMARY KEY (id_funcionario);



ALTER TABLE departamentos
    ADD CONSTRAINT pk_iddepartamento PRIMARY KEY (id_departamento);




ALTER TABLE projetos
    ADD CONSTRAINT pk_idprojeto PRIMARY KEY (id_projeto);




CREATE INDEX fki_fk_cpf_funcionario ON public.funcionarios USING btree (cpf_funcionario);



ALTER TABLE dependentes
    ADD CONSTRAINT cpf_pessoa FOREIGN KEY (cpf_pessoa) REFERENCES public.pessoas(cpf_pessoa);



ALTER TABLE funcionarios
    ADD CONSTRAINT fk_cpf_funcionario FOREIGN KEY (cpf_funcionario) REFERENCES public.pessoas(cpf_pessoa);




ALTER TABLE faxineiro
    ADD CONSTRAINT fk_id_chefia FOREIGN KEY (chefia) REFERENCES public.funcionarios(id_funcionario);




ALTER TABLE projetos
    ADD CONSTRAINT fk_id_departamento FOREIGN KEY (id_departamento) REFERENCES public.departamentos(id_departamento);




ALTER TABLE funcionarios
    ADD CONSTRAINT fk_id_departamento FOREIGN KEY (id_departamento) REFERENCES public.departamentos(id_departamento);




ALTER TABLE faxineiro
    ADD CONSTRAINT fk_id_faxineiro FOREIGN KEY (id_faxineiro) REFERENCES public.funcionarios(id_funcionario);



ALTER TABLE secretario
    ADD CONSTRAINT fk_id_funcionario FOREIGN KEY (id_secretario) REFERENCES public.funcionarios(id_funcionario);




ALTER TABLE pesquisador
    ADD CONSTRAINT fk_id_pesquisador FOREIGN KEY (id_pesquisador) REFERENCES public.funcionarios(id_funcionario);




ALTER TABLE trabalhar
    ADD CONSTRAINT fk_id_pesquisador FOREIGN KEY (id_pesquisadort) REFERENCES public.pesquisador(id_pesquisador);



ALTER TABLE trabalhar
    ADD CONSTRAINT fk_id_projeto FOREIGN KEY (id_projetot) REFERENCES public.projetos(id_projeto);



ALTER TABLE dependentes
    ADD CONSTRAINT id_funcionario FOREIGN KEY (id_funcionario) REFERENCES public.funcionarios(id_funcionario);



--
SELECT * FROM pessoas;
select * from departamentos;
select * from dependentes;
select * from faxineiroS;
select * from funcionarios;
select * from pesquisadores;
select * from pessoas;
select *from projetos;
select * from trabalhar;
SELECT CPF_PESSOA FROM PESSOAS;
insert into pessoas VALUES('M','166.364.411-52','FEG',01,3,2000,'TUDE',31,'JAR','213914');
insert into pessoas VALUES('M','166.364.411-53','João Tavares',01,3,1999,'Almir Musa Soares',31,'JAR','2139144');
insert into projetos values
('Catraca inteligente',1,2,5),
('Universidade Inteligente',2,3,24);
insert  into dependentes ()
update funcionarios
set quantidade_dependentes=0
where id_funcionario=12;
alter table projetos alter column nome_projeto type varchar(100);
alter table projetos rename column periodo_projeto to periodo_projeto_meses;
insert into pesquisadores values(13,'Modificações robóticas');
insert into trabalhar values (12,13,1);
insert into trabalhar values(13,13,2);
insert into trabalhar values(1,12,2);

SELECT p.nome_pessoa, p.cpf_pessoa, p.sexo_pessoa, f.id_funcionario , f.cpf_funcionario
FROM pessoas p 
INNER JOIN funcionarios f 
ON p.cpf_pessoa = f.cpf_funcionario;

SELECT d.nome_departamento, f.id_funcionario , f.cpf_funcionario
FROM departamentos d  
INNER JOIN funcionarios f 
ON d.id_departamento = f.id_departamento;

SELECT d.cpf_pessoa,d.dependente_relacao, f.id_funcionario , f.cpf_funcionario
FROM dependentes d  
INNER JOIN funcionarios f 
ON d.id_funcionario = f.id_funcionario;

SELECT s.grau_escolaridade, f.id_funcionario , f.cpf_funcionario,pe.nome_pessoa
FROM secretario s 
INNER JOIN funcionarios f 
ON s.id_secretario = f.id_funcionario
INNER JOIN pessoas pe ON f.cpf_funcionario = pe.cpf_pessoa;

SELECT fa.jornada_trabalho_limpeza,fa.chefia,fa.cargo_faxineiro, f.id_funcionario , f.cpf_funcionario,pe.nome_pessoa
FROM faxineiro fa
INNER JOIN funcionarios f 
ON fa.id_faxineiro = f.id_funcionario
INNER JOIN pessoas pe ON f.cpf_funcionario = pe.cpf_pessoa;

SELECT p.area_pesquisador, f.id_funcionario, f.cpf_funcionario, pe.nome_pessoa
FROM pesquisador p
INNER JOIN funcionarios f ON p.id_pesquisador = f.id_funcionario
INNER JOIN pessoas pe ON f.cpf_funcionario = pe.cpf_pessoa;

SELECT * FROM pesquisador;

SELECT p.area_pesquisador,p., f.id_funcionario, f.cpf_funcionario, pe.nome_pessoa
FROM pesquisador p
INNER JOIN funcionarios f ON p.id_pesquisador = f.id_funcionario
INNER JOIN pessoas pe ON f.cpf_funcionario = pe.cpf_pessoa;
