// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "https://github.com/yjshi2015/solidity/blob/main/contract-enum-demo.sol" as ImportDemo;


contract ImportContract {
    ImportDemo.EnumDemo enumDemo;

    constructor() {
        enumDemo = new ImportDemo.EnumDemo();
    }

    function testFunc() public view returns (uint8) {
        return uint8(enumDemo.getLargestValue());
    }
}