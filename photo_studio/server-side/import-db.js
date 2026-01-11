const fs = require('fs');
const path = require('path');

const sql = fs.readFileSync(path.join(__dirname, 'import.sql'), 'utf8');

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
