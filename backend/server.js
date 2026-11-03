const express = require('express');
const mysql = require('mysql2');

const app = express();

// Pool reconnects automatically if the MySQL pod restarts
const pool = mysql.createPool({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT || 3306,
  user: 'root',
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  waitForConnections: true,
  connectionLimit: 10
});

app.get('/api/health', (req, res) => res.json({ status: 'ok' }));

app.get('/api/employees', (req, res) => {
  pool.query('SELECT * FROM employees', (err, results) => {
    if (err) {
      console.error(err);
      return res.status(500).json({ error: 'Database error' });
    }
    res.json(results);
  });
});

app.listen(3000, () => console.log('Backend running on port 3000'));
