// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract TestContract {}

interface IERCA165 {
    function supportsInterface(bytes4 interfaceId) external view returns(bool);   
}

contract TypeExample {

    //Type仅支持Integer、Interface、Contract

    uint public max = type(uint256).max;
    uint public min = type(uint256).min;
    uint public max8 = type(uint8).max;
    uint public min8 = type(uint8).min;

    //获取合约名字
    string public contractName = type(TestContract).name;
    //获取合约部署的bytecode
    bytes public code = type(TestContract).creationCode;
    //获取合约运行时构造函数里有内联汇编的bytecode
    bytes public rCode = type(TestContract).runtimeCode;

    //获取接口id
    bytes4 public interfaceId = type(IERCA165).interfaceId;
}