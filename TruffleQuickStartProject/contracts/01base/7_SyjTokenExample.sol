// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

/*
发放代币token，在Remix中连上metamask钱包，然后deploy即可
*/

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SyjToken is ERC20 {

    constructor() ERC20("SyjToken", "SYJ") {
        _mint(msg.sender, 100000000 * 10 ** decimals());
    }
}