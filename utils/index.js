const crypto = require("crypto");

function hashEmail(email) {
  return crypto.createHash("md5").update(email).digest("hex");
}

module.exports = {
  hashEmail,
};
