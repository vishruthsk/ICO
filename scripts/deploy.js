const {ethers} =require("hardhat");
require("hardhat").config({path:".env"})
const {VIPER_NFT_CONTRACT_ADDRESS} = require("../constants");

async function main(){
    const ICO = await ethers.getContractFactory("ICO");
    const deployedICOcontract  = await ICOcontract.deploy();
    await deployedICOcontract.deployed();
    console.log("ICO contract address", deployedICOcontract.address);
      
}
main()
  .then(()=> process.exit(0))
  .catch((error)=>{
      console.error(error);
      process.exit(1);
  });
