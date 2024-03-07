pragma solidity ^0.5.0;

contract ownerdetail{
    address public owner;

    constructor() public{
        owner = msg.sender;
    }

    function getowner( )external view returns(address){
        require(msg.sender == owner, "it is not owner");

        return owner;
        
    } 
}
