const jsonToken = require("jsonwebtoken");

const auth = (req, res, next) => {
  try {
    const token = req.header("x-auth-token");

    if (!token) {
      return res.status(401).json({ msg: "No token found, access denied" });
    }
    const verified = jsonToken.verify(token, "passwordKey");
    if (!verified) {
      return res
        .status(401)
        .json({ msg: "Token verification failed, Authorization Denied" });
    }

    req.user = verified.id;
    req.token = token;
    next();
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
};

module.exports = auth;
