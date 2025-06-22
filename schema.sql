-- Comandos para limpar o banco de dados antes de recriá-lo (útil para reexecuções)
DROP DATABASE IF EXISTS TrocaTrampoApp_DB;

-- Criação do Banco de Dados
CREATE DATABASE IF NOT EXISTS TrocaTrampoApp_DB;
USE TrocaTrampoApp_DB;

-- Tabela Usuarios
CREATE TABLE Usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome_completo VARCHAR(150) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    data_cadastro DATE
);

-- Tabela Trampos (ou Servicos)
CREATE TABLE Trampos (
    id_trampo INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario_ofertante INT NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    descricao VARCHAR(500),
    categoria VARCHAR(50),
    status_trampo VARCHAR(20),
    valor_estimado DECIMAL(10, 2),
    FOREIGN KEY (id_usuario_ofertante) REFERENCES Usuarios(id_usuario)
);

-- Tabela Trocas (ou Transacoes)
CREATE TABLE Trocas (
    id_troca INT AUTO_INCREMENT PRIMARY KEY,
    id_trampo_oferecido INT NOT NULL,
    id_usuario_solicitante INT NOT NULL,
    data_solicitacao DATETIME NOT NULL,
    status_troca VARCHAR(50),
    feedback_solicitante TEXT,
    feedback_ofertante TEXT,
    FOREIGN KEY (id_trampo_oferecido) REFERENCES Trampos(id_trampo),
    FOREIGN KEY (id_usuario_solicitante) REFERENCES Usuarios(id_usuario)
);