// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract A {
    function callBFunc(address _address, uint _num, string memory _message) public returns(string memory) {
        // (bool ok, bytes memory data) = _address.call(abi.encodeWithSignature("bFunc(uint256,string)", _num,_message));
        // require(ok, "call bfunc failed");

        //Note:天啊，这种方式是有问题的，bFunc的第二个参数类型是string，在这里被转成了bytes，发生实际调用时传参失败，关键是还不报错，
        //所以很难发现。必须要严格核对结果才能知道
        bytes4 sig = bytes4(keccak256("bFunc(uint256,string)"));
        bytes memory _bNum = abi.encode(_num);
        bytes memory _bMsg = abi.encode(_message);
        (bool ok2, bytes memory data2) = _address.call(abi.encodePacked(sig, _bNum, _bMsg));
        require(ok2, "call bfunc failed");

        // bytes4 sig = bytes4(keccak256("bFunc(uint256,string)"));
        // (bool ok3, bytes memory data3) = _address.call(abi.encodeWithSelector(sig, _num, _message));
        // require(ok3, "call bfunc failed");
        return string(data2);
    }

    function testNum(uint _num, string calldata _message) public pure returns (bytes memory) {
        bytes4 sig = bytes4(keccak256("bFunc(uint256,string)"));
        bytes memory _bNum = abi.encode(_num);
        bytes memory _bMsg = abi.encode(_message);
        return abi.encode(sig, _bNum, _bMsg);
    }
}

contract B {
    event Log(uint,string);
    uint public num;
    string public str;
    function bFunc(uint _num, string calldata _str) public returns(string memory) {
        emit Log(_num, _str);
        num = _num;
        str = _str;
        return string.concat(str, "b");
    }
}