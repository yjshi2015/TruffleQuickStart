// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;

interface IEmployee {
    function getName() external view returns(string memory);
    function setName(string calldata _name) external;
}

contract Employee is IEmployee{
    string public name;

    function getName() external view override returns(string memory) {
        return name;
    }

    function setName(string calldata _name) external override {
        name = _name;
    }
}

contract Company {
    string myName;

    IEmployee employee;

    //用接口来转型
    constructor(address _address) {
        employee = IEmployee(_address);
    }

    function queryName() external view returns(string memory) {
        return employee.getName();
    }

    function setName(string calldata _name) external {
        employee.setName(_name);
    }

    //用合约来转型
    Employee employee2;
    function testConvert(address _address) public {
        employee2 = Employee(_address);
    }
    function queryName2() external view returns(string memory) {
        return employee2.getName();
    }
    function setName2(string calldata _name) external {
        employee2.setName(_name);
    }
}