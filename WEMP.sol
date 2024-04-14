// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract WRAPPEDEMPRESSTOKEN is ERC20, ERC20Burnable, Ownable {
    
    IERC20 public immutable empToken;

    constructor(address _empToken)
        ERC20("WRAPPED EMPRESS TOKEN", "wEMP")
        Ownable(msg.sender)
    {
        empToken = IERC20(_empToken);
    }

    event Wrapped(address indexed account, uint256 amount);
    event Unwrapped(address indexed account, uint256 amount);

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    function wrap(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        require(empToken.transferFrom(msg.sender, address(this), amount), "Transfer from EMP token failed");
        
        _mint(msg.sender, amount);
        emit Wrapped(msg.sender, amount);
    }

    function unwrap(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        require(balanceOf(msg.sender) >= amount, "Insufficient wrapped balance");
        require(empToken.transferFrom(address(this), msg.sender, amount), "Transfer to EMP token failed");
        
        _burn(msg.sender, amount);
        emit Unwrapped(msg.sender, amount);
    }
}
