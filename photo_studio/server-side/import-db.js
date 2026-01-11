const fs = require("fs");
const mysql = require("mysql2/promise");
require("dotenv").config();

(async () => {
  try {
    const connection = await mysql.createConnection({
      host: "mysql.railway.internal",
      user: "root",
      password: process.env.MYSQLPASSWORD,
      database: "railway",
      port: 3306
    });

    const sql = fs.readFileSync("import.sql", "utf8");

    await connection.query(sql);

    console.log("Database imported successfully");
    process.exit(0);
  } catch (err) {
    console.error("Import failed:", err);
    process.exit(1);
  }
})();
