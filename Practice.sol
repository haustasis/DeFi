pragma solidity ^0.5.0;

contract EtherWallet{

  address public owner;

  constructor(address _owner) {
    owner = _owner;
  }

  function deposit() payable public{

  }

  function send(address to, uint amount) public{
    if(msg.sender == owner){
      to.transfer(amount);
      return;
    }
    revert("Sender not allowed");
  }

  function balanceOf() view public returns(uint ){
    return address(this).balance;
  }
}