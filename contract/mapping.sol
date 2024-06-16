// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract mycontract {
    mapping(uint => bool) public myContact;

    function set(uint _no, bool i) public {
        myContact[_no] = i;
    }

    function get(uint _no) public view returns (bool) {
        return myContact[_no];
    }
}
