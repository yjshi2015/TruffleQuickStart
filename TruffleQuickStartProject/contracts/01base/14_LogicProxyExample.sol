// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;
import "./14_ProxyExample.sol";

contract Logic is ILogic {
    uint private number;

    function setNumber() external {
        number = number + 1;
    }

    function getNumber() external view returns(uint) {
        return number;
    }
}