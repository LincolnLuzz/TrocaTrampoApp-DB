// server.js
const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');

const app = express();
const port = 3001; // Porta onde o servidor Express vai rodar

// Middleware para permitir que o Express lide com JSON nas requisições
app.use(express.json());
// Middleware para permitir requisições de diferentes origens (importante para o frontend)
app.use(cors());

// Configuração da conexão com o banco de dados MySQL
const db = mysql.createConnection({
    host: 'localhost',      // Geralmente 'localhost' para desenvolvimento local
    user: 'root',           // O usuário que você configurou no MySQL Installer
    password: 'Brasil#33', // A senha que você ANOTOU durante a instalação do MySQL
    database: 'TrocaTrampoApp_DB' // O nome do banco de dados que seu schema.sql cria
});

// Conectar ao banco de dados
db.connect(err => {
    if (err) {
        console.error('Erro ao conectar ao banco de dados:', err);
        return;
    }
    console.log('Conectado ao banco de dados MySQL!');
});

// ######################################################################
// ROTA PARA TESTAR O CADASTRO DE USUÁRIOS
// ######################################################################

// Rota POST para cadastrar um novo usuário
app.post('/api/usuarios', (req, res) => {
    const { nome_completo, email, telefone } = req.body;

    // Validação básica (campos obrigatórios)
    if (!nome_completo || !email) {
        return res.status(400).json({ message: 'Nome completo e e-mail são obrigatórios.' });
    }

    // Simula a data de cadastro como a data atual
    const data_cadastro = new Date().toISOString().slice(0, 10); // Formato YYYY-MM-DD

    const query = 'INSERT INTO Usuarios (nome_completo, email, telefone, data_cadastro) VALUES (?, ?, ?, ?)';
    db.query(query, [nome_completo, email, telefone, data_cadastro], (err, result) => {
        if (err) {
            // Erro de e-mail duplicado (Error Code 1062)
            if (err.code === 'ER_DUP_ENTRY') {
                return res.status(409).json({ message: 'Este e-mail já está cadastrado. Por favor, use outro.' });
            }
            console.error('Erro ao cadastrar usuário:', err);
            return res.status(500).json({ message: 'Erro interno ao cadastrar usuário.' });
        }
        res.status(201).json({ message: 'Usuário cadastrado com sucesso!', userId: result.insertId });
    });
});

// Rota GET para listar todos os usuários (útil para verificar o cadastro)
app.get('/api/usuarios', (req, res) => {
    const query = 'SELECT id_usuario, nome_completo, email, telefone, data_cadastro FROM Usuarios';
    db.query(query, (err, results) => {
        if (err) {
            console.error('Erro ao buscar usuários:', err);
            return res.status(500).json({ message: 'Erro interno ao buscar usuários.' });
        }
        res.status(200).json(results);
    });
});


// Iniciar o servidor
app.listen(port, () => {
    console.log(`Servidor rodando em http://localhost:${port}`);
    console.log(`Rotas disponíveis:`);
    console.log(`  POST /api/usuarios (para cadastrar novo usuário)`);
    console.log(`  GET /api/usuarios (para listar todos os usuários)`);
});