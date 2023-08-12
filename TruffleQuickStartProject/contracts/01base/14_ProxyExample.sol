// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;

interface ILogic {
    function setNumber() external;
    function getNumber() external view returns(uint);
}

/** 
 * 使用该代理类，通过setLogicAddress函数可以自动切换加载的类
*/
contract Proxy {
    ILogic logic;

    function setLogicAddress(address _logicAddres) public {
        logic = ILogic(_logicAddres);
    }    
    
    function setNumber() external {
        logic.setNumber();
    }

    function getNumber() external view returns(uint) {
        return logic.getNumber();
    }
}