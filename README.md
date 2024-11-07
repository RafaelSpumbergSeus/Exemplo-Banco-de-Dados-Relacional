# Esquema de Banco de Dados Relacional
# Trabalho realizado para a cadeira de Banco de Dados II
Este projeto define um esquema de banco de dados relacional para gerenciamento de clientes, incluindo informações específicas para pessoas físicas e jurídicas. Abaixo estão as tabelas principais, suas colunas e os relacionamentos definidos entre elas.

Tabelas

1. CLIENTE
Tabela que armazena informações gerais dos clientes.
Colunas:
- cod_cliente: Identificador único do cliente (chave primária).
- nome: Nome do cliente.
- data_cadastro: Data de cadastro do cliente.
- tipo: Tipo de cliente (F para pessoa física, J para pessoa jurídica).

2. PESSOA_JURIDICA
Tabela que armazena dados específicos para clientes do tipo pessoa jurídica.
Colunas:
- cod_cliente: Identificador, referenciando CLIENTE.
- cnpj: CNPJ da empresa (único).
- razao_social: Razão social da empresa.

3. PESSOA_FISICA
Tabela que armazena dados específicos para clientes do tipo pessoa física.
Colunas:
- cod_cliente: Identificador, referenciando CLIENTE.
- cpf: CPF do cliente (único).
- data_nascimento: Data de nascimento.
- genero: Gênero do cliente (F para feminino, M para masculino).
- cod_empresa: Relacionamento opcional com PESSOA_JURIDICA (empresa empregadora).

4. ESTADO
Tabela que armazena as unidades federativas.
Colunas:
- uf: Sigla do estado (chave primária).
- nome: Nome do estado.

Relacionamentos
CLIENTE é a tabela principal e é referenciada tanto por PESSOA_JURIDICA quanto por PESSOA_FISICA.
PESSOA_FISICA pode ter um vínculo opcional (cod_empresa) com PESSOA_JURIDICA, representando o empregador da pessoa física.
Restrições e Integridade
Tipos de cliente definidos como 'F' para pessoa física e 'J' para pessoa jurídica.
Restrições de unicidade em cpf (PESSOA_FISICA) e cnpj (PESSOA_JURIDICA).
Chaves estrangeiras garantem a integridade referencial entre as tabelas.
