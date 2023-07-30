const express = require("express");

const Document = require("../models/document");

const auth = require("../middelware/auth");

const documentRouter = express.Router();

documentRouter.post("/doc/create", auth, async (req, res) => {
  try {
    const { createdAt } = req.body;
    let document = new Document({
      uid: req.user,
      title: "Untitled Document",
      createdAt,
    });

    document = await document.save();
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = documentRouter;
