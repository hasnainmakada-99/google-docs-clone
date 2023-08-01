const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");
const cors = require("cors");
var http = require("http");

const documentRouter = require("./routes/document");

const PORT = process.env.PORT | 3001;
const username = encodeURIComponent("hasnainmakada");
const password = encodeURIComponent("Hasnain@123");

const DB_CONNECT = `mongodb+srv://${username}:${password}@cluster0.a3fbatx.mongodb.net/?retryWrites=true&w=majority`;

const app = express();

app.use(express.json());
app.use(cors());
app.use(documentRouter);
app.use(authRouter);

var server = http.createServer(app);
var io = require("socket.io")(server);

mongoose
  .connect(DB_CONNECT)
  .then(() => {
    console.log("Connection succesfull");
  })
  .catch((err) => {
    console.log(`Some Error occured while connecting to mongoDB ${err}`);
  });

io.on("connection", (socket) => {
  socket.on("join", (documentId) => {
    socket.join(documentId);
  });
});

app.listen(PORT, "0.0.0.0", (req, res) => {
  console.log(`Connected to http://localhost:${PORT}`);
});
