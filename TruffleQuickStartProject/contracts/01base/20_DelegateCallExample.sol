// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract A {
    string constant name = "SYJ";
    uint private num1;
    uint public num666 = 666;

    function getNum() public view returns(uint) {
        return num1;
    }

    function setNum(uint _num) public returns (uint){
        num1 = _num + 1;
        return num1;
    }

    //改的是B合约的num值
    function setVal(address _address, uint _num) public returns(uint){
        B b = B(_address);
        return b.setNum(_num);
    }

    //改的是B合约的值，同上
    function setValByCall(address _address, uint _num) public returns(bytes memory){
        (bool ok, bytes memory data) = _address.call(abi.encodeWithSignature("setNum(uint256)", _num));
        require(ok, "call failed");
        return data;
    }

    //todo syj 委托调用是如何映射到原合约的变量的？
    //委托调用，修改的是A合约的num值
    function setValByDelegateCall(address _address, uint _num) public returns(bytes memory){
        (bool ok, bytes memory data) = _address.delegatecall(abi.encodeWithSignature("setNum(uint256)", _num));
        require(ok, "call failed");
        return data;
    }
}

contract B {
    uint private num;

    function setNum(uint _num) public returns(uint){
        return num = _num + 2;
    }

    function getNum() public view returns(uint) {
        return num;
    }
}