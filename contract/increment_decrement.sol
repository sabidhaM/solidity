// SPDX-License-Identifier: GPL -3.0
pragma solidity ^0.8.0;
 contract count{
    uint public value =0;

    function increment() public {
        value += 1;
    }
    function decrement() public{
        value -= 1;
    }
    function get() public view returns(uint){
        return value;
    }
 }
