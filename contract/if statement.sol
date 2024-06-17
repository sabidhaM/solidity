// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract statement {
    string public Technology;

    function Tech(uint256 _Tech) public{
        if(_Tech==1){
            Technology = "blockchain";
        }else if(_Tech == 2){
            Technology = "AI";
        }
          else {
            Technology = "cybersecurity";

          }

    }
}
