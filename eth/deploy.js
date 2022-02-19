const HDWalletProvider = require("@truffle/hdwallet-provider");
const Web3 = require("web3");
const authifyCompiled = require("./build/authify.json");

const provider = new HDWalletProvider(
  "evil happy cost tail minimum traffic veteran usual fatal churn child adjust",
  "https://rinkeby.infura.io/v3/bc9645c89d7c408da28a4cd3b84b91c3"
);

const web3 = new Web3(provider);

let accounts;
let authify;

const deploy = async () => {
  accounts = await web3.eth.getAccounts();

  authify = await new web3.eth.Contract(JSON.parse(authifyCompiled.interface))
    .deploy({ data: authifyCompiled.bytecode })
    .send({ from: accounts[0] });

  console.log(authify.options.address);
};
deploy();
