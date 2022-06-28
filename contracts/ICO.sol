//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./iviper.sol";

contract ICO is ERC20, Ownable{
    iviper nft;
    uint256 public constant tokenspernft=10*10**18;// 1 token = 1*10**18 (mint takes big number)
    uint256 public tokenprice=0.001 ether;
    uint256 public constant maxtotalsupply= 10000*10**18;
    mapping(uint256 => bool) public tokenIdsclaimed;
    constructor(address _vipercontract) ERC20("Viper","VIP"){
         nft = iviper(_vipercontract);

    }
    function mint(uint256 amt)public payable{
        uint256 _reqamt = amt*tokenprice;
        require(msg.value > _reqamt,"not enoough ether");
        uint256 amtdecimal= amt*10**18;
        require(totalSupply()+amtdecimal <= maxtotalsupply,"exceeds max total supply");
        _mint(msg.sender,amtdecimal);

    }
    function claim() public{
        address sender = msg.sender;
        uint256 balance = nft.balanceOf(sender);
        require(balance>0,"you dont have enough balance");
        uint256 amount;//number of nft not been minted
        for(uint256 i;i< balance;i++){
            uint256 tokenId= nft.tokenOfOwnerbyIndex(sender, i);
            if(!tokenIdsclaimed[tokenId]){
                amount+=1;
                tokenIdsclaimed[tokenId]=true;

            }

        }
        require(amount>0,"you have claimed all your tokens");
        _mint(msg.sender, amount * tokenspernft);


    }
    receive() external payable{

    }
    fallback() external payable{
        
    } 

}