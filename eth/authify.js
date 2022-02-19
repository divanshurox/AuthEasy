const web3 = require("./web3");
const authifyCompiled = require("./build/authify.json");

const contract = new web3.eth.Contract(
  JSON.parse(authifyCompiled.interface),
  process.env.CONTRACT_ADDRESS
);

module.exports = contract;
