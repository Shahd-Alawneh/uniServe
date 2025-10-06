// ============================
// 📁 backend/models/userModel.js
// ============================

const db = require("../db");

const User = {
  // ✅ إنشاء مستخدم جديد
  create: (full_name, student_id, email, password, role, callback) => {
    const query = `
  INSERT INTO users (full_name, student_id, email, password, role, created_at)
  VALUES (?, ?, ?, ?, ?, NOW())
`;
db.query(query, [full_name, student_id, email, password, role], callback);

  },

  // ✅ البحث عن مستخدم حسب الإيميل
  findByEmail: (email, callback) => {
    const query = "SELECT * FROM users WHERE email = ?";
    db.query(query, [email], callback);
  },
};

module.exports = User;
