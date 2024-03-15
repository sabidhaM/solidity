// SPDX-License-Identifier: GPL -3.0

pragma solidity ^0.8.0;

contract SampleTiming{
    //uint public  deploymentTime;
    uint256 public startTime;

    function setStartTime() public{
        startTime = block.timestamp;
    }

    function endSec() public view returns(uint256){
        return(block.timestamp - startTime);
    }

    function endMin() public view returns(uint256){
        return(block.timestamp - startTime)/1 minutes;
    }
}
