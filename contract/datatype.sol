//SPDX-License-Identifier: GPL -3.0
pragma solidity ^0.8.0;
contract datatype{
    bool public value;

    //uint stands for unsigned integer, meaning non negative integers different sizes are available
    uint8 public u8 = 1;       //uint8   ranges from 0 to 2 ** 8 - 1 //uint16  ranges from 0 to 2 ** 16 - 1
    uint public u256 = 456;    //uint256 ranges from 0 to 2 ** 256 - 1
    uint public u = 123;       //// uint is an alias for uint256

    //Negative numbers are allowed for int types.
    int8 public i8 = -1;
    int public i256 = 456;
    int public i = 123;

    int public max = type(int).max;
    int public min = type(int).min;

    address public add= 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;

    //In Solidity, the data type byte represent a sequence of bytes. 
    //Solidity presents two type of bytes types :

    // - fixed-sized byte arrays
    //- dynamically-sized byte arrays.
     
    //The term bytes in Solidity represents a dynamic array of bytes. It’s a shorthand for byte[] .
