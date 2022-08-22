//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
//backend works build UI and frontend

import "@openzeppelin/contracts/access/Ownable.sol"; 
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Allowance is Ownable{//add receive ether function

    using SafeMath for uint;//for wrap around and error string

    event AllowanceChange(address indexed _forWho,address _ByWho,uint _previousAmount,uint _newAmount);//indexed so we can search for it

    mapping(address => uint) public allowance;

    function addAllowance(address _who,uint _amount) public onlyOwner{//allowance on account feature
        emit AllowanceChange(_who, msg.sender, allowance[_who], _amount);
        allowance[_who]= _amount;
    }

    modifier access(uint _amount) {//modifier checking conditions on who has access
        require(owner() == _msgSender() || allowance[msg.sender] >= _amount, "Do not have allowance");
        _;
    }
 
    function reduceAllowance(address _who,uint _amount) internal {
        emit AllowanceChange(_who, msg.sender, allowance[_who], allowance[_who]-_amount);
        allowance[_who] =allowance[_who].sub(_amount); 
    }
}

contract Wallet01 is Allowance{
    event MoneySent(address indexed _SentBy,uint _amount);
    //event MoneyReceived(address indexed _from, uint _amount )

    //securing contract 
    function withdrawMoney(address payable _to,uint _amount) public access(_amount){ 
        //require(_amount<address[this].balance,"there are not enough funds");
        if(owner() != _msgSender()){
            reduceAllowance(msg.sender, _amount);
        }
        emit MoneySent(_to, _amount);
        _to.transfer(_amount);
    }

    function renounceOwnership() public view override onlyOwner {
        revert("Can't renounce ownershp");
    }

    /*function receiveMoney() public payable {
        balanceReceived += msg.value;
    }*/

    //fallback function
    event ValueReceived(address user, uint amount);
    fallback() external payable{
        emit ValueReceived(msg.sender, msg.value);

    }
} 
 /* contract Receiver {
    event ValueReceived(address user, uint amount);
    fallback() external payable {
    emit ValueReceived(msg.sender, msg.value);
    }


    const hre = require("hardhat");

async function main() {
    const Greeter = await hre.ethers.getContractFactory("Greeter");
    const greeter = await Greeter.deploy("Hello, Hardhat!");

    await greeter.deployed();

    console.log("Greeter deployed to:", greeter.address);
}

main()
    .then(()=> process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    })
}*/
