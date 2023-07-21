const express = require("express");
const mongoose = require("mongoose");

const PORT = process.env.PORT | 3001;
const username = encodeURIComponent("hasnainmakada");
const password = encodeURIComponent("Hasnain@123");

const DB_CONNECT = `mongodb+srv://${username}:${password}@cluster0.a3fbatx.mongodb.net/?retryWrites=true&w=majority`;

const app = express();

mongoose
  .connect(DB_CONNECT)
  .then(() => {
    console.log("Connection succesfull");
  })
  .catch((err) => {
    console.log(`Some Error occured while connecting to mongoDB ${err}`);
  });

app.listen(PORT, "0.0.0.0", (req, res) => {
  console.log(`Connected to http://localhost:${PORT}`);
});
