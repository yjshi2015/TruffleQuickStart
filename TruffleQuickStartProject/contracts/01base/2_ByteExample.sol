// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract BytesExample {
    //bytes是字节数组，类似于bytes1[]，前者为动态数组，后者为固定长度数组
    //16进制为0~9,a~f范围

    bytes1 public data1 = 0xff;
    bytes1 public data2 = 0xff;
    
    bool public isEqual = data1 == data2;

    bytes2 public data4 = 0xffff;
    uint public data5 = data4.length;

    bytes32 public data6 = 0x0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef;
    uint public data7 = data6.length;
    bytes1 public data8 = data6[0];
    bytes1 public data9 = data6[1];

    //bytes动态数组
    bytes public data10 = "hello";
    bytes public data11 = abi.encodePacked(data10);
    bytes public data12 = abi.encode(data10);

    bytes1[] public data13;

    function pushFunc() public {
        // todo syj 这里语法错误，why？？？
        data10.push("0xab");
        data10.push("0xff");
        data13.push("0xff");
    }
}
