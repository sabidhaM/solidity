// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract userDetails {
    struct user{
        string name;
        uint age;
        string email;
    }

    mapping(uint => user) public users;
    
    function addUser(uint userId, string memory name, uint age, string memory email) public{
        users[userId] = user(name, age, email);
    }
    function getUser(uint userId) public view returns(string memory, uint, string memory){
        user memory User = users[userId];
        return (User.name, User.age, User.email);
        
    }
}
