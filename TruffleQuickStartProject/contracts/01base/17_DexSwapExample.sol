// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// safemath在solidity 0.8版本之后就不再需要了
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
contract SYJToken is ERC20 {
    constructor() ERC20("SYJToken", "SYJ") {
        _mint(msg.sender, 10000 * 10 ** decimals());
    }
}

contract SDZToken is ERC20 {
    constructor() ERC20("SDZToken", "SDZ") {
        _mint(msg.sender, 20000 * 10 ** decimals());
    }
}

contract DexSwap {
    using SafeMath for uint;
    address public syjToken;
    address public sdzToken;

    constructor(address _syjToken, address _sdzToken) {
        syjToken = _syjToken;
        sdzToken = _sdzToken;
    }

    function swap(address _from, address _to, uint _amount) public {
        require((_from == syjToken && _to == sdzToken) || (_from == sdzToken && _to == syjToken), "Invalid tokens");
        require(ERC20(_from).balanceOf(msg.sender) >= _amount, "Not enough to swap");
        //数量为amount的from代币，能够换回多少to代币
        uint swap_amount = get_swap_price(_from, _to, _amount);

        //先把from币转给 交易所
        ERC20(_from).transferFrom(msg.sender, address(this), _amount);
        //给交易所授予to币的swap_amount额度
        ERC20(_to).approve(address(this), swap_amount);
        //从交易所转给当前账户swap_amount数量的to币
        ERC20(_to).transferFrom(address(this), msg.sender, swap_amount);
    }

    //增加流动性，即给交易所注入资金（token）
    function add_liquidity(address _tokenAddress, uint _amount) public {
        ERC20(_tokenAddress).transferFrom(msg.sender, address(this), _amount);
    }

    //amount数量的from币，可置换多少数量的to币
    function get_swap_price(address _from, address _to, uint _amount) public view returns(uint) {
        //amount*倍数（to币的数量/from币数量） 即为对应的to币数量
        //币的数量为当前交易所所拥有的数量
        return _amount * (ERC20(_to).balanceOf(address(this)))/(ERC20(_from).balanceOf(address(this)));
    }

    //给交易所某个币种的授权额度
    function approve(address _token, uint _amount) public {
        ERC20(_token).approve(address(this), _amount);
    }
}