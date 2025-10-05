// ============================
// 📁 backend/server.js
// ============================
require('dotenv').config();
const express = require("express");
const cors = require("cors");
const db = require("./db"); // الاتصال بقاعدة البيانات
const userRoutes = require("./routes/userRoutes"); // استيراد راوتر المستخدمين

const app = express();
const PORT = process.env.PORT || 5000;

// 🧩 Middleware
app.use(cors());
app.use(express.json());

// 🧭 Routes
app.use("/api/users", userRoutes);

// 🟢 اختبار الاتصال بقاعدة البيانات
db.connect((err) => {
  if (err) {
    console.error("❌ Database connection failed:", err);
  } else {
    console.log("✅ Connected to MySQL database successfully!");
  }
});

// 🚀 Start the server
app.listen(PORT, () => {
  console.log(`✅ Server is running on port ${PORT}`);
});
