-- Léo 300 · schema.sql
-- Abrigo de animais: controle das doações de insumos (ração, remédios, higiene).
-- Recria o banco do zero. Atenção: apaga os dados que já existirem.

SET NAMES utf8mb4;
DROP DATABASE IF EXISTS leo300;
CREATE DATABASE leo300 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE leo300;

CREATE TABLE doador (
  id_doador     INT AUTO_INCREMENT PRIMARY KEY,
  nome          VARCHAR(150) NOT NULL,
  email         VARCHAR(100) UNIQUE,
  telefone      VARCHAR(20),
  data_cadastro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tipo_insumo (
  id_tipo_insumo INT AUTO_INCREMENT PRIMARY KEY,
  nome           VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE insumo (
  id_insumo      INT AUTO_INCREMENT PRIMARY KEY,
  id_tipo_insumo INT NOT NULL,
  nome           VARCHAR(150) NOT NULL UNIQUE,
  especie        VARCHAR(10) NOT NULL DEFAULT 'todas'
                 CHECK (especie IN ('cao', 'gato', 'todas')),
  unidade        VARCHAR(20) NOT NULL DEFAULT 'unidade',
  FOREIGN KEY (id_tipo_insumo) REFERENCES tipo_insumo (id_tipo_insumo)
);

CREATE TABLE doacao (
  id_doacao   INT AUTO_INCREMENT PRIMARY KEY,
  id_doador   INT NOT NULL,
  data_doacao DATE NOT NULL,
  observacao  VARCHAR(255),
  criado_em   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_doador) REFERENCES doador (id_doador)
);

CREATE TABLE doacao_insumo (
  id_doacao  INT NOT NULL,
  id_insumo  INT NOT NULL,
  quantidade INT NOT NULL CHECK (quantidade > 0),
  validade   DATE,
  PRIMARY KEY (id_doacao, id_insumo),
  FOREIGN KEY (id_doacao) REFERENCES doacao (id_doacao) ON DELETE CASCADE,
  FOREIGN KEY (id_insumo) REFERENCES insumo (id_insumo)
);
