// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract CalorieCoin is ERC20, ERC20Burnable, Ownable, ERC20Permit {
    constructor()
        ERC20("CalorieCoin", "CAL")
        Ownable(msg.sender)
        ERC20Permit("CalorieCoin")
    {
        _mint(msg.sender, 1000000000 * 10 ** decimals());
    }

    function decimals() public pure override returns (uint8) {
        return 0;
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}