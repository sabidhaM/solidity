pragma solidity ^0.5.0;

contract AadharDetail{
    address aadharNumber;
    struct Aadhar{
    string name;
    uint64 dob;
    string addressDetail;
    }

 mapping(address=> Aadhar) public aadhardetail;
 constructor() public{

 }

 function addaadharRecord(address aadharNumber, string memory _name, uint64  _dob, string memory _addressDetail)
 public{
    aadhardetail[aadharNumber].name =_name;
    aadhardetail[aadharNumber].dob =_dob;
    aadhardetail[aadharNumber].addressDetail =_addressDetail;
    }

function getaadharRecord(address aadharNumber) public view returns (string memory, uint64, string memory){

return( aadhardetail[aadharNumber].name, aadhardetail[aadharNumber].dob, aadhardetail[aadharNumber].addressDetail);
}
}
