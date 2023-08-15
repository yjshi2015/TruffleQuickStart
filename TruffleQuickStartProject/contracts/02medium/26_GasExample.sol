// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "hardhat/console.sol";

contract TestGas {
    uint public num;

    function setNum(uint _num) public {
        num = _num;
    }

    function getNum() public view returns(uint) {
        return num;
    }

    function sum(uint times) public returns (uint) {
        console.log("begin : %s" , gasleft());
        for (uint i; i < times; i++) {
            num += i;
        }
        console.log("end : %s" , gasleft());

        return num;
    }
}