CREATE TABLE IF NOT EXISTS pessoa (
    cpf CHAR(11) NOT NULL,
    email VARCHAR(50) NOT NULL,
    nome VARCHAR(150) NOT NULL,
    data_nasc DATE NOT NULL,
    endereco VARCHAR(300) NOT NULL,
    telefone VARCHAR(15) NULL,
    CONSTRAINT pessoa_pk PRIMARY KEY (cpf),
    CONSTRAINT pessoa_un UNIQUE (email, nome)
);


CREATE TABLE IF NOT EXISTS paciente (
    codigo VARCHAR(10) NOT NULL,
    senha VARCHAR(10) NOT NULL,
    cpf CHAR(11) NOT NULL,
    plano_de_saude BOOLEAN NOT NULL,
    CONSTRAINT paciente_pk PRIMARY KEY (codigo),
    CONSTRAINT paciente_cpf_un UNIQUE (cpf),
    CONSTRAINT paciente_pessoa_fk FOREIGN KEY (cpf) REFERENCES pessoa (cpf)
);

CREATE TABLE IF NOT EXISTS medico (
    crm VARCHAR(20) NOT NULL,
    cpf CHAR(11) NOT NULL,
    CONSTRAINT medico_pk PRIMARY KEY (crm),
    CONSTRAINT medico_cpf_un UNIQUE (cpf),
    CONSTRAINT medico_pessoa_fk FOREIGN KEY (cpf) REFERENCES pessoa (cpf)
);

CREATE TABLE IF NOT EXISTS especialidade (
    identificador INT NOT NULL,
    descricao VARCHAR(50) NOT NULL,
    CONSTRAINT especialidade_pk PRIMARY KEY (identificador)
);

CREATE TABLE IF NOT EXISTS medico_especialidade (
    crm VARCHAR(20) NOT NULL,
    identificador INT NOT NULL,
    CONSTRAINT medico_especialidade_pk PRIMARY KEY (crm, identificador),
    CONSTRAINT medico_fk FOREIGN KEY (crm) REFERENCES medico (crm),
    CONSTRAINT especialidade_fk FOREIGN KEY (identificador) REFERENCES especialidade (identificador)
);

CREATE TABLE IF NOT EXISTS agendamento (
    dh_consulta TIMESTAMP NOT NULL,
    dh_agendamento TIMESTAMP NOT NULL,
    valor_consulta NUMERIC(10, 2) NOT NULL,
    crm_medico VARCHAR(20) NOT NULL,
    cod_paciente VARCHAR(10) NOT NULL,
    CONSTRAINT agendamento_pk PRIMARY KEY (cod_paciente, crm_medico, dh_consulta),
    CONSTRAINT agendamento_paciente_fk FOREIGN KEY (cod_paciente) REFERENCES paciente (codigo),
    CONSTRAINT agendamento_medico_fk FOREIGN KEY (crm_medico) REFERENCES medico (crm)
);