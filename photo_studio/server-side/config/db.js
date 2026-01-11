const mysql = require('mysql2');
require('dotenv').config();

// Option: Using .env variables
const db = mysql.createConnection({
  host: process.env.MYSQLHOST,
  user: process.env.MYSQLUSER,
  password: process.env.MYSQLPASSWORD,
  database: process.env.MYSQLDATABASE,
  port: Number(process.env.MYSQLPORT),
  multipleStatements: true
});

db.connect((err) => {
    if(err){
        console.error('Database connection failed.', err.stack); // corrected
        return;
    }
    console.log('Connected to MySQL database.');
});

module.exports = db;
