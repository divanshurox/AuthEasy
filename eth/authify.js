const web3 = require("./web3");
const authifyCompiled = require("./build/authify.json");

export default new web3.eth.Contract(
  JSON.parse(authifyCompiled.interface),
  "0xb4c0c4985934866c95026827064637aD09280B1E"
);
