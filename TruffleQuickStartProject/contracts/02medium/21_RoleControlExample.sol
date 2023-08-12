// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

/**这个角色及角色管理员的设计特别让人费解，是存在2个_roles变量中，然后通过其中1个_roles变量的RoleData.adminRole进行逻辑关联
 * 如果在RoleData这个结构体中直接增加一个属性 address roleAdminAddress是否更清晰？
 */
contract SyjToken is ERC20, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant MINTER_ADMIN_ROLE = keccak256("MINTER_ADMIN_ROLE");

    constructor() ERC20("SyjToken", "SYJ") {
        _mint(msg.sender, 100000000 * 10 ** decimals());
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
    }

    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }

    //新增角色或者为某个角色新增用户
    function addOrGrantRole(bytes32 _role, address _account) public onlyRole(getRoleAdmin(_role)) {
        grantRole(_role, _account);
    }

    //查看某个角色组的管理员
    function queryRoleAdmin(bytes32 _role) public view returns (bytes32) {
        return getRoleAdmin(_role);
    }

    //设置某个角色组的管理员
    function setRoleAdmin(bytes32 _role, bytes32 _adminRole) public {
        _setRoleAdmin(_role, _adminRole);
    }
}