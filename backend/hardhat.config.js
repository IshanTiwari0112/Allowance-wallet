//const { artifacts } = require("hardhat");
require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-web3");

const INFURA_API_KEY = [process.env.INFURA_API_URL]
const ROPSTEIN_PRIVATE_KEY = [process.env.ROPSTEIN_PRIVATE_KEY];
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.9",
  paths: {
    artifacts: './artifacts',
  },
  networks: {
    ropstein: {
      url: [INFURA_API_KEY],
      accounts: [ROPSTEIN_PRIVATE_KEY]
    }
  }
};
