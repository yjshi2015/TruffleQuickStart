// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

/**
 * 3种方法发送ETH
 * send:    2300 gas, return bool，如果转账失败，只会返回false，不会回滚，不建议使用
 * transfer:2300 gas, revert，如果转账失败，回滚交易，次优选择。
 * call:    可以调用all gas, return(bool, data)，没有gas限制，最灵活，最提倡
 *
 * Example的目的
 *
 * 1、验证转账时扣除的是哪个账户的余额？
 * 扣除的是转账函数所在合约的余额，但是gas费扣除的是发起者的，即Remix账户
 *
 * 2、验证gas费不够2300时，是否回滚（扣款账户余额不足以支付gas）
 */

 contract SendEth {
    event Log(address _from);
    constructor() payable{}

    function sendCoin(address payable _to, uint amount) public returns (bool) {
        emit Log(msg.sender);
        //扣除的是本合约地址的余额，而非Remix账户的余额
        return _to.send(amount);
    }

    function getGasLeft() public view returns (uint) {
        return gasleft();
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
 }

 contract ReceiveEth {
    uint public count;
    
    event Log(address _from, uint _amount, uint gas);
    event Log2(address _from, uint _begin, uint _end);

    // todo syj gasleft ???
    receive() external payable {
        count++;
        emit Log(msg.sender, msg.value, gasleft());
    }

    function getGasLeft() public view returns (uint) {
        return address(msg.sender).balance;
    }
 }