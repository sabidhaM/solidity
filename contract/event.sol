// SPDX-License-Identifier: MIT
pragma solidity^0.8.0;

contract test {
    event log(address indexed sender, string message);
    event anotherlog();

    function sample() public {
        emit log(msg.sender, "hello world");
        emit log(msg.sender, "Hello HI");
        emit anotherlog();
    }
}
