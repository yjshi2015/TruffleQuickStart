// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

//字符串本质是数组，长度是不固定的
contract StringExample {
    string public str1 = "hello";
    string public str2 = "world";

    //字符串拼接
    string public str3 = string(abi.encodePacked(str1, str2));
    string public str4 = string.concat(str1, str2);

    //字符串比较：因为是不定长数组，所以不能直接用==来比较
    function compare(string calldata _str1, string calldata _str2) public pure returns(bool) {
        return (keccak256(abi.encodePacked(_str1)) == keccak256(abi.encodePacked(_str2)));
    }

    //紧密型打包，占用长度短，效率高
    function encodePacked(string calldata _str1) public pure returns(bytes memory) {
        return abi.encodePacked(_str1);
    }

    //会把内容进行填充，分别是偏移量、字符串长度、字符串本身
    function encode(string calldata _str2) public pure returns(bytes memory) {
        return abi.encode(_str2);
    }
}