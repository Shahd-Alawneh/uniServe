// ============================
// 📁 backend/controllers/userController.js
// ============================

const bcrypt = require("bcryptjs");
const User = require("../models/userModel");
const db = require("../db");

// ============================
// 🟢 تسجيل مستخدم جديد (Sign Up)
// ============================
exports.registerUser = async (req, res) => {
  try {
    const { full_name, email, password, role } = req.body;

    if (!full_name || !email || !password)
      return res.status(400).json({ message: "All fields are required ❌" });

    // ✅ استخراج رقم الطالب
    let student_id = null;
    if (email.includes("@stu.najah.edu") && email.startsWith("s")) {
      student_id = email.slice(1, email.indexOf("@"));
    }
    if (!student_id)
      return res
        .status(400)
        .json({ message: "Invalid university email format ❌" });

    // ✅ التحقق من وجود المستخدم
    User.findByEmail(email, async (err, results) => {
      if (err)
        return res.status(500).json({ message: "Database error ❌" });

      if (results.length > 0)
        return res.status(400).json({ message: "User already exists ❌" });

      // ✅ تشفير كلمة المرور
      const hashedPassword = await bcrypt.hash(password, 10);

      // ✅ إنشاء المستخدم الجديد
      User.create(
        full_name,
        student_id,
        email,
        hashedPassword,
        role || "student",
        (err2) => {
          if (err2) {
            console.error(err2);
            return res.status(500).json({ message: "Error registering user ❌" });
          }

          return res.status(201).json({
            message: "Account created successfully ✅",
            data: { full_name, student_id, email, role: role || "student" },
          });
        }
      );
    });
  } catch (error) {
    console.error("Unexpected error:", error);
    return res.status(500).json({ message: "Server error ❌" });
  }
};

// ============================
// 🟣 تسجيل الدخول (Sign In)
// ============================
exports.loginUser = async (req, res) => {
  const { email, password } = req.body;

  if (!email || !password)
    return res.status(400).json({ message: "Please fill all fields ❌" });

  User.findByEmail(email, async (err, results) => {
    if (err) {
      console.error("Database error:", err);
      return res.status(500).json({ message: "Database error ❌" });
    }

    if (results.length === 0)
      return res.status(404).json({ message: "User not found ❌" });

    const user = results[0];
    const isMatch = await bcrypt.compare(password, user.password);

    if (!isMatch)
      return res.status(401).json({ message: "Incorrect password ❌" });

    return res.status(200).json({
      message: "Login successful ✅",
      user: {
        id: user.id,
        full_name: user.full_name,
        email: user.email,
        role: user.role,
      },
    });
  });
};

// ============================
// 🔁 إعادة تعيين كلمة المرور (Reset Password)
// ============================
exports.resetPassword = async (req, res) => {
  const { email, code, newPassword } = req.body;

  if (!email || !code || !newPassword)
    return res
      .status(400)
      .json({ message: "Please provide email, code, and new password" });

  const sql = "SELECT reset_token, reset_expires FROM users WHERE email = ?";
  db.query(sql, [email], async (err, results) => {
    if (err) return res.status(500).json({ message: "Database error ❌" });
    if (results.length === 0)
      return res.status(404).json({ message: "User not found ❌" });

    const user = results[0];

    if (!user.reset_token || !user.reset_expires)
      return res
        .status(400)
        .json({ message: "No reset request found. Please request a code first." });

    if (new Date() > new Date(user.reset_expires))
      return res
        .status(400)
        .json({ message: "Verification code expired. Request a new one." });

    if (user.reset_token !== code)
      return res.status(400).json({ message: "Invalid verification code ❌" });

    const hashed = await bcrypt.hash(newPassword, 10);
    const updateSql =
      "UPDATE users SET password = ?, reset_token = NULL, reset_expires = NULL WHERE email = ?";
    db.query(updateSql, [hashed, email], (updateErr) => {
      if (updateErr)
        return res.status(500).json({ message: "Failed to update password ❌" });

      return res.status(200).json({ message: "Password reset successful ✅" });
    });
  });
};
