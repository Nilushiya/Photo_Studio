// import-db.js
const mysql = require('mysql2');  // <-- require mysql2
const fs = require('fs');
const path = require('path');

// create connection
const db = mysql.createConnection({
  host: process.env.MYSQLHOST,        // e.g. hopper.proxy.rlwy.net
  user: process.env.MYSQLUSER,        // e.g. root
  password: process.env.MYSQLPASSWORD,// your Railway DB password
  database: process.env.MYSQLDATABASE,// your Railway DB name
  port: Number(process.env.MYSQLPORT),// your Railway DB port
  ssl: { rejectUnauthorized: false },
  multipleStatements: true             // important for multiple CREATE TABLE statements
});

// read SQL file
const sql = fs.readFileSync(path.join(__dirname, 'import.sql'), 'utf8');

// connect and run
db.connect(err => {
  if (err) {
    console.error('DB connection error:', err);
    return;
  }
  console.log('Connected to DB');

  db.query(sql, (err, result) => {
    if (err) {
      console.error('Import failed:', err);
      return;
    }
    console.log('Database imported successfully!');
    db.end();
  });
});
