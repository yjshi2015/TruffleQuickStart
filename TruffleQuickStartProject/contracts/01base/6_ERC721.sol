// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

//ERC721是NFT标准协议
interface IERC721 {
    //某个账户的余额
    function balanceOf(address owner) external view returns(uint256);

    //某个NFT的所有者
    function ownerOf(uint tokenId) external view returns(address);

    //将某个NFT授权给某个代理商（拍卖所）
    function approve(address to, uint256 tokenId) external payable;
    //查询某个NFT的被授权人
    function getApproved(uint tokenId) external view returns(address);

    //将某人的所有NFT授权给某个代理商
    function setApprovalForAll(address operator, bool approved) external;
    //查询某个代理有没有某人所有NFT的代理权限
    function isApprovedForAll(address owner, address operator) external view returns(bool);
}

contract ERC721 is IERC721 {
    
    mapping(address => uint) public balanceOf;
    //该NFT属于谁
    mapping(uint => address) public ownerOf;
    //该NFT授权给了谁
    mapping(uint => address) public tokenApprovals;
    //owner有没有授权给operator
    mapping(address => mapping(address => bool)) private operatorApprovals;

    function approve(address _to, uint256 _tokenId) external payable {
        address owner = ownerOf[_tokenId];
        // 谁的NFT谁来授权
        require(msg.sender == owner, "must owner approve");
        tokenApprovals[_tokenId] = _to;
    }

    function getApproved(uint _tokenId) external view returns(address) {
        //验证_tokenId是否有效
        require(ownerOf[_tokenId] != address(0), "invalid token id");
        return tokenApprovals[_tokenId];
    }

    function setApprovalForAll(address _operator, bool _approved) external {
        require(msg.sender != _operator, "approve to caller");
        operatorApprovals[msg.sender][_operator] = _approved;
    }

    function isApprovedForAll(address _owner, address _operator) external view 
        returns(bool)
    {
        return operatorApprovals[_owner][_operator];
    }

    //铸造一个NFT，并将该NFT分配给to（一个普通的账户地址，可以是remix的账户地址）
    function mint(address _to, uint _tokenId) external {
        require(_to != address(0), "mint to zero address");
        require(ownerOf[_tokenId] == address(0), "token already minted");

        balanceOf[_to] += 1;
        ownerOf[_tokenId] = _to;
    }

    function getIERC721InterfaceId() public pure returns(bytes4) {
        return type(IERC721).interfaceId;
    }    
    
    //interfaceId的来源
    function geneIERC721InterfaceId() public pure returns(bytes4) {
        bytes4 one = bytes4(keccak256('balanceOf(address)'));
        bytes4 two = bytes4(keccak256('ownerOf(uint256)'));
        bytes4 three = bytes4(keccak256('approve(address,uint256)'));
        bytes4 four = bytes4(keccak256('getApproved(uint256)'));
        bytes4 five = bytes4(keccak256('setApprovalForAll(address,bool)'));
        bytes4 six = bytes4(keccak256('isApprovedForAll(address,address)'));
        return one ^ two ^ three ^ four ^ five ^ six;
    }
}