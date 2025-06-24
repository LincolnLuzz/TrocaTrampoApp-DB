USE TrocaTrampoApp_DB;

-- Inserir Usuários (pelo menos 3 registros)
INSERT INTO Usuarios (nome_completo, email, telefone, data_cadastro) VALUES
('Ana Silva', 'ana.silva@email.com', '11987654321', '2024-01-15'),
('Bruno Costa', 'bruno.c@email.com', '21998765432', '2024-02-20'),
('Carlos Santos', 'carlos.s@email.com', '31976543210', '2024-03-01'),
('Daniela Lima', 'dani.lima@email.com', '41912345678', '2024-03-10');

-- Inserir Trampos (pelo menos 3 registros, associando aos usuários)
-- id_usuario_ofertante: (1 = Ana Silva, 2 = Bruno Costa, 3 = Carlos Santos, 4 = Daniela Lima)
INSERT INTO Trampos (id_usuario_ofertante, titulo, descricao, categoria, status_trampo, valor_estimado) VALUES
(1, 'Aula de Violão para Iniciantes', 'Ensino básico de violão, acordes e ritmos simples.', 'Educação', 'Disponível', 50.00),
(2, 'Manutenção de Computadores', 'Formatação, instalação de software, limpeza de hardware.', 'Tecnologia', 'Disponível', 120.00),
(3, 'Corte de Cabelo Masculino', 'Corte moderno, acabamento com navalha.', 'Beleza', 'Disponível', 30.00),
(1, 'Design de Logotipo', 'Criação de identidade visual para pequenos negócios.', 'Design', 'Disponível', 200.00);

-- Inserir Trocas (pelo menos 3 registros, associando trampos e usuários)
-- id_trampo_oferecido: (1 = Aula Violão, 2 = Manutenção PC, 3 = Corte Cabelo, 4 = Design Logotipo)
-- id_usuario_solicitante: (1 = Ana, 2 = Bruno, 3 = Carlos, 4 = Daniela)
INSERT INTO Trocas (id_trampo_oferecido, id_usuario_solicitante, data_solicitacao, status_troca) VALUES
(2, 4, '2024-04-01 10:00:00', 'Pendente'), -- Daniela solicita Manutenção PC de Bruno
(1, 3, '2024-04-05 14:30:00', 'Aceita'),   -- Carlos solicita Aula Violão de Ana
(3, 1, '2024-04-10 16:00:00', 'Concluída');  -- Ana solicita Corte Cabelo de Carlos