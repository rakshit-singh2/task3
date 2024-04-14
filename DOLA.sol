// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DOLA is ERC20, ERC20Burnable {
    constructor(IERC20 _BDOLAAddress)
        ERC20("DOLA", "DOLA")
    {
        BDOLAAddress = _BDOLAAddress;
    }

    IERC20 public BDOLAAddress;

    function withdrawDOLA(uint256 collateral) external {
        require(IERC20(BDOLAAddress).transferFrom(msg.sender, address(this), collateral), "Transfer failed");
        _mint(msg.sender, collateral);
    }

    function withdrawCollateral(uint256 amount) external {
        require(balanceOf(msg.sender) >= amount, "Insufficient DOLA balance");
        _burn(msg.sender, amount);
        require(IERC20(BDOLAAddress).transfer(msg.sender, amount), "Transfer failed");
    }
}