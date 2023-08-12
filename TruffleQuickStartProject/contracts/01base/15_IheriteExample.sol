// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;


contract B {
    event LogB(string);
    function getName() public virtual returns(string memory) {
        emit LogB("b");
        return "B";
    }
}

contract C {
    event LogC(string);
    function getName() public virtual returns(string memory) {
        emit  LogC("c");
        return "C";
    }
}

/** getName函数调用哪个super取决于继承的顺序：即最后一个类
 */
contract BC is B, C {
    function getName() public override(B, C) returns(string memory) {
        return super.getName();
    }
}

contract CB is C, B {
    function getName() public override(B, C) returns(string memory) {
        return super.getName();
    }
}