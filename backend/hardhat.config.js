//const { artifacts } = require("hardhat");
require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-web3");
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.9",
  paths: {
    artifacts: './artifacts',
  },
  networks: {
    hardhat: {
      chainId: 1337,
    }
  }
};
