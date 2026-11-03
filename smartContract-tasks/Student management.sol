// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StudentManagement {
    struct Student {
        uint id;
        string name;
        uint age;
        string course;
        bool isActive;
    }

    mapping(uint256 => Student) public studentDetails;
    mapping(uint256 => bool) public exists;
    uint256 public studentCount;
    address public owner;
    uint256 public registrationFee = 0.01 ether;

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {}

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner");
        _;
    }

    event StudentAdded(
        uint id,
        string name,
        uint age,
        string course,
        bool isActivate
    );
    event StudentUpdated(uint id, string name, uint age);
    event StudentDeleted(uint id);

    function addStudent(
        string memory _name,
        uint _age,
        uint _id,
        string memory _course
    ) public payable {
        Student storage student = studentDetails[_id];
        require(_age >= 18, "only above 18");
        require(!exists[_id], "Student ID already exist");
        require(msg.value == registrationFee, "Invalid fee");
        require(bytes(_name).length > 0, "Name required");
        require(bytes(_course).length > 0, "Course required");

        studentCount += 1;

        student.name = _name;
        student.id = _id;
        student.age = _age;
        student.isActive = true;
        student.course = _course;

        exists[_id] = true;
        emit StudentAdded(_id, _name, _age, _course, true);
    }

    function updateStudent(string memory _name, uint _age, uint _id) public {
        Student storage student = studentDetails[_id];
        require(student.isActive == true, "cannot update");
        require(_age >= 18, "only update above 18");
        require(student.isActive, "Student not found");
        student.name = _name;
        student.age = _age;

        emit StudentUpdated(_id, _name, _age);
    }

    function deleteStudent(uint _id) public onlyOwner {
        Student storage student = studentDetails[_id];
        require(student.isActive == true, "Already deleted");

        student.name = "";
        student.id = 0;
        student.age = 0;
        student.isActive = false;
        student.course = "";

        emit StudentDeleted(_id);
    }

    function getStudent(
        uint id
    ) public view returns (uint, string memory, uint, string memory, bool) {
        Student storage student = studentDetails[id];
        return (
            student.id,
            student.name,
            student.age,
            student.course,
            student.isActive
        );
    }

    function getStudentCount() public view returns (uint) {
        return studentCount;
    }

    function withdraw(uint256 amount, address to) public onlyOwner {
        require(amount <= address(this).balance, "Insufficient Balance");
        payable(to).transfer(amount);
    }
}
