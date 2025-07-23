require("dotenv").config();
const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

const app = express();
const authRouter = require("./router/route.js");

app.use(cors());
app.use(express.json());
app.use("/", authRouter);

mongoose
  .connect("mongodb://localhost:27017/login_page")
  .then(() => {
    console.log("Database connected successfully");
    app.listen(3000, () => {
      console.log("Server is running on Port 3000");
    });
  })
  .catch(console.error());
