const express = require("express");
const User = require("../models/user");

const authRouter = express.Router();

authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, profilePic } = req.body;

    let user = await User.findOne({ email });

    // Checking if the user already exists or not in the collec
    if (user) {
      res.status(400).json({ error: "user already exist" });
    } else {
      user = new User({
        name,
        email,
        profilePic,
      });
      user = await user.save();
      res.status(201).json({ success: "User inserted successfully" });
    }
  } catch (error) {
    console.log(error);
  }
});

authRouter.get("/", async (req, res) => {
  let user = await User.find(req.user);
  res.json({ user });
});

module.exports = authRouter;
