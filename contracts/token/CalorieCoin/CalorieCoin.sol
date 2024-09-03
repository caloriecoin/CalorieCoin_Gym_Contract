// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";

contract CalorieCoin is ERC20, ERC20Burnable, Ownable, ERC20Permit, ERC20Votes {
    constructor()
        ERC20("CalorieCoin", "CAL")
        Ownable(msg.sender)
        ERC20Permit("CalorieCoin")
    {
        _mint(msg.sender, 1000000000 * 10 ** decimals());
    }

    function _update(address from, address to, uint256 value)
        internal
        override(ERC20, ERC20Votes)
    {
        super._update(from, to, value);
    }

    function nonces(address owner)
        public
        view
        override(ERC20Permit, Nonces)
        returns (uint256)
    {
        return super.nonces(owner);
    }

    function decimals() 
        public 
        pure 
        override returns (uint8) {
        return 0;
    }

    function mint(address to, uint256 amount) 
        public onlyOwner 
    {
        _mint(to, amount);
    }
}
