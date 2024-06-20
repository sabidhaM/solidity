// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
contract parent {
    uint256 public id;

    function set (uint256 _value) public {
        id = _value;
    }
}

contract child is parent {
    function getvalue() public view returns (uint){
        return id;
    }
} 
