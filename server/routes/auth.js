const express = require("express");
const User = require("../models/user");
const jsonToken = require("jsonwebtoken");
const auth = require("../middelware/auth");
const authRouter = express.Router();

authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, profilePic } = req.body;

    let user = await User.findOne({ email });

    // Checking if the user already exists or not in the collec
    if (!user) {
      user = new User({
        name,
        email,
        profilePic,
      });
      user = await user.save();
    } else if (user) {
      res.status(201).json({ error: "user already exist" });
      user = await user.save();
    }

    const token = jsonToken.sign({ id: user._id }, "passwordKey");

    res.json({ user, token });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

authRouter.get("/", auth, async (req, res) => {
  const user = await User.findById(req.user);
  res.json({ user, token: req.token });
});

module.exports = authRouter;
