--------------------------
--TABELAS
--------------------------
CREATE TABLE CLIENTE (
    cod_cliente NUMBER NOT NULL,
    nome VARCHAR2(100) NOT NULL,
    data_cadastro DATE NOT NULL,
    tipo CHAR(1) NOT NULL,
    PRIMARY KEY (cod_cliente),
    CHECK (tipo IN ('F','J'))
);

CREATE TABLE PESSOA_JURIDICA (
    cod_cliente NUMBER NOT NULL,
    cnpj CHAR(18) NOT NULL,
    razao_social VARCHAR2(100) NOT NULL,
    PRIMARY KEY (cod_cliente),
    UNIQUE (cnpj),
    FOREIGN KEY (cod_cliente) REFERENCES CLIENTE (cod_cliente)
);

CREATE TABLE PESSOA_FISICA (
    cod_cliente NUMBER NOT NULL,
    cpf CHAR(14) NOT NULL,
    data_nascimento DATE NOT NULL,
    genero CHAR(1) NOT NULL,
    cod_empresa NUMBER,
    PRIMARY KEY (cod_cliente),
    UNIQUE (cpf),
    CHECK (genero IN ('F','M')),
    FOREIGN KEY (cod_cliente) REFERENCES CLIENTE (cod_cliente),
    FOREIGN KEY (cod_empresa) REFERENCES PESSOA_JURIDICA (cod_cliente)
);

CREATE TABLE ESTADO (
    uf CHAR(2) NOT NULL,
    nome VARCHAR2(50) NOT NULL,
    regiao CHAR(2) NOT NULL,
    PRIMARY KEY (uf),
    CHECK (regiao IN ('S','SE','CO','NE','N'))
);

CREATE TABLE CIDADE (
    cod_cidade NUMBER NOT NULL,
    nome VARCHAR2(80) NOT NULL,
    uf CHAR(2) NOT NULL,
    PRIMARY KEY (cod_cidade),
    FOREIGN KEY (uf) REFERENCES ESTADO (uf)
);


CREATE TABLE ENDERECO (
    cod_cliente NUMBER NOT NULL,
    cod_endereco NUMBER NOT NULL,
    rua VARCHAR2(80) NOT NULL,
    numero NUMBER NOT NULL,
    complemento VARCHAR2(20),
    cep NUMBER NOT NULL,
    cod_cidade NUMBER NOT NULL,
    PRIMARY KEY (cod_endereco, cod_cliente),
    FOREIGN KEY (cod_cliente) REFERENCES CLIENTE (cod_cliente),
    FOREIGN KEY (cod_cidade) REFERENCES CIDADE (cod_cidade)
);

CREATE TABLE TELEFONE (
    id_telefone CHAR(10) NOT NULL,
    ddd NUMBER(2) NOT NULL,
    numero NUMBER(9) NOT NULL,
    cod_cliente NUMBER NOT NULL,
    PRIMARY KEY (id_telefone),
    FOREIGN KEY (cod_cliente) REFERENCES PESSOA_FISICA (cod_cliente)
);

CREATE TABLE CATEGORIA (
    cod_categoria NUMBER NOT NULL,
    nome VARCHAR2(50) NOT NULL,
    cod_categoria_pai NUMBER,
    PRIMARY KEY (cod_categoria),
    FOREIGN KEY (cod_categoria_pai) REFERENCES CATEGORIA (cod_categoria)
);

CREATE TABLE PRODUTO (
    cod_produto NUMBER NOT NULL,
    nome VARCHAR2(100) NOT NULL,
    data_lancamento DATE NOT NULL,
    importado CHAR(1) NOT NULL,
    preco FLOAT NOT NULL,
    prazo_entrega NUMBER NOT NULL,
    cod_categoria NUMBER NOT NULL,
    PRIMARY KEY (cod_produto),
    CHECK (importado IN ('S','N')),
    FOREIGN KEY (cod_categoria) REFERENCES CATEGORIA (cod_categoria)
);

CREATE TABLE PEDIDO (
    num_pedido NUMBER(10) NOT NULL,
    data_emissao DATE NOT NULL,
    cod_cliente NUMBER NOT NULL,
    PRIMARY KEY (num_pedido),
    FOREIGN KEY (cod_cliente) REFERENCES CLIENTE (cod_cliente)
);

CREATE TABLE ENTREGA (
    num_entrega NUMBER(10) NOT NULL,
    data DATE NOT NULL,
    placa CHAR(8) NOT NULL,
    mot_cnh NUMBER(11) NOT NULL,
    mot_nome VARCHAR2(100) NOT NULL,
    PRIMARY KEY (num_entrega)
);

CREATE TABLE ITEM_PEDIDO (
    num_pedido NUMBER(10) NOT NULL,
    cod_produto NUMBER NOT NULL,
    quantidade NUMBER(4),
    valor_unitario NUMBER(8,2),
    num_entrega NUMBER(10),
    PRIMARY KEY (num_pedido, cod_produto),
    FOREIGN KEY (num_pedido) REFERENCES PEDIDO (num_pedido),    
    FOREIGN KEY (cod_produto) REFERENCES PRODUTO (cod_produto),
    FOREIGN KEY (num_entrega) REFERENCES ENTREGA (num_entrega)
);

COMMIT;

--------------------------------------------------------
--  DADOS   
--------------------------------------------------------

INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('1','Literatura e Comportamento',null);
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('71','Periódicos',null);
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('2','Ficção','1');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('3','Não-Ficção','1');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('4','Biografias','3');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('6','Comportamento','3');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('7','Contos','2');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('9','Ficção Científica','2');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('10','Folclore','3');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('12','Humor','2');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('13','Infanto Juvenis','2');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('14','Jogos','2');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('16','Técnicos e Profissionais',null);
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('17','Administração','16');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('18','Agricultura','16');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('19','Antropologia','16');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('21','Arqueologia','16');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('22','Arquitetura','16');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('23','Artes','16');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('24','Astronomia','16');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('26','Botânica','16');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('27','Brasil','16');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('28','Ciência Política','16');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('29','Ciências Exatas','16');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('30','Cinema','16');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('31','Comunicação','16');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('33','Decoração','16');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('35','Didáticos','16');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('37','Documentos','16');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('39','Economia','16');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('40','Engenharia','16');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('41','Enciclopédias','16');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('42','Ensino de Idiomas','16');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('44','Fotografia','16');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('46','Guerra','16');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('48','História Geral','16');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('49','Informática','16');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('50','Linguística','16');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('52','Moda','16');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('56','Pintura','16');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('59','Sociologia','16');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('60','Teatro','16');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('62','Equilíbrio pessoal',null);
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('63','Artesanato','62');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('64','Auto Ajuda','62');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('65','Culinária','62');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('66','Esoterismo','62');
INSERT INTO CATEGORIA (cod_categoria,nome,cod_categoria_pai) VALUES ('72','Revistas','71');
COMMIT;

INSERT INTO ESTADO (uf,nome,regiao) VALUES ('AC','Acre','N ');
INSERT INTO ESTADO (uf,nome,regiao) VALUES ('AL','Alagoas','NE');
INSERT INTO ESTADO (uf,nome,regiao) VALUES ('AP','Amapá','N ');
INSERT INTO ESTADO (uf,nome,regiao) VALUES ('AM','Amazonas','N ');
INSERT INTO ESTADO (uf,nome,regiao) VALUES ('BA','Bahia','NE');
INSERT INTO ESTADO (uf,nome,regiao) VALUES ('CE','Ceará','NE');
INSERT INTO ESTADO (uf,nome,regiao) VALUES ('DF','Distrito Federal','CO');
INSERT INTO ESTADO (uf,nome,regiao) VALUES ('ES','Espírito Santo','SE');
INSERT INTO ESTADO (uf,nome,regiao) VALUES ('GO','Goiás','CO');
INSERT INTO ESTADO (uf,nome,regiao) VALUES ('MA','Maranhão','NE');
INSERT INTO ESTADO (uf,nome,regiao) VALUES ('MT','Mato Grosso','CO');
INSERT INTO ESTADO (uf,nome,regiao) VALUES ('MS','Mato Grosso do Sul','CO');
INSERT INTO ESTADO (uf,nome,regiao) VALUES ('MG','Minas Gerais','SE');
INSERT INTO ESTADO (uf,nome,regiao) VALUES ('PA','Pará','N ');
INSERT INTO ESTADO (uf,nome,regiao) VALUES ('PB','Paraíba','NE');
INSERT INTO ESTADO (uf,nome,regiao) VALUES ('PR','Paraná','S ');
INSERT INTO ESTADO (uf,nome,regiao) VALUES ('PE','Pernambuco','NE');
INSERT INTO ESTADO (uf,nome,regiao) VALUES ('PI','Piauí','NE');
INSERT INTO ESTADO (uf,nome,regiao) VALUES ('RJ','Rio de Janeiro','SE');
INSERT INTO ESTADO (uf,nome,regiao) VALUES ('RN','Rio Grande do Norte','NE');
INSERT INTO ESTADO (uf,nome,regiao) VALUES ('RS','Rio Grande do Sul','S ');
INSERT INTO ESTADO (uf,nome,regiao) VALUES ('RO','Rondônia','N ');
INSERT INTO ESTADO (uf,nome,regiao) VALUES ('RR','Roraima','N ');
INSERT INTO ESTADO (uf,nome,regiao) VALUES ('SC','Santa Catarina','S ');
INSERT INTO ESTADO (uf,nome,regiao) VALUES ('SP','São Paulo','SE');
INSERT INTO ESTADO (uf,nome,regiao) VALUES ('SE','Sergipe','NE');
INSERT INTO ESTADO (uf,nome,regiao) VALUES ('TO','Tocantins','N ');
COMMIT;

INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('337','Arapuá','MG');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('385','Armação de Búzios','RJ');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('582','Belém','PB');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('750','Brasil Novo','PA');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('789','Bugre','MG');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('974','Campo Magro','PR');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('1018','Cândido Rodrigues','SP');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('1076','Capivari do Sul','RS');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('1169','Castelândia','GO');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('1198','Caxambu','MG');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('1210','Centenário do Sul','PR');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('1311','Colorado','PR');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('1409','Córrego do Bom Jesus','MG');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('1425','Coruripe','AL');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('154','Alto Horizonte','GO');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('165','Alto Rio Novo','ES');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('187','Amapa do Maranhao','MA');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('260','Antônio Carlos','MG');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('2879','Mandaguaçu','PR');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('3014','Matriz de Camaragibe','AL');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('3440','Oliveira Fortes','MG');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('3635','Patos de Minas','MG');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('3781','Pindamonhangaba','SP');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('3812','Piquete','SP');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('3887','Pocrane','MG');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('1484','Cubatão','SP');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('1581','Dois Lajeados','RS');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('1593','Domingos Mourão','PI');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('1850','Franco da Rocha','SP');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('1873','Galvão','SC');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('2008','Guaraniaçu','PR');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('2184','Indaiabira','MG');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('2410','Itatira','CE');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('2461','Jaboti','PR');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('2575','Jitaúna','BA');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('5326','Turmalina','MG');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('5420','Vargeão','SC');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('5517','Visconde do Rio Branco','MG');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('3953','Porto Lucena','RS');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('3955','Porto Murtinho','MS');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('4123','Restinga Seca','RS');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('4165','Ribeirão Pires','SP');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('4277','Rubiataba','GO');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('4354','Santa Clara do Sul','RS');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('4427','Santa Maria do Jetibá','ES');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('4444','Santana de Cataguases','MG');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('4560','Santo Antônio','RN');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('4595','São Caetano','PE');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('4609','São Domingos do Maranhão','MA');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('4766','São José do Inhacorá','RS');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('4781','São José dos Campos','SP');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('4841','São Nicolau','RS');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('4912','São Vicente Ferrer','MA');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('5090','Sumaré','SP');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('5111','Tacima','PB');
INSERT INTO CIDADE (cod_cidade,nome,uf) VALUES ('5168','Tarauacá','AC');
COMMIT;

INSERT INTO CLIENTE (cod_cliente,nome,data_cadastro,tipo) VALUES ('8','Empresa Alvimar',to_date('20/09/06','DD/MM/RR'),'J');
INSERT INTO CLIENTE (cod_cliente,nome,data_cadastro,tipo) VALUES ('12','Empresa Handro',to_date('14/09/02','DD/MM/RR'),'J');
INSERT INTO CLIENTE (cod_cliente,nome,data_cadastro,tipo) VALUES ('15','Empresa Torres',to_date('08/04/97','DD/MM/RR'),'J');
INSERT INTO CLIENTE (cod_cliente,nome,data_cadastro,tipo) VALUES ('17','Empresa Hermuche',to_date('16/11/10','DD/MM/RR'),'J');
INSERT INTO CLIENTE (cod_cliente,nome,data_cadastro,tipo) VALUES ('22','Anna Brust',to_date('14/09/10','DD/MM/RR'),'F');
INSERT INTO CLIENTE (cod_cliente,nome,data_cadastro,tipo) VALUES ('54','Daito Brisolla',to_date('29/12/14','DD/MM/RR'),'F');
INSERT INTO CLIENTE (cod_cliente,nome,data_cadastro,tipo) VALUES ('100','Hannah Torres',to_date('01/05/19','DD/MM/RR'),'F');
INSERT INTO CLIENTE (cod_cliente,nome,data_cadastro,tipo) VALUES ('107','Inêz Campos',to_date('10/09/07','DD/MM/RR'),'F');
INSERT INTO CLIENTE (cod_cliente,nome,data_cadastro,tipo) VALUES ('111','Isabel Ferreira',to_date('25/02/10','DD/MM/RR'),'F');
INSERT INTO CLIENTE (cod_cliente,nome,data_cadastro,tipo) VALUES ('116','J. Nasce',to_date('19/09/09','DD/MM/RR'),'F');
INSERT INTO CLIENTE (cod_cliente,nome,data_cadastro,tipo) VALUES ('143','Lúcia Azevedo',to_date('05/07/00','DD/MM/RR'),'F');
INSERT INTO CLIENTE (cod_cliente,nome,data_cadastro,tipo) VALUES ('150','Ludimilla G',to_date('01/12/10','DD/MM/RR'),'F');
INSERT INTO CLIENTE (cod_cliente,nome,data_cadastro,tipo) VALUES ('165','Marcos França',to_date('01/01/12','DD/MM/RR'),'F');
INSERT INTO CLIENTE (cod_cliente,nome,data_cadastro,tipo) VALUES ('169','Maria Maria Tereza Guimarães',to_date('10/06/05','DD/MM/RR'),'F');
INSERT INTO CLIENTE (cod_cliente,nome,data_cadastro,tipo) VALUES ('230','Companhia Sabino',to_date('04/08/19','DD/MM/RR'),'J');
INSERT INTO CLIENTE (cod_cliente,nome,data_cadastro,tipo) VALUES ('231','Empresa Mara',to_date('27/05/19','DD/MM/RR'),'J');
INSERT INTO CLIENTE (cod_cliente,nome,data_cadastro,tipo) VALUES ('242','Empresa Regina',to_date('10/11/08','DD/MM/RR'),'J');
INSERT INTO CLIENTE (cod_cliente,nome,data_cadastro,tipo) VALUES ('244','Companhia Mamed',to_date('16/02/04','DD/MM/RR'),'J');
INSERT INTO CLIENTE (cod_cliente,nome,data_cadastro,tipo) VALUES ('246','Empresa Ries',to_date('28/07/09','DD/MM/RR'),'J');
INSERT INTO CLIENTE (cod_cliente,nome,data_cadastro,tipo) VALUES ('248','Empresa Montagner',to_date('24/04/97','DD/MM/RR'),'J');
INSERT INTO CLIENTE (cod_cliente,nome,data_cadastro,tipo) VALUES ('251','Companhia Braun',to_date('28/02/11','DD/MM/RR'),'J');
INSERT INTO CLIENTE (cod_cliente,nome,data_cadastro,tipo) VALUES ('252','Empresa Souza',to_date('09/09/10','DD/MM/RR'),'J');
INSERT INTO CLIENTE (cod_cliente,nome,data_cadastro,tipo) VALUES ('253','Empresa Viriato',to_date('26/07/08','DD/MM/RR'),'J');
INSERT INTO CLIENTE (cod_cliente,nome,data_cadastro,tipo) VALUES ('255','Tetê Catalão',to_date('18/10/11','DD/MM/RR'),'F');
INSERT INTO CLIENTE (cod_cliente,nome,data_cadastro,tipo) VALUES ('273','W. Handro',to_date('14/12/14','DD/MM/RR'),'F');
COMMIT;

