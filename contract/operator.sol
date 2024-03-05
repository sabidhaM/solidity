// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract operators{
    uint public addOperator;
    uint public subOperator = 6;

    function getresult(uint _addOperation) public {
         addOperator += _addOperation;
         subOperator -= 1;
         return;
    }
}
