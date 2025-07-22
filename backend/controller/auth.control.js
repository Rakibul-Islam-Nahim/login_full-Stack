const userModel = require("../models/user.model.js");
const bcrypt = require("bcrypt");

let isAuthorized = false;

const _getUsers = async (req, res) => {
  const users = await userModel.find();
  if (!isAuthorized) {
    return res.status(401).send("Unauthorized Access");
  }
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
  res.send(`${username} user is created`);
};

const _loginUser = async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await userModel.findOne({ email: email });
    if (!user) {
      return res.status(404).send("User Not Found");
    }
    const isValidPass = await bcrypt.compare(password, user.password);
    if (!isValidPass) {
      return res.status(401).send("Incorrect Password");
    }
    isAuthorized = true;
    res.status(200).send(`${user.username} logged in successfully`);
  } catch (err) {
    res.status(500).send(err.message);
  }
};

const _logoutUser = (req, res) => {
  isAuthorized = false;
  res.status(200).send("Logout Successfully");
};

module.exports = {
  _getUsers,
  _loginUser,
  _logoutUser,
  _signupUser,
};
