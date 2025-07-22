const express = require("express");
const router = express.Router();
const {
  _getUsers,
  _signupUser,
  _loginUser,
  _logoutUser,
} = require("../controller/auth.control.js");

router.get("/", _getUsers);
router.post("/signup", _signupUser);
router.post("/login", _loginUser);
router.get("/logout", _logoutUser);

module.exports = router;
