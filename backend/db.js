<<<<<<< HEAD
const mysql = require("mysql2");
require("dotenv").config();

const db = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  port: process.env.DB_PORT
});

=======
// ============================
// 📁 backend/db.js
// ============================
require('dotenv').config(); // لقراءة القيم من ملف .env
const mysql = require("mysql2");

// 🧩 إنشاء الاتصال باستخدام متغيرات البيئة أو القيم الافتراضية
const db = mysql.createConnection({
  host: process.env.DB_HOST || "localhost",
  user: process.env.DB_USER || "root",
  password: process.env.DB_PASSWORD || "Shahi@18102003",
  database: process.env.DB_NAME || "uniserve",
});

// 🟢 اختبار الاتصال بقاعدة البيانات
>>>>>>> 6e5706d374dcc1f382712f0320126ff8d193055f
db.connect((err) => {
  if (err) {
    console.error("❌ Database connection failed:", err);
  } else {
    console.log("✅ Connected to MySQL database successfully!");
  }
});

module.exports = db;
