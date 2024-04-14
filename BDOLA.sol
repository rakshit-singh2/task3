// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BDOLA is ERC20, ERC20Burnable, Ownable  {
    constructor()
        ERC20("BDOLA", "BDOLA")
        Ownable(msg.sender) 
    {
        _mint(msg.sender, 1000000 * 10 ** uint(decimals()));
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}