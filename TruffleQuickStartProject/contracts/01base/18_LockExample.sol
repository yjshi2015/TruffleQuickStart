// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract LockExample is ERC20, Ownable {
    bool public isLocked = false;
    uint public timeLock = block.timestamp + 1 days;

    constructor() ERC20("SYJ-TOKEN", "SYJ") {
        _mint(msg.sender, 100000 * 10 ** decimals());
    }

    function transfer(address _to,uint _amount) public override returns(bool) {
        require(isLocked == false, "Tranasction was locked");
        //要等待1 day后再执行
        require(block.timestamp > timeLock, "It is not time yet!");
        return super.transfer(_to, _amount);
    }

    function setLock(bool _lock) public {
        isLocked = _lock;
    }
}