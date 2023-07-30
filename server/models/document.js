const mongoose = require("mongoose");

const documentScheme = mongoose.Schema({
  uid: {
    required: true,
    type: String,
  },
  title: {
    required: true,
    type: String,
    trim: true,
  },
  createdAt: {
    required: true,
    type: Number,
  },
  content: {
    type: Array,
    default: [],
  },
});

const Document = mongoose.model("Document", documentScheme);

module.exports = Document;
