// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;
/**
 * 关键在于使用Metamask的账户来进行操作，而不是Remix账户操作
 */
library safeMath {
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
}

interface IERC20 {
    // 获取合约地址
    function getAddress() external view returns (address);
    // 获取代币发行总量
    function totalSupply() external view returns (uint256);
    // 根据地址获取代币的余额
    function balanceOf(address account) external view returns (uint256);
    // 代理可转移的代币数量
    function allowance(address owner, address supender) external view returns (uint256);

    // 转账
    function transfer(address recipient, uint256 amount) external returns (bool);
    // 设置代理能转账的金额
    function approve(address owner, address spender, uint256 amount) external returns (bool);
    // 转账
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

// 代币实现
contract ERC20Basic is IERC20 {
    string public constant name = "ERC20-SYJ"; // 代币名称
    string public constant symbol = "SYJ"; // 代币简称
    uint8 public constant decimals = 18;//并没有用到

    mapping(address => uint256) balances; // 地址对应的余额数量
    mapping(address => mapping(address => uint256)) allowedBalence; // 代理商能处理的代币数量

    uint256 totalSupply_ = 10000000000000000000; // 发行数量,不要使用 10 ether，这样创建出来只是10个

    using safeMath for uint256;

    constructor () {
        balances[msg.sender] = totalSupply_; // 将代币分发给创建者
    } 

     // 获取合约地址
    function getAddress() external view returns (address){
        return address(this); // 当前合约的地址
    }
    // 获取代币发行总量
    function totalSupply() external view returns (uint256){
        return totalSupply_;
    }

    // 根据地址获取代币的余额
    function balanceOf(address tokenOwner) public override view returns (uint256){
        return balances[tokenOwner]; // 根据地址获取余额
    }

    // 转账
    // todo syj 这里是否也要扣减对应的授权额度？？？
    function transfer(address receiver, uint256 amount) public override returns (bool){
        require(amount <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender].sub(amount);
        balances[receiver] = balances[receiver].add(amount);
        emit Transfer(msg.sender, receiver, amount);
        return true;
    }

    // 设置代理能转账的金额
    function approve(address owner, address delegate, uint256 amount) external returns (bool){
        allowedBalence[owner][delegate] = amount;
        emit Approval(owner, delegate, amount);
        return true;
    }

    // 代理可转移的代币数量
    function allowance(address owner, address delegate) external view returns (uint256){
        return allowedBalence[owner][delegate];
    }

    // 转账
    function transferFrom(address owner, address buyer, uint256 amount) external returns (bool){
        require(amount <= balances[owner]);
        //对应的授权额度也要扣减
        require(amount <= allowedBalence[owner][buyer]);

        balances[owner] = balances[owner].sub(amount);
        allowedBalence[owner][buyer] = allowedBalence[owner][buyer].sub(amount);
        balances[buyer] = balances[buyer].add(amount);
        emit Transfer(owner, buyer, amount);
        return true;
    }
}

//交易所DEMO，交易所就是个资金池，buy的时候把token从交易所转移到buyer，sell的时候把token从个人转移到交易所资金池
contract DEX {
    event Bought(uint256 amount);
    event Sold(uint256 amount);
     
    IERC20 public token;

    constructor () {
        token = new ERC20Basic();
    }

    // 买入
    function buy() payable public {
        uint256 amountTobuy = msg.value; //传入以太坊
        uint256 dexBalance = token.balanceOf(address(this)); //此合约中自己创建代币的数量
        require(amountTobuy > 0 , "You need to send some Ethoer"); // amountTobuy 必须传入以太，使用以太购买此代币
        require(amountTobuy <= dexBalance, "Not enough tokens in the reserve"); // 交易所资金不够
        token.transfer(msg.sender, amountTobuy);
        emit Bought(amountTobuy);
    }

    //卖出
    function sell(uint256 amount) public {
        require(amount > 0, "You need to sell at least some tokens."); // 卖出数量要大于0
        uint256 allowance = token.allowance(msg.sender, address(this));
        require(allowance >= amount, "check the token allowance");
        token.transferFrom(msg.sender, address(this), amount);

        emit Sold(amount);
    }

    function getDexBalance() public view returns(uint256) {
        return token.balanceOf(address(this));
    }

    function getOwnerBalance() public view returns(uint256) {
        return token.balanceOf(msg.sender);
    }

    function getAddress() public view returns (address) {
        return address(this);
    }

    function getTokenAddress() public view returns (address) {
        return token.getAddress();
    }

    function getTotalSupply() public view returns (uint256) {
        return token.totalSupply();
    }

    function getSenderAddress() public view returns (address) {
        return address(msg.sender);
    }

    function getAllowance() public view returns (uint256) {
        uint256 allowance = token.allowance(msg.sender, address(this));
        return allowance;
    }

    // 授权当前合约转移代币数量
    function approve(uint256 amount) public returns(bool) {
        bool isApprove = token.approve(msg.sender, address(this), amount);
        return isApprove;
    }
}