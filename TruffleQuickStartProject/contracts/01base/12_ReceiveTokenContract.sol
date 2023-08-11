// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ReceiveTokenContract {
    IERC20 myToken;

    constructor(address _tokenAddress) {
        myToken = IERC20(_tokenAddress);
    }

    function transferFrom(uint _amount) public {
        myToken.transferFrom(msg.sender, address(this), _amount);
    }

    function getBalance(address _address) public view returns(uint) {
        return myToken.balanceOf(_address);
    }
}