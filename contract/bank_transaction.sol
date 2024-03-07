// SPDX-License-Identifier: GPL -3.0
 
pragma solidity >=0.5.0 <0.9.0;

contract Bank{
    address payable public owner;

    constructor() payable{
        owner = payable(msg.sender);

    }

    function withdraw(uint256 amount) external{
        require(msg.sender == owner,"caller is not owner");
        payable(owner).transfer(amount);
    }

    function getBal() external view returns(uint256){
        return address(this).balance;
    }
}
