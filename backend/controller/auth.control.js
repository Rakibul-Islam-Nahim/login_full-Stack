const userModel = require("../models/user.model.js");
const bcrypt = require("bcrypt");

let isAuthorized = false;

const _getUsers = async (req, res) => {
  const users = await userModel.find();
  // if (!isAuthorized) {
  //   return res.status(401).json({ message: "Unauthorized User" });
  // }
  res.json(users);
};

const _signupUser = async (req, res) => {
  const { username, password, email, mobile } = req.body;
  const salt = await bcrypt.genSalt();
  const hashedPassword = await bcrypt.hash(password, salt);
  const user = {
    username: username,
    password: hashedPassword,
    email: email,
    mobile: mobile,
  };
  await userModel.create(user);
  res.status(201).json({ message: "User created" });
};

const _loginUser = async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await userModel.findOne({ email: email });
    if (!user) {
      return res.status(404).json({ message: "User Not Found" });
    }
    const isValidPass = await bcrypt.compare(password, user.password);
    if (!isValidPass) {
      return res.status(401).json({ message: "Incorrect Password" });
    }
    isAuthorized = true;
    res
      .status(200)
      .json({ message: `${user.username} logged in successfully` });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

const _logoutUser = (req, res) => {
  isAuthorized = false;
  res.status(200).json({ message: "Logout Successfully" });
};

module.exports = {
  _getUsers,
  _loginUser,
  _logoutUser,
  _signupUser,
};
