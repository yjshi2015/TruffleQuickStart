// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract EnumExample {
    enum Status {
        OPEN,      //0
        PENDING,   //1
        PROCESS,   //2
        FINISHED   //3
    }

    //设置初始值
    Status public status = Status.PENDING;

    //修改枚举值
    function setStatus(Status _status) public {
        status = _status;
    }

    function setStatus2(uint8 _status) public {
        status = Status(_status);
    }

    //获取枚举值
    function getStatus() public view returns(Status) {
        return status;
    }

    function getStatus2() public view returns(uint8) {
        return uint8(status);
    }

    //删除后的默认值是0
    function deleteFunc() public {
        delete status;
    }

    //根据value获取text
    function getText(uint8 _status) public pure returns(string memory) {
        if (_status == uint8(Status.OPEN)) {
            return "OPEN";
        } else if (_status == uint8(Status.PENDING)) {
            return "PENDING";
        } else if (_status == uint8(Status.PROCESS)) {
            return "PROCESS";
        } else if (_status == uint8(Status.FINISHED)) {
            return "FINISHED";
        } else {
            revert();
        }
    }

    //根据text获取value
    function getVal(string calldata _txt) public pure returns(Status) {
        bytes32 bytesTxt = keccak256(bytes(_txt));
        if (keccak256(bytes("OPEN")) == bytesTxt) {
            return Status.OPEN;
        } else if (keccak256(bytes("PENDING")) == bytesTxt) {
            return Status.PENDING;
        } else if (keccak256(bytes("PROCESS")) == bytesTxt) {
            return Status.PROCESS;
        } else if (keccak256(bytes("FINISHED")) == bytesTxt) {
            return Status.FINISHED;
        } else {
            revert();
        }
    }

}