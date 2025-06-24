USE TrocaTrampoApp_DB; -- Certifica que estamos usando o banco de dados correto

-- ##########################################################################
-- OPERAÇÕES DE CONSULTA (SELECT)
-- ##########################################################################

-- 1. Consultar todos os Usuários
SELECT * FROM Usuarios;

-- 2. Consultar Trampos disponíveis na categoria 'Tecnologia'
SELECT * FROM Trampos
WHERE categoria = 'Tecnologia' AND status_trampo = 'Disponível';

-- 3. Consultar Trocas com status 'Pendente' e o nome do usuário solicitante
SELECT
    T.id_troca,
    U.nome_completo AS nome_solicitante,
    TR.titulo AS trampo_solicitado,
    T.data_solicitacao,
    T.status_troca
FROM Trocas AS T
JOIN Usuarios AS U ON T.id_usuario_solicitante = U.id_usuario
JOIN Trampos AS TR ON T.id_trampo_oferecido = TR.id_trampo
WHERE T.status_troca = 'Pendente';

-- 4. Consultar os trampos oferecidos por um usuário específico (Ex: Ana Silva - id_usuario = 1)
SELECT
    U.nome_completo AS Ofertante,
    TR.titulo,
    TR.descricao,
    TR.status_trampo
FROM Trampos AS TR
JOIN Usuarios AS U ON TR.id_usuario_ofertante = U.id_usuario
WHERE U.nome_completo = 'Ana Silva';


-- ##########################################################################
-- OPERAÇÕES DE ATUALIZAÇÃO (UPDATE)
-- ##########################################################################

-- 1. Atualizar o telefone de um usuário (Ex: Bruno Costa)
UPDATE Usuarios
SET telefone = '21988887777'
WHERE email = 'bruno.c@email.com';

-- 2. Atualizar o status de um trampo (Ex: Manutenção de Computadores) para 'Concluído'
UPDATE Trampos
SET status_trampo = 'Concluído'
WHERE titulo = 'Manutenção de Computadores';

-- 3. Marcar uma troca como 'Concluída' e adicionar feedback
UPDATE Trocas
SET status_troca = 'Concluída',
    feedback_solicitante = 'Serviço executado com excelência!',
    feedback_ofertante = 'Solicitante muito prestativo e pontual.'
WHERE id_troca = 1;


-- ##########################################################################
-- OPERAÇÕES DE REMOÇÃO (DELETE)
-- ##########################################################################

-- 1. Remover um trampo específico (Ex: Corte de Cabelo Masculino) e suas dependências
-- O trampo 'Corte de Cabelo Masculino' (id_trampo = 3) está associado à troca id_troca = 3
DELETE FROM Trocas WHERE id_trampo_oferecido = (SELECT id_trampo FROM Trampos WHERE titulo = 'Corte de Cabelo Masculino');
DELETE FROM Trampos WHERE titulo = 'Corte de Cabelo Masculino';


-- 2. Remover um usuário específico (Ex: Carlos Santos - id_usuario = 3) e todas as suas dependências
-- Carlos (id_usuario = 3) ofereceu um trampo (Corte de Cabelo Masculino, que já será removido acima)
-- Carlos (id_usuario = 3) solicitou uma troca (Aula de Violão, id_troca = 2)

-- Remover trocas onde Carlos é o SOLICITANTE
DELETE FROM Trocas WHERE id_usuario_solicitante = (SELECT id_usuario FROM Usuarios WHERE nome_completo = 'Carlos Santos');

-- Remover trampos OFERECIDOS por Carlos (se houver, além do que já foi apagado)
DELETE FROM Trampos WHERE id_usuario_ofertante = (SELECT id_usuario FROM Usuarios WHERE nome_completo = 'Carlos Santos');

-- Agora, remover o usuário Carlos
DELETE FROM Usuarios WHERE nome_completo = 'Carlos Santos';