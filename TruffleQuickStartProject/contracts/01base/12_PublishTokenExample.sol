// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SyjToken is ERC20 {
    constructor() ERC20("SYJ-TOKEN", "SYJ") {
        _mint(msg.sender, 1000 * 10 ** decimals());
    }
}