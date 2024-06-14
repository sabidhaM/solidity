// Define a custom data type with a finite set of possible values.
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EnumContrct{
    enum FreshJuiceSize{ small, medium, large}
    FreshJuiceSize choice;
    FreshJuiceSize constant defaultChoice = FreshJuiceSize.medium;

    function setlarge() public {
        choice = FreshJuiceSize.large;
    }
    
    function getchoice() public view returns (FreshJuiceSize) {
        return choice; 
    }

    function getDefaultchoice() public pure returns (uint) {
        return uint(defaultChoice);
    }
}
