const hre = require("hardhat");


async function main() {
    const RoboPunksNFT = await hre.ethers.getContractFactory("RoboPunksNFT");
    const roboPunksNFT = await RoboPunksNFT.deploy();
    await roboPunksNFT.waitForDeployment();
    console.log("RoboPunksNFT deployed to:", roboPunksNFT.target);
}

main().catch(err => {
    console.error(err);
    process.exit(1);
});
