/* Apagar Usuário e o BD */

DROP DATABASE IF EXISTS uvv;
DROP USER IF EXISTS danilo;


/* Criar Usuário */

CREATE USER danilo WITH CREATEDB CREATEROLE PASSWORD '62bf43e2db266caa78d4f0bd18fb5f7e';

/* Criar BD */

CREATE DATABASE uvv
WITH
OWNER = danilo
TEMPLATE = template0
ENCODING = "UTF8"
LC_COLLATE = 'pt_BR.UTF-8'
LC_CTYPE = 'pt_BR.UTF-8'
ALLOW_CONNECTIONS = true;

/* Entrar no seu usário */


\c 'dbname = uvv user = danilo password = 62bf43e2db266caa78d4f0bd18fb5f7e'


/* Criar SCHEMA */

\c uvv
CREATE SCHEMA lojas AUTHORIZATION danilo; 

/* Torna o SCHEMA Padrão Permanentemente*/

SET search_path TO lojas, danilo, public;
ALTER USER danilo SET search_path TO lojas, danilo, public;

/* Criação das Tabelas */

CREATE TABLE lojas.produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT pk_produtos PRIMARY KEY (produto_id)
);

/* Check Constraits */

-- Verifica se o preço unitário é maior ou igual a zero 
ALTER TABLE lojas.produtos
ADD CONSTRAINT check_preco_unitario 
CHECK (preco_unitario >= 0);

--  Verifica se a coluna "imagem_mime_type" não está vazia 
ALTER TABLE lojas.produtos
ADD CONSTRAINT check_imagem_mime_type_not_empty 
CHECK (imagem_mime_type <> '');

-- Verifica se a coluna "imagem_arquivo" não está vazia 
ALTER TABLE lojas.produtos
ADD CONSTRAINT check_imagem_arquivo_not_empty 
CHECK (imagem_arquivo <> '');

--  Verifica se a coluna "imagem_charset" não está vazia 
ALTER TABLE lojas.produtos
ADD CONSTRAINT check_imagem_charset_not_empty 
CHECK (imagem_charset <> '');


/* Comentários de cada coluna da tabela produtos */

COMMENT ON TABLE lojas.produtos IS 'Produtos e suas especificações.';
COMMENT ON COLUMN lojas.produtos.produto_id IS 'Indentificação única criada para cada produto.';
COMMENT ON COLUMN lojas.produtos.nome IS 'Nome do produto.';
COMMENT ON COLUMN lojas.produtos.preco_unitario IS 'Preço de cada produto separadamente.';
COMMENT ON COLUMN lojas.produtos.detalhes IS 'Detalhes que cada produto apresenta.';
COMMENT ON COLUMN lojas.produtos.imagem IS 'Imagem do produto.';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type IS 'Variedade de documentos transmitidos com a imagem.';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS 'Tipo de arquivo onde se encontra a imagem dos produto.';
COMMENT ON COLUMN lojas.produtos.imagem_charset IS 'Variedade de caracteres presentes na imagem.';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'Data da última atualização feita da imagem.';


CREATE TABLE lojas.lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT pk_loja PRIMARY KEY (loja_id)
);

/* Check Constraits */

-- Verifica se o tamanho da coluna "nome" não está vazio
ALTER TABLE lojas.lojas
ADD CONSTRAINT check_nome_not_empty 
CHECK (nome <> '');

-- Verificar se pelo menos uma das colunas de endereço está preenchida
ALTER TABLE lojas.lojas
ADD CONSTRAINT check_endereco
CHECK (endereco_web IS NOT NULL OR endereco_fisico IS NOT NULL);

-- Verifica se a latitude está dentro do intervalo válido (-90 a 90)
ALTER TABLE lojas.lojas
ADD CONSTRAINT check_latitude_range 
CHECK (latitude IS NULL OR (latitude >= -90 AND latitude <= 90));

-- Verifica se a longitude está dentro do intervalo válido (-180 a 180)
ALTER TABLE lojas.lojas
ADD CONSTRAINT check_longitude_range 
CHECK (longitude IS NULL OR (longitude >= -180 AND longitude <= 180));

-- Verifica se a coluna "logo_mime_type" não está vazia
ALTER TABLE lojas.lojas
ADD CONSTRAINT check_logo_mime_type_not_empty 
CHECK (logo_mime_type <> '');

-- Verifica se a coluna "logo_arquivo" não está vazia
ALTER TABLE lojas.lojas
ADD CONSTRAINT check_logo_arquivo_not_empty 
CHECK (logo_arquivo <> '');

