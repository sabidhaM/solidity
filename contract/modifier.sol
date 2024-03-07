// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract Owner{
    string private name;
    address public owner;

    constructor(){
        owner = msg.sender;
    }
    modifier onlyOwner(){
        require( msg.sender == owner,"not owner");
        _;
    }
    

    function setname(string memory _newname) public onlyOwner{
        name = _newname;
    }

    function OwnerDetails() public view returns(string memory ,address){
        return(name,owner);
        
    }
}
