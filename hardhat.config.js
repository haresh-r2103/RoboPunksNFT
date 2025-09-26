require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

const { task } = require("hardhat/config");

task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();
  for (const account of accounts) {
    console.log(account.address);
  }
});

module.exports = {
  solidity: "0.8.28",
  networks: {
    sepolia: {
      url: process.env.REACT_APP_SEPOLIA_URL,
      accounts: [process.env.REACT_APP_SEP1_PK],
    },
  },
  etherscan: {
    apiKey: process.env.REACT_APP_ETHERSCAN_URL,
  },
};