INSERT INTO PESSOA_JURIDICA (cod_cliente,cnpj,razao_social) VALUES ('8','31.489.407/0001-67','Empresa Alvimar Ltda.');
INSERT INTO PESSOA_JURIDICA (cod_cliente,cnpj,razao_social) VALUES ('12','31.158.543/0003-09','Empresa Handro S.A.');
INSERT INTO PESSOA_JURIDICA (cod_cliente,cnpj,razao_social) VALUES ('231','19.261.225/0003-18','Empresa Mara S.A.');
INSERT INTO PESSOA_JURIDICA (cod_cliente,cnpj,razao_social) VALUES ('242','24.010.311/0003-74','Empresa Regina Ltda.');
INSERT INTO PESSOA_JURIDICA (cod_cliente,cnpj,razao_social) VALUES ('246','09.277.739/0001-81','Empresa Ries S.A.');
INSERT INTO PESSOA_JURIDICA (cod_cliente,cnpj,razao_social) VALUES ('251','38.464.240/0005-13','Companhia Braun Ltda.');
INSERT INTO PESSOA_JURIDICA (cod_cliente,cnpj,razao_social) VALUES ('252','99.036.311/0005-19','Empresa Souza Ltda.');
INSERT INTO PESSOA_JURIDICA (cod_cliente,cnpj,razao_social) VALUES ('253','25.625.632/0002-80','Empresa Viriato Ltda.');
INSERT INTO PESSOA_JURIDICA (cod_cliente,cnpj,razao_social) VALUES ('15','94.384.338/0005-38','Empresa Torres Ltda.');
INSERT INTO PESSOA_JURIDICA (cod_cliente,cnpj,razao_social) VALUES ('17','55.068.770/0003-15','Empresa Hermuche S.A.');
INSERT INTO PESSOA_JURIDICA (cod_cliente,cnpj,razao_social) VALUES ('230','76.428.198/0003-71','Companhia Sabino Ltda.');
INSERT INTO PESSOA_JURIDICA (cod_cliente,cnpj,razao_social) VALUES ('244','57.840.208/0003-62','Companhia Mamed Ltda.');
INSERT INTO PESSOA_JURIDICA (cod_cliente,cnpj,razao_social) VALUES ('248','37.748.449/0003-65','Empresa Montagner Ltda.');
COMMIT;

INSERT INTO PESSOA_FISICA (cod_cliente,cpf,data_nascimento,genero,cod_empresa) VALUES ('255','240.008.108/32',to_date('19/05/68','DD/MM/RR'),'F','17');
INSERT INTO PESSOA_FISICA (cod_cliente,cpf,data_nascimento,genero,cod_empresa) VALUES ('273','445.708.584/76',to_date('06/05/02','DD/MM/RR'),'M',null);
INSERT INTO PESSOA_FISICA (cod_cliente,cpf,data_nascimento,genero,cod_empresa) VALUES ('22','844.487.556/15',to_date('24/02/13','DD/MM/RR'),'F','248');
INSERT INTO PESSOA_FISICA (cod_cliente,cpf,data_nascimento,genero,cod_empresa) VALUES ('54','483.705.084/38',to_date('05/07/04','DD/MM/RR'),'M',null);
INSERT INTO PESSOA_FISICA (cod_cliente,cpf,data_nascimento,genero,cod_empresa) VALUES ('100','070.473.737/68',to_date('23/09/75','DD/MM/RR'),'F','244');
INSERT INTO PESSOA_FISICA (cod_cliente,cpf,data_nascimento,genero,cod_empresa) VALUES ('107','228.622.010/19',to_date('14/10/10','DD/MM/RR'),'F','15');
INSERT INTO PESSOA_FISICA (cod_cliente,cpf,data_nascimento,genero,cod_empresa) VALUES ('111','250.797.247/13',to_date('11/10/99','DD/MM/RR'),'F',null);
INSERT INTO PESSOA_FISICA (cod_cliente,cpf,data_nascimento,genero,cod_empresa) VALUES ('116','871.514.739/97',to_date('11/09/89','DD/MM/RR'),'M',null);
INSERT INTO PESSOA_FISICA (cod_cliente,cpf,data_nascimento,genero,cod_empresa) VALUES ('143','562.120.395/62',to_date('13/01/93','DD/MM/RR'),'F',null);
INSERT INTO PESSOA_FISICA (cod_cliente,cpf,data_nascimento,genero,cod_empresa) VALUES ('150','833.362.930/88',to_date('25/11/89','DD/MM/RR'),'F','242');
INSERT INTO PESSOA_FISICA (cod_cliente,cpf,data_nascimento,genero,cod_empresa) VALUES ('165','371.650.564/08',to_date('13/10/87','DD/MM/RR'),'M',null);
INSERT INTO PESSOA_FISICA (cod_cliente,cpf,data_nascimento,genero,cod_empresa) VALUES ('169','073.309.221/88',to_date('09/07/78','DD/MM/RR'),'F','230');
COMMIT;

INSERT INTO TELEFONE (id_telefone,ddd,numero,cod_cliente) VALUES ('307','53','34571165','116');
INSERT INTO TELEFONE (id_telefone,ddd,numero,cod_cliente) VALUES ('310','52','30983308','150');
INSERT INTO TELEFONE (id_telefone,ddd,numero,cod_cliente) VALUES ('344','18','996966570','107');
INSERT INTO TELEFONE (id_telefone,ddd,numero,cod_cliente) VALUES ('399','45','996922952','143');
INSERT INTO TELEFONE (id_telefone,ddd,numero,cod_cliente) VALUES ('448','42','983152771','165');
INSERT INTO TELEFONE (id_telefone,ddd,numero,cod_cliente) VALUES ('524','29','993126703','150');
INSERT INTO TELEFONE (id_telefone,ddd,numero,cod_cliente) VALUES ('565','35','980615408','150');
INSERT INTO TELEFONE (id_telefone,ddd,numero,cod_cliente) VALUES ('581','23','996231447','100');
INSERT INTO TELEFONE (id_telefone,ddd,numero,cod_cliente) VALUES ('630','11','41077471','143');
INSERT INTO TELEFONE (id_telefone,ddd,numero,cod_cliente) VALUES ('637','31','37163057','150');
INSERT INTO TELEFONE (id_telefone,ddd,numero,cod_cliente) VALUES ('660','21','986228987','150');
INSERT INTO TELEFONE (id_telefone,ddd,numero,cod_cliente) VALUES ('681','26','22295604','169');
INSERT INTO TELEFONE (id_telefone,ddd,numero,cod_cliente) VALUES ('708','36','997826738','22');
INSERT INTO TELEFONE (id_telefone,ddd,numero,cod_cliente) VALUES ('730','24','997776584','100');
INSERT INTO TELEFONE (id_telefone,ddd,numero,cod_cliente) VALUES ('745','16','985856701','116');
INSERT INTO TELEFONE (id_telefone,ddd,numero,cod_cliente) VALUES ('755','38','987032559','165');
INSERT INTO TELEFONE (id_telefone,ddd,numero,cod_cliente) VALUES ('779','24','33832192','100');
INSERT INTO TELEFONE (id_telefone,ddd,numero,cod_cliente) VALUES ('36','38','35202274','107');
INSERT INTO TELEFONE (id_telefone,ddd,numero,cod_cliente) VALUES ('49','22','982988207','111');
INSERT INTO TELEFONE (id_telefone,ddd,numero,cod_cliente) VALUES ('101','40','986333115','143');
INSERT INTO TELEFONE (id_telefone,ddd,numero,cod_cliente) VALUES ('117','42','989523891','143');
INSERT INTO TELEFONE (id_telefone,ddd,numero,cod_cliente) VALUES ('126','23','28735691','165');
INSERT INTO TELEFONE (id_telefone,ddd,numero,cod_cliente) VALUES ('200','24','36181908','54');
INSERT INTO TELEFONE (id_telefone,ddd,numero,cod_cliente) VALUES ('201','31','30225740','165');
INSERT INTO TELEFONE (id_telefone,ddd,numero,cod_cliente) VALUES ('228','33','982263514','22');
INSERT INTO TELEFONE (id_telefone,ddd,numero,cod_cliente) VALUES ('231','14','983076999','22');
INSERT INTO TELEFONE (id_telefone,ddd,numero,cod_cliente) VALUES ('238','54','981708787','100');
INSERT INTO TELEFONE (id_telefone,ddd,numero,cod_cliente) VALUES ('285','55','26734242','54');
INSERT INTO TELEFONE (id_telefone,ddd,numero,cod_cliente) VALUES ('286','48','987364236','143');
COMMIT;

INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('100','1','Rua Mar. Deodoro','2888','Ap. 201','34944890','1169');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('107','1','Rua Antonio Ferreira Alvares','2595',null,'88226054','5168');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('107','2','Rua Pedro Paulino de Andrade','5808',null,'38563384','2575');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('107','3','Av. Presidente Kennedy','2333','Fundos','74476560','4354');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('111','1','Rua Maria Andresa de Abreu','3981','Fundos','43836298','2184');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('111','2','Rua Joaquim de Souza Aranha','4823','Ap. 605','53406833','2879');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('111','3','Rua Mario Martins de Almeida','6990','Ap. 402','99605156','5420');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('116','1','Rua Durval Guerra de Azevedo','3809','Ap. 201','50213312','5111');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('116','2','Rua Maestro Zacarias Autuori','3119','Ap. 201','11999689','5326');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('143','1','Rua Bernardino Luiz Dutra','6362',null,'77947449','1198');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('143','2','Rua Dona Carlinda','3918',null,'25756448','1873');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('143','3','Rua Maria Augusta de Andrade','6098','Ap. 201','65421849','4609');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('143','4','Rua Santa Rosa','1870','Fundos','53362670','1018');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('150','1','Rua Manoel Muniz Dos Anjos','4220',null,'93504206','1425');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('150','2','Rua Pedro Antonio de Azevedo','1822','Ap. 701','74765607','1210');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('150','3','Rua Afonso Araujo de Almeida','2392','Ap. 701','72148825','260');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('150','4','Rua Gastao Thomaz de Almeida','1306',null,'96965435','750');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('150','5','Rua Hilario Pinto de Almeida','5272','Ap. 301','19345010','187');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('150','6','Rua Moron','3552',null,'32318080','789');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('165','1','Av. Antonio Louzada Antunes','1899','Fundos','12825483','3812');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('165','2','Av. Independência','2247','Ap. 701','96813384','4595');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('169','1','Rua Henrique Lenzi','3908',null,'47314970','5517');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('230','1','Rua Presidente Tancredo Neves','5536',null,'95801409','165');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('230','2','Av. Salzano da Cunha','5935',null,'83125708','3635');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('230','3','Rua Guarita','6008','Ap. 820','70162231','5090');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('231','1','Rua General David Canabarro','4070','Ap. 605','14814988','4444');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('242','1','Rua Adao Norberto de Andrade','4714',null,'14247855','1581');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('242','2','Rua Trinta de Novembro','5680','Ap. 301','78000639','4277');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('242','3','Rua Borges de Medeiros','6494','Ap. 701','65756217','1593');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('242','4','Av. 1º de Maio','6660','Ap. 701','43530522','2008');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('246','1','Av. Jorge Dariva','6796','Ap. 820','54426847','4781');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('246','2','Rua Maximiliano Centenaro','6550',null,'45587182','1409');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('246','3','Rua Padre Estevão Vonsoski','5503','Ap. 605','98877185','974');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('248','1','Rua Nossa Senhora da Aparecida','2418',null,'49439834','4427');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('251','1','Rua São Cristovão','6801',null,'29222911','2410');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('251','2','Rua Rev Prof. Paulo Hasse','6253','Ap. 701','15414593','3955');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('252','1','Av. Sete de Setembro','5920',null,'86603924','4165');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('252','2','Rua Jacob Ely','5855',null,'18725550','4123');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('253','1','Pç. Manoel de Souza Araujo','4390','Ap. 301','62257223','3887');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('253','2','Rua Independência','7200','Ap. 402','31163021','3781');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('255','1','Rua Hildebrando Westphalen','5727','Fundos','72692708','582');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('255','2','Av. Presidente Vargas','111','Ap. 301','51942347','1484');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('255','3','Rua Gregorio Paes de Almeida','6849','Ap. 605','54718004','385');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('273','1','Rua Dom Gregorio Dos Anjos','3473','Ap. 820','60610374','3953');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('273','2','Rua Dinah de Azevedo Alvim','5105','Fundos','20976360','1850');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('8','1','Rua Alfredo Chaves','2685','Ap. 820','52424010','1076');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('8','2','Rua General Osório','3164',null,'49545853','1311');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('12','1','Rua Floriano Peixoto','2530','Ap. 201','93404754','2461');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('12','2','Av. João Corrêa','979','Fundos','69205846','4841');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('12','3','Rua Tomaz Paulino de Almeida','1268',null,'15024607','3014');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('15','1','Rua Antonio de Pinho Azevedo','2467',null,'20017636','4766');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('15','2','Rua Andre Alvares do Amaral','537',null,'36143284','337');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('22','1','Rua Santo Antonio do Aracuai','7394',null,'43964285','154');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('22','2','Rua Joaquim Maria de Almeida E Silva','7548','Ap. 605','29445924','4912');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('22','3','Rua Padre Estevão Vonsoski','7968',null,'65274070','4560');
INSERT INTO ENDERECO (cod_cliente,cod_endereco,rua,numero,complemento,cep,cod_cidade) VALUES ('54','1','Rua Osmani Veras','7268',null,'53910075','3440');
COMMIT;

INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('128','CONCERTO BARROCO ÁS ÓPERAS DO JUDEU',to_date('26/12/01','DD/MM/RR'),'S','126','48','30');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('129','Bury My Heart at Wounded Knee',to_date('21/09/96','DD/MM/RR'),'S','469,46','7','24');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('145','Carrion Comfort',to_date('14/07/11','DD/MM/RR'),'S','143,13','43','4');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('146','CONTRIBUIÇÕES PARA A GESTÃO DA ZONA COSTEIRA DO BRASIL',to_date('15/02/99','DD/MM/RR'),'S','382','49','19');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('148','CONTROVÉRSIAS E DISSONÂNCIAS',to_date('04/10/01','DD/MM/RR'),'N','175','8','29');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('158','CORRESPONDÊNCIA MÁRIO DE ANDRADE TARSILA DO AMARAL',to_date('20/06/98','DD/MM/RR'),'N','397','39','6');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('167','CRISE DO NOSSO TEMPO',to_date('05/03/02','DD/MM/RR'),'S','338','26','65');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('171','CRONOBIOLOGIA: Princípios e Aplicações',to_date('15/04/01','DD/MM/RR'),'N','292','33','29');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('201','DIÁRIO CRÍTICO DE SÉRGIO MILLIET vol. 1',to_date('29/08/01','DD/MM/RR'),'S','234','8','56');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('223','DO ROMANCE',to_date('28/10/98','DD/MM/RR'),'N','176','42','16');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('226','Dying of the Light',to_date('11/09/05','DD/MM/RR'),'S','320,11','71','2');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('237','EDITANDO O EDITOR 5: Jorge Zahar',to_date('18/01/03','DD/MM/RR'),'N','35','7','21');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('244','EDUCAÇÃO SUPERIOR DIREITO E ESTADO: Reflexões sobre a Lei de Diretrizes e Bases',to_date('11/03/99','DD/MM/RR'),'S','71','59','41');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('248','ELOQÜÊNCIA DOS SÍMBOLOS (A)',to_date('12/03/96','DD/MM/RR'),'N','345','10','52');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('249','EM BUSCA DE UM TEMPO PERDIDO',to_date('15/09/99','DD/MM/RR'),'S','169','5','44');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('258','ENQUANTO JACTOS E HIATOS: Poemas',to_date('22/11/00','DD/MM/RR'),'N','309','39','44');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('259','ENSAIOS DE CRÍTICA',to_date('12/03/97','DD/MM/RR'),'S','235','35','37');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('271','The Far-Distant Oxus',to_date('25/03/09','DD/MM/RR'),'S','270,4','49','12');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('295','EXPRESSÕES DE TRATAMENTO DA LÍNGUA JAPONESA (AS)',to_date('11/10/02','DD/MM/RR'),'N','148','35','26');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('298','FARMACOLOGIA BÁSICA DO SISTEMA NERVOSO AUTÔNOMO POR SIMULAÇÃO COMPUTADORIZADA ',to_date('21/05/03','DD/MM/RR'),'S','139','26','46');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('301','FERES LOURENCO KHOURY',to_date('19/12/00','DD/MM/RR'),'S','135','41','22');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('319','The Golden Apples of the Sun',to_date('29/05/04','DD/MM/RR'),'S','237,62','43','63');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('320','The Golden Bowl',to_date('14/08/94','DD/MM/RR'),'S','402,91','84','46');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('332','A Handful of Dust',to_date('03/05/94','DD/MM/RR'),'S','306,47','38','40');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('354','HERMELINDO FIAMINGHI',to_date('25/09/97','DD/MM/RR'),'N','85','34','4');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('368','I Know Why the Caged Bird Sings',to_date('18/02/10','DD/MM/RR'),'S','447,36','46','21');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('373','HISTÓRIA DO BRASIL',to_date('09/01/96','DD/MM/RR'),'S','258','24','13');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('375','I Will Fear No Evil',to_date('29/07/04','DD/MM/RR'),'S','68,13','90','59');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('379','If I Forget Thee Jerusalem',to_date('10/09/93','DD/MM/RR'),'S','348,15','41','6');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('381','HISTÓRIA ECONÔMICA DO BRASIL CONTEMPORÂNEO',to_date('12/10/96','DD/MM/RR'),'N','343','47','28');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('388','HUMANIDADES: Um Novo Curso na USP',to_date('23/05/97','DD/MM/RR'),'N','134','58','50');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('393','In a Glass Darkly',to_date('12/11/92','DD/MM/RR'),'S','507,25','35','52');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('399','IMAGEM E LETRA',to_date('06/05/00','DD/MM/RR'),'N','281','43','72');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('403','IMIGRAÇÃO OU OS PARADOXOS DA ALTERIDADE (A)',to_date('23/05/96','DD/MM/RR'),'S','309','12','33');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('404','IMITAÇÃO DOS SENTIDOS (A)',to_date('06/10/00','DD/MM/RR'),'S','186','49','16');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('406','IMPRENSA E O DEVER DA VERDADE (A)',to_date('18/03/98','DD/MM/RR'),'N','197','35','17');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('442','INTRODUÇÃO À FÍSICA E PSICOFÍSICA DA MÚSICA',to_date('09/03/01','DD/MM/RR'),'S','59','32','10');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('443','INTRODUÇÃO À FÍSICA ESTATÍSTICA',to_date('17/06/03','DD/MM/RR'),'N','185','20','17');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('453','JARDIM E A PRAÇA (O): O Privado e o Público na Vida Social e Histórica',to_date('22/10/01','DD/MM/RR'),'N','276','48','49');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('462','JOHN ASHBERY: Um Módulo para o Vento',to_date('04/10/02','DD/MM/RR'),'S','247','12','44');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('469','KARL VON DEN STEINEN: Um Século de Antropologia no Xingu',to_date('26/09/97','DD/MM/RR'),'N','298','52','31');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('479','LETRAS DE MINAS E OUTROS ENSAIOS',to_date('15/04/99','DD/MM/RR'),'N','353','44','22');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('491','A Monstrous Regiment of Women',to_date('10/05/92','DD/MM/RR'),'S','76,49','34','42');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('493','LÍRICA E LUGAR COMUM: Alguns Temas de Horácio e sua Presença em Português',to_date('27/03/01','DD/MM/RR'),'N','220','51','18');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('498','LITERATURA BRASILEIRA (A): Origens e Unidade (1500-1960) vol. I',to_date('26/03/01','DD/MM/RR'),'S','255','45','37');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('519','MANUAL DO GERENTE DE EMPRESA vol. 3: Controle de Fabricação',to_date('28/07/02','DD/MM/RR'),'S','56','16','46');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('525','Now Sleeps the Crimson Petal',to_date('05/05/15','DD/MM/RR'),'S','333,4','37','3');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('527','Number the Stars',to_date('01/10/93','DD/MM/RR'),'S','587,71','20','39');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('528','MANUAL DO GERENTE DE EMPRESA vol. 8: Atividade Serviço de Apoio',to_date('28/08/96','DD/MM/RR'),'N','47','45','7');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('529','MANUAL PRÁTICO DE MICROBIOLOGIA BÁSICA',to_date('04/11/95','DD/MM/RR'),'N','239','52','44');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('533','Of Human Bondage',to_date('15/04/01','DD/MM/RR'),'S','207,73','29','35');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('545','MECÂNICA CLÁSSICA MODERNA',to_date('27/07/00','DD/MM/RR'),'S','234','29','14');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('547','The Other Side of Silence',to_date('24/04/16','DD/MM/RR'),'S','374,27','82','60');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('548','MECENATO POMBALINO E POESIA NEOCLÁSSICA',to_date('06/07/98','DD/MM/RR'),'S','152','15','27');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('3','ADAPTABILIDADE HUMANA: Uma Introdução à Antropologia',to_date('17/01/98','DD/MM/RR'),'N','400','42','29');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('11','ALMANHAQUE PARA 1949',to_date('20/06/00','DD/MM/RR'),'N','86','21','66');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('14','AMÉRICA LATINA CONTEMPORÂNEA: Desafios e Perspectivas',to_date('18/03/01','DD/MM/RR'),'S','21','30','29');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('30','ANTONIO CANDIDO: A Palavra Empenhada',to_date('03/02/02','DD/MM/RR'),'S','179','43','52');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('48','ASTRONOMIA: Uma Visão Geral do Universo',to_date('04/04/01','DD/MM/RR'),'S','117','9','39');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('74','BRASIL 500 ANOS: Tópicas em História da Educação',to_date('01/08/01','DD/MM/RR'),'N','330','56','12');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('83','BROQUÉIS',to_date('16/08/98','DD/MM/RR'),'N','141','8','29');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('88','CAMINHOS DO IMAGINÁRIO NO BRASIL',to_date('16/12/02','DD/MM/RR'),'N','131','47','3');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('106','CID-10: vol.1 (com disquete)',to_date('23/09/01','DD/MM/RR'),'S','313','32','48');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('117','Bonjour Tristesse',to_date('13/05/19','DD/MM/RR'),'S','166,33','81','62');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('550','MEDITAÇÕES SOBRE UM CAVALINHO DE PAU',to_date('22/09/02','DD/MM/RR'),'S','250','40','65');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('555','The Painted Veil',to_date('23/06/99','DD/MM/RR'),'S','92,79','19','9');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('562','MÉTODO CRÍTICO DE SÍLVIO ROMERO (O)',to_date('23/05/03','DD/MM/RR'),'N','71','55','23');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('580','MODERNIZANDO A DESIGUALDADE',to_date('17/12/99','DD/MM/RR'),'N','73','15','50');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('588','MULHERES DE BRANCO (AS)',to_date('07/09/00','DD/MM/RR'),'S','298','22','66');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('591','MUSEOLOGIA 1: Roteiros Práticos - Plano Diretor',to_date('03/01/01','DD/MM/RR'),'S','257','26','23');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('593','Ring of Bright Water',to_date('21/07/90','DD/MM/RR'),'S','420,77','44','27');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('594','MUSEOLOGIA 3: Roteiros Práticos - Educação em Museus',to_date('04/03/96','DD/MM/RR'),'N','136','41','64');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('611','NELSON PEREIRA DOS SANTOS: Um Olhar Neo-Realista?',to_date('19/09/02','DD/MM/RR'),'S','217','40','9');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('616','NÓS, OS TIKOPIAS: Um Estudo Sociológico do Parentesco na Polinésia Primitiva',to_date('11/12/02','DD/MM/RR'),'N','291','5','27');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('619','Specimen Days',to_date('28/11/10','DD/MM/RR'),'S','166,96','58','3');
INSERT INTO PRODUTO (cod_produto,nome,data_lancamento,importado,preco,prazo_entrega,cod_categoria) VALUES ('625','NOVERRE: Cartas sobre a Dança',to_date('24/07/97','DD/MM/RR'),'S','397','56','62');
COMMIT;

INSERT INTO PEDIDO (num_pedido,data_emissao,cod_cliente) VALUES ('679',to_date('25/09/19','DD/MM/RR'),'248');
INSERT INTO PEDIDO (num_pedido,data_emissao,cod_cliente) VALUES ('970',to_date('29/09/19','DD/MM/RR'),'253');
INSERT INTO PEDIDO (num_pedido,data_emissao,cod_cliente) VALUES ('1333',to_date('13/09/19','DD/MM/RR'),'116');
INSERT INTO PEDIDO (num_pedido,data_emissao,cod_cliente) VALUES ('1478',to_date('17/09/19','DD/MM/RR'),'107');
INSERT INTO PEDIDO (num_pedido,data_emissao,cod_cliente) VALUES ('1542',to_date('12/09/19','DD/MM/RR'),'252');
INSERT INTO PEDIDO (num_pedido,data_emissao,cod_cliente) VALUES ('335',to_date('30/09/19','DD/MM/RR'),'246');
INSERT INTO PEDIDO (num_pedido,data_emissao,cod_cliente) VALUES ('3482',to_date('11/09/19','DD/MM/RR'),'231');
INSERT INTO PEDIDO (num_pedido,data_emissao,cod_cliente) VALUES ('4228',to_date('05/09/19','DD/MM/RR'),'169');
INSERT INTO PEDIDO (num_pedido,data_emissao,cod_cliente) VALUES ('4247',to_date('05/09/19','DD/MM/RR'),'165');
INSERT INTO PEDIDO (num_pedido,data_emissao,cod_cliente) VALUES ('4416',to_date('13/09/19','DD/MM/RR'),'248');
INSERT INTO PEDIDO (num_pedido,data_emissao,cod_cliente) VALUES ('1816',to_date('23/09/19','DD/MM/RR'),'165');
INSERT INTO PEDIDO (num_pedido,data_emissao,cod_cliente) VALUES ('1858',to_date('14/09/19','DD/MM/RR'),'242');
INSERT INTO PEDIDO (num_pedido,data_emissao,cod_cliente) VALUES ('1961',to_date('16/09/19','DD/MM/RR'),'150');
INSERT INTO PEDIDO (num_pedido,data_emissao,cod_cliente) VALUES ('1967',to_date('23/09/19','DD/MM/RR'),'8');
INSERT INTO PEDIDO (num_pedido,data_emissao,cod_cliente) VALUES ('1980',to_date('16/09/19','DD/MM/RR'),'100');
INSERT INTO PEDIDO (num_pedido,data_emissao,cod_cliente) VALUES ('2288',to_date('20/09/19','DD/MM/RR'),'100');
INSERT INTO PEDIDO (num_pedido,data_emissao,cod_cliente) VALUES ('2571',to_date('15/09/19','DD/MM/RR'),'248');
INSERT INTO PEDIDO (num_pedido,data_emissao,cod_cliente) VALUES ('6372',to_date('27/09/19','DD/MM/RR'),'15');
INSERT INTO PEDIDO (num_pedido,data_emissao,cod_cliente) VALUES ('6969',to_date('27/09/19','DD/MM/RR'),'253');
INSERT INTO PEDIDO (num_pedido,data_emissao,cod_cliente) VALUES ('5137',to_date('11/09/19','DD/MM/RR'),'12');
INSERT INTO PEDIDO (num_pedido,data_emissao,cod_cliente) VALUES ('5862',to_date('25/09/19','DD/MM/RR'),'251');
INSERT INTO PEDIDO (num_pedido,data_emissao,cod_cliente) VALUES ('8522',to_date('08/09/19','DD/MM/RR'),'22');
INSERT INTO PEDIDO (num_pedido,data_emissao,cod_cliente) VALUES ('8569',to_date('21/09/19','DD/MM/RR'),'231');
INSERT INTO PEDIDO (num_pedido,data_emissao,cod_cliente) VALUES ('8607',to_date('16/09/19','DD/MM/RR'),'255');
INSERT INTO PEDIDO (num_pedido,data_emissao,cod_cliente) VALUES ('9352',to_date('28/09/19','DD/MM/RR'),'17');
INSERT INTO PEDIDO (num_pedido,data_emissao,cod_cliente) VALUES ('9488',to_date('21/09/19','DD/MM/RR'),'169');
INSERT INTO PEDIDO (num_pedido,data_emissao,cod_cliente) VALUES ('8922',to_date('30/09/19','DD/MM/RR'),'15');
INSERT INTO PEDIDO (num_pedido,data_emissao,cod_cliente) VALUES ('7946',to_date('01/10/19','DD/MM/RR'),'255');
INSERT INTO PEDIDO (num_pedido,data_emissao,cod_cliente) VALUES ('7947',to_date('09/09/19','DD/MM/RR'),'100');
INSERT INTO PEDIDO (num_pedido,data_emissao,cod_cliente) VALUES ('8094',to_date('01/10/19','DD/MM/RR'),'100');
COMMIT;

INSERT INTO ENTREGA (num_entrega,data,placa,mot_cnh,mot_nome) VALUES ('223',to_date('28/11/19','DD/MM/RR'),'QDU3U966','40181343366','Félix Dorneles');
INSERT INTO ENTREGA (num_entrega,data,placa,mot_cnh,mot_nome) VALUES ('1440',to_date('07/11/19','DD/MM/RR'),'PRT5T949','73725133656','Leopoldina Soares');
INSERT INTO ENTREGA (num_entrega,data,placa,mot_cnh,mot_nome) VALUES ('1627',to_date('02/10/19','DD/MM/RR'),'DRB4R828','28111177264','Josué Farias');
INSERT INTO ENTREGA (num_entrega,data,placa,mot_cnh,mot_nome) VALUES ('774',to_date('10/10/19','DD/MM/RR'),'BBU7B399','6540940497','Constantino Paraguaçu');
INSERT INTO ENTREGA (num_entrega,data,placa,mot_cnh,mot_nome) VALUES ('1107',to_date('29/10/19','DD/MM/RR'),'BYZ3G455','2477733054','Hélia Filipe');
INSERT INTO ENTREGA (num_entrega,data,placa,mot_cnh,mot_nome) VALUES ('2104',to_date('16/11/19','DD/MM/RR'),'FNN2O537','55003866801','Gonçalo Torres');
INSERT INTO ENTREGA (num_entrega,data,placa,mot_cnh,mot_nome) VALUES ('2247',to_date('22/10/19','DD/MM/RR'),'UAH3C540','9191986014','Iolanda Otero');
INSERT INTO ENTREGA (num_entrega,data,placa,mot_cnh,mot_nome) VALUES ('2570',to_date('29/11/19','DD/MM/RR'),'UTG0W237','96462064658','Ângela Moniz');
INSERT INTO ENTREGA (num_entrega,data,placa,mot_cnh,mot_nome) VALUES ('3604',to_date('24/11/19','DD/MM/RR'),'BAY0C396','5466738204','Álvaro Regueira');
INSERT INTO ENTREGA (num_entrega,data,placa,mot_cnh,mot_nome) VALUES ('4045',to_date('08/11/19','DD/MM/RR'),'WRJ8A846','79413151626','Sarita Silvestre');
INSERT INTO ENTREGA (num_entrega,data,placa,mot_cnh,mot_nome) VALUES ('5023',to_date('06/11/19','DD/MM/RR'),'MMQ0H028','97192125430','Sidônio   Albuquerque');
INSERT INTO ENTREGA (num_entrega,data,placa,mot_cnh,mot_nome) VALUES ('5765',to_date('07/11/19','DD/MM/RR'),'WXR3D129','40158463064','Ondina Guedella');
INSERT INTO ENTREGA (num_entrega,data,placa,mot_cnh,mot_nome) VALUES ('5871',to_date('21/09/19','DD/MM/RR'),'NCH3Q217','68162655045','Berengária Rufino');
INSERT INTO ENTREGA (num_entrega,data,placa,mot_cnh,mot_nome) VALUES ('5478',to_date('11/12/19','DD/MM/RR'),'RZU7A179','67769843783','Godofredo Monjardim');
INSERT INTO ENTREGA (num_entrega,data,placa,mot_cnh,mot_nome) VALUES ('6475',to_date('20/11/19','DD/MM/RR'),'TUY6I710','53393766577','Porfírio Verissimo');
INSERT INTO ENTREGA (num_entrega,data,placa,mot_cnh,mot_nome) VALUES ('6530',to_date('07/09/19','DD/MM/RR'),'JKE4R450','37643134167','Emília Jatobá');
INSERT INTO ENTREGA (num_entrega,data,placa,mot_cnh,mot_nome) VALUES ('6939',to_date('09/12/19','DD/MM/RR'),'BMK0B771','62012465870','Milena Cortesão');
INSERT INTO ENTREGA (num_entrega,data,placa,mot_cnh,mot_nome) VALUES ('7647',to_date('03/11/19','DD/MM/RR'),'EPK7Z413','28111177264','Josué Farias');
COMMIT;

INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('335','223','2','254','2247');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('335','271','5','371','2247');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('335','498','8','182','2247');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('1478','30','2','228',null);
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('1478','616','9','398',null);
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('1542','491','8','97','7647');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('1542','550','7','155','7647');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('1333','158','3','107','6939');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('1333','404','5','35','6939');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('679','249','3','58',null);
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('679','545','7','10',null);
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('970','128','3','218','4045');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('970','525','4','440','4045');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('970','594','9','466','4045');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('2571','375','10','386','1627');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('2571','403','9','279','1627');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('2571','443','3','364','1627');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('2571','527','10','453','1627');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('2571','611','5','375','1627');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('1816','244','9','171','774');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('1816','320','4','215','774');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('1816','555','6','315','774');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('1816','619','2','331','774');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('1816','625','5','258','774');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('1858','167','8','382','3604');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('1858','201','3','264','3604');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('1961','88','5','380','223');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('1961','462','2','259','223');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('1967','259','3','321','2104');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('1967','319','3','361','2104');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('1967','548','3','54','2104');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('1980','83','8','74',null);
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('1980','148','9','136',null);
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('1980','381','2','163',null);
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('1980','469','4','327',null);
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('2288','129','3','368','1440');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('2288','453','10','75','1440');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('3482','3','5','464',null);
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('3482','237','7','121',null);
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('3482','295','8','366',null);
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('3482','399','2','312',null);
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('3482','588','8','81',null);
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('4416','301','8','396','5023');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('4416','529','1','229','5023');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('4228','354','2','375','6530');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('4228','379','3','180','6530');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('4228','442','9','83','6530');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('4247','74','5','40','5871');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('4247','547','3','305','5871');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('5137','298','9','346',null);
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('5137','519','7','99',null);
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('6372','48','7','369','5765');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('6372','248','8','87','5765');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('6372','528','9','260','5765');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('6372','548','10','51','5765');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('5862','406','2','38',null);
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('5862','562','6','58',null);
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('6969','146','8','397',null);
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('6969','368','2','346',null);
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('6969','491','9','114',null);
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('7946','106','6','338',null);
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('7946','145','9','243',null);
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('7947','11','5','346','6475');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('7947','14','2','143','6475');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('7947','171','4','332','6475');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('7947','319','1','385','6475');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('7947','332','3','68','6475');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('7947','529','7','235','6475');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('7947','580','7','178','6475');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('8094','493','7','233',null);
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('9352','117','4','344',null);
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('9488','388','4','62','5478');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('9488','479','6','32','5478');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('9488','593','4','215','5478');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('8522','258','2','390',null);
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('8522','373','7','95',null);
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('8522','453','1','90',null);
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('8569','226','9','424',null);
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('8607','533','4','249','2570');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('8922','393','2','129','1107');
INSERT INTO ITEM_PEDIDO (num_pedido,cod_produto,quantidade,valor_unitario,num_entrega) VALUES ('8922','591','5','117','1107');
COMMIT;

----------------------------------------------
--criação de uma tabela AVALIACAO que deve registrar um identificador único, a nota atribuída
--(entre 1 e 5) e um comentário. 
----------------------------------------------

CREATE TABLE AVALIACAO ( 
    cod_cliente NUMBER NOT NULL,
    cod_produto NUMBER NOT NULL,
    nota NUMBER(1) NOT NULL CHECK (nota BETWEEN 1 AND 5),
    comentario VARCHAR(500),
    FOREIGN KEY (cod_cliente) REFERENCES CLIENTE (cod_cliente),
    FOREIGN KEY (cod_produto) REFERENCES PRODUTO (cod_produto)
);
COMMIT;

----------------------------------------------
--inserção de 10 avaliações que estejam em acordo com os dados existentes.
----------------------------------------------

INSERT INTO AVALIACAO (cod_cliente,cod_produto,nota,comentario) VALUES ('8','128','3','Produto excelente!');
INSERT INTO AVALIACAO (cod_cliente,cod_produto,nota,comentario) VALUES ('12','129','5','Muito bom, mas poderia ser mais barato.');
INSERT INTO AVALIACAO (cod_cliente,cod_produto,nota,comentario) VALUES ('15','145','2','Cumpre o que promete.');
INSERT INTO AVALIACAO (cod_cliente,cod_produto,nota,comentario) VALUES ('22','167','3','Recomendo a todos!');
INSERT INTO AVALIACAO (cod_cliente,cod_produto,nota,comentario) VALUES ('100','201','1','Não gostei da qualidade.');
INSERT INTO AVALIACAO (cod_cliente,cod_produto,nota,comentario) VALUES ('116','244','3','Bom custo-benefício.');
INSERT INTO AVALIACAO (cod_cliente,cod_produto,nota,comentario) VALUES ('255', '106', '5', 'Excelente acabamento e durabilidade.');
INSERT INTO AVALIACAO (cod_cliente,cod_produto,nota,comentario) VALUES ('242', '301', '1', 'Produto decepcionante.');
INSERT INTO AVALIACAO (cod_cliente,cod_produto,nota,comentario) VALUES ('248', '319', '4', 'Bom, mas já vi melhores.');
INSERT INTO AVALIACAO (cod_cliente,cod_produto,nota,comentario) VALUES ('273', '332', '5', 'Simplesmente perfeito!');
COMMIT;

----------------------------------------------
--construção de uma consulta que apresente todas as avaliações realizadas (nota e comentário) e indique 
--qual o produto avaliado e quem fez a avaliação.
----------------------------------------------

SELECT 
    A.nota,
    A.comentario,
    P.nome AS nome_produto,
    C.nome AS nome_cliente
FROM 
    AVALIACAO A
JOIN 
    CLIENTE C ON A.cod_cliente = C.cod_cliente
JOIN 
    PRODUTO P ON A.cod_produto = P.cod_produto;
    
----------------------------------------------
--listar os nomes dos clientes e as cidades onde residem;
----------------------------------------------
    
SELECT 
    c.nome AS nome_cliente,
    ci.nome AS nome_cidade
FROM 
    CLIENTE c
JOIN 
    ENDERECO e ON c.cod_cliente = e.cod_cliente
JOIN 
    CIDADE ci ON e.cod_cidade = ci.cod_cidade;

----------------------------------------------
-- listar a quantidade total de produtos em cada categoria;
----------------------------------------------

SELECT 
    c.nome AS nome_categoria,
    COUNT(p.cod_produto) AS quantidade_produtos
FROM 
    CATEGORIA c
LEFT JOIN 
    PRODUTO p ON c.cod_categoria = p.cod_categoria
GROUP BY 
    c.nome;
    
----------------------------------------------
-- listar os produtos mais vendidos, ou seja, que aparecem no maior número de pedidos;
----------------------------------------------

SELECT 
    p.cod_produto AS codigo_produto,
    p.nome AS nome_produto,
    COUNT(ip.num_pedido) AS quantidade_pedidos
FROM 
    PRODUTO p
JOIN 
    ITEM_PEDIDO ip ON p.cod_produto = ip.cod_produto
GROUP BY 
    p.cod_produto, p.nome
ORDER BY 
    quantidade_pedidos DESC;

----------------------------------------------
-- listar o nome do cliente, número do pedido e o valor total do pedido em ordem decrescente de valor total.
----------------------------------------------

SELECT 
    c.nome AS nome_cliente,
    p.num_pedido AS numero_pedido,
    SUM(ip.quantidade * ip.valor_unitario) AS valor_total_pedido
FROM 
    CLIENTE c
JOIN 
    PEDIDO p ON c.cod_cliente = p.cod_cliente
JOIN 
    ITEM_PEDIDO ip ON p.num_pedido = ip.num_pedido
GROUP BY 
    c.nome, p.num_pedido
ORDER BY 
    valor_total_pedido DESC;

----------------------------------------------
-- listar as 3 categorias de produtos com maior número de vendas.
----------------------------------------------

SELECT 
    c.nome AS nome_categoria,
    SUM (ip.quantidade) AS total_vendas
FROM 
    CATEGORIA c
JOIN 
    PRODUTO p ON c.cod_categoria = p.cod_categoria
JOIN 
    ITEM_PEDIDO ip ON p.cod_produto = ip.cod_produto
GROUP BY 
    c.nome
ORDER BY 
    total_vendas DESC
FETCH FIRST 3 ROWS ONLY;