-- Verifica se a coluna "logo_charset" não está vazia
ALTER TABLE lojas.lojas
ADD CONSTRAINT check_logo_charset_not_empty 
CHECK (logo_charset <> '');



/* Comentários de cada coluna da tabela lojas */

COMMENT ON COLUMN lojas.lojas.loja_id IS 'Identificação única criada para cada loja.';
COMMENT ON COLUMN lojas.lojas.nome IS 'Nome da loja.';
COMMENT ON COLUMN lojas.lojas.endereco_web IS 'Link para achar a pagina web da loja.';
COMMENT ON COLUMN lojas.lojas.endereco_fisico IS 'Localização geográfica específica da loja';
COMMENT ON COLUMN lojas.lojas.latitude IS 'Latitude de onde se encontra a loja.';
COMMENT ON COLUMN lojas.lojas.longitude IS 'Longitude onde se encontra a loja.';
COMMENT ON COLUMN lojas.lojas.logo IS 'Arquivo que possui a logo da loja';
COMMENT ON COLUMN lojas.lojas.logo_mime_type IS 'Variedade de documentos transmitidos com a logo';
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS 'Tipo do arquivo onde se encontra a logo.';
COMMENT ON COLUMN lojas.lojas.logo_charset IS 'Variedade de caracteres presentes na logo.';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'Data da última atualização feita da logo.';


CREATE TABLE lojas.estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id_estoques NUMERIC(38) NOT NULL,
                produto_id_estoques NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT pk_estoques PRIMARY KEY (estoque_id)
);

/* Check Constraits */

-- Verificar se a quantidade é maior ou igual a zero
ALTER TABLE lojas.estoques
ADD CONSTRAINT check_quantidade 
CHECK (quantidade >= 0);

-- Verificar se que o valor da coluna é maior ou igual a zero
ALTER TABLE lojas.estoques
ADD CONSTRAINT check_loja_id_estoques
CHECK (loja_id_estoques >= 0);

-- Verificra se o valor da coluna é maior ou igual a zero
ALTER TABLE lojas.estoques
ADD CONSTRAINT check_produto_id_estoques
CHECK (produto_id_estoques >= 0);

/* Comentários de cada coluna estoques */

COMMENT ON TABLE lojas.estoques IS 'Estoque que mostra quais e quantos produtos estão disponiveis no momento em cada loja.';
COMMENT ON COLUMN lojas.estoques.estoque_id IS 'Indentificação única criada para cada estoque.';
COMMENT ON COLUMN lojas.estoques.loja_id_estoques IS 'Identificação única criada para cada loja.';
COMMENT ON COLUMN lojas.estoques.produto_id_estoques IS 'Indentificação única criada para cada produto.';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'Quantidade de determinado produto presento no estoque.';


CREATE TABLE lojas.clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone3 VARCHAR(20),
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                CONSTRAINT pk_cliente PRIMARY KEY (cliente_id)
);



-- Verificar se estão em um formato válido de telefone
ALTER TABLE lojas.clientes
ADD CONSTRAINT check_telefone_valid
CHECK (
    (telefone1 IS NULL OR telefone1 ~* '^\d{10,}$') AND
    (telefone2 IS NULL OR telefone2 ~* '^\d{10,}$') AND
    (telefone3 IS NULL OR telefone3 ~* '^\d{10,}$')
);

/* Comentários de cada coluna da tabela clientes */

COMMENT ON TABLE lojas.clientes IS 'Esta tabela contem informações a respeito dos clientes, como o nome dele e contatos.';
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'Identificação única criada para cada cliente.';
COMMENT ON COLUMN lojas.clientes.email IS 'Email do cliente.';
COMMENT ON COLUMN lojas.clientes.nome IS 'Nome completo do cliente.';
COMMENT ON COLUMN lojas.clientes.telefone3 IS 'Terceiro telefone de contato do cliente.';
COMMENT ON COLUMN lojas.clientes.telefone1 IS 'Primeiro telefone de contatdo do cliente.';
COMMENT ON COLUMN lojas.clientes.telefone2 IS 'Segundo telefone de contato do cliente.';


CREATE TABLE lojas.envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id_envios NUMERIC(38) NOT NULL,
                cliente_id_envios NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                estoque_id_envios NUMERIC(38) NOT NULL,
                CONSTRAINT pk_envio PRIMARY KEY (envio_id)
);

-- Verificar se o status está em um conjunto específico de valores
ALTER TABLE lojas.envios
ADD CONSTRAINT check_status
CHECK (status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));

-- Verificar se o loja_id_envios é maior que zero
ALTER TABLE lojas.envios
ADD CONSTRAINT check_loja_id_envios
CHECK (loja_id_envios > 0);

-- Verificar se o cliente_id_envios é maior que zero
ALTER TABLE lojas.envios
ADD CONSTRAINT check_cliente_id_envios
CHECK (cliente_id_envios > 0);

-- Verificar se o estoque_id_envios é maior que zero
ALTER TABLE lojas.envios
ADD CONSTRAINT check_estoque_id_envios
CHECK (estoque_id_envios > 0);

/* Comentários de cada coluna da tabela envios */

COMMENT ON TABLE lojas.envios IS 'Pedidos enviados';
COMMENT ON COLUMN lojas.envios.envio_id IS 'Indetificação única criada para cada envio.';
COMMENT ON COLUMN lojas.envios.loja_id_envios IS 'Identificação única criada para cada loja.';
COMMENT ON COLUMN lojas.envios.cliente_id_envios IS 'Identificação única criada para cada cliente.';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'Localização geográfica de onde o produto terá que ser entregue.';
COMMENT ON COLUMN lojas.envios.status IS 'Informação sobre onde se encontra o pedido no momento.';
COMMENT ON COLUMN lojas.envios.estoque_id_envios IS 'Codificação única criada para cada estoque.';


CREATE TABLE lojas.pedidos (
                pedidos_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pk_pedidos PRIMARY KEY (pedidos_id)
);


-- Verificar se o status está em um conjunto específico de valores
ALTER TABLE lojas.pedidos
ADD CONSTRAINT check_status
CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO','REEMBOLSADO' 
'ENVIADO'));

--  Verificar se o cliente_id é maior que zero
ALTER TABLE lojas.pedidos
ADD CONSTRAINT check_cliente_id
CHECK (cliente_id > 0);

--  Verificar se o loja_id é maior que zero
ALTER TABLE lojas.pedidos
ADD CONSTRAINT check_loja_id
CHECK (loja_id > 0);

/* Comentários de cada coluna da tabela pedidos */

COMMENT ON TABLE lojas.pedidos IS 'Esta tabela mostra informações dos pedidos feitos por determinado cliente.';
COMMENT ON COLUMN lojas.pedidos.pedidos_id IS 'Identificação única criada para cada pedido.';
COMMENT ON COLUMN lojas.pedidos.data_hora IS 'Data e a hora em que o cliente enviou (executou) seu pedido.';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'Identificação única criada para cada cliente.';
COMMENT ON COLUMN lojas.pedidos.status IS 'Informa a situação que se encontra o pedido feito pelo cliente.';
COMMENT ON COLUMN lojas.pedidos.loja_id IS 'Identificação única criada para cada loja.';


CREATE TABLE lojas.pedidos_itens (
                pedidos_id_pedidos_itens NUMERIC(38) NOT NULL,
                produto_id_pedidos_itens NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id_pedidos_itens NUMERIC(38),
                CONSTRAINT pk_pedidos_itens PRIMARY KEY (pedidos_id_pedidos_itens, produto_id_pedidos_itens)
);

-- Verificar se o número da linha é maior que zero
ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT check_numero_da_linha
CHECK (numero_da_linha > 0);

-- Verificar se o preço unitário é maior que zero
ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT check_preco_unitario
CHECK (preco_unitario > 0);

-- Verificar se a quantidade é maior que zero
ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT check_quantidade
CHECK (quantidade > 0);

-- Verificar se envio_id_pedidos_itens é maior ou igual a zero
ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT check_envio_id_pedidos_itens
CHECK (envio_id_pedidos_itens >= 0);

/* Comentários de cada coluna da tabela pedidos_itens */

COMMENT ON TABLE lojas.pedidos_itens IS 'Itens presentes no pedido de cada cliente específico.';
COMMENT ON COLUMN lojas.pedidos_itens.pedidos_id_pedidos_itens IS 'Identificação única criada para cada pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id_pedidos_itens IS 'Indentificação única criada para cada produto.';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'Posição que se encontra na lista de pedidos.';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS 'Preço individual de cada produto dentro de determinado pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS 'Quantidade de produtos dentro do pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id_pedidos_itens IS 'Indetificação única criada para cada envio.';

/* Relacionamento entre as tabelas */
ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id_estoques)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id_pedidos_itens)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id_envios)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id_estoques)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT estoques_envios_fk
FOREIGN KEY (estoque_id_envios)
REFERENCES lojas.estoques (estoque_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id_envios)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id_pedidos_itens)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedidos_id_pedidos_itens)
REFERENCES lojas.pedidos (pedidos_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


/* Inserts */