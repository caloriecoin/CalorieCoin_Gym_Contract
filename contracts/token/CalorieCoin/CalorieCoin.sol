// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract CalorieCoin is ERC20, ERC20Burnable, Ownable, ERC20Permit {
    uint256 private _totalVerifiedContracts;
    mapping(uint256=>address) private _verifiedContracts;
    mapping(address=>bool) private _verifiedContractsCheckList;


    constructor()
        ERC20("CalorieCoin", "CAL")
        Ownable(msg.sender)
        ERC20Permit("CalorieCoin")
    {
        _mint(msg.sender, 1000000000 * 10 ** decimals());
    }

    function transferFrom(address from, address to, uint256 value) public override returns (bool) {
        if(!_verifiedContractsCheckList[msg.sender]) {
            revert ErrNotVerified(msg.sender);
        }
     
        _transfer(from, to, value);
        return true;
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

    function addVerifiedContract(address contractAddress) 
        public 
        onlyOwner 
    {
        if(_verifiedContractsCheckList[contractAddress]) {
            revert ErrAlreadyAddedContract(contractAddress);
        }

        _verifiedContractsCheckList[contractAddress] = true;
        _totalVerifiedContracts++;
        _verifiedContracts[_totalVerifiedContracts] = contractAddress;
    }

    function getVerifiedContractCount(uint256 contractId) 
        public
        view
        returns (address)
    {
        return _verifiedContracts[contractId];
    }

    function getVerifiedContractCount() 
        public
        view
        returns (uint256)
    {
        return _totalVerifiedContracts;
    }

    error ErrAlreadyAddedContract(address);
    error ErrNotVerified(address);
}
