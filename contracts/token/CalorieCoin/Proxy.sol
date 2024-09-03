// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

import "./CalorieCoin.sol";

contract Proxy is Ownable {
    CalorieCoin internal _currentCalorieCoinToken;
    
    uint256 internal _calorieCoinTokenVersion;
    mapping(uint256=>CalorieCoin) _calorieCoinTokenList;

    constructor()
        Ownable(msg.sender)
    {
        _calorieCoinTokenList[0] = CalorieCoin(address(0));
    }

    function updateCalorieCoin(
        CalorieCoin calorieCoin
    ) external onlyOwner {
        _calorieCoinTokenVersion++;
        _calorieCoinTokenList[_calorieCoinTokenVersion] = calorieCoin;
    } 

    function getCalorieCoin(
        uint256 version
    ) external view returns(CalorieCoin) {
        if(_calorieCoinTokenVersion <= 0) {
            revert ErrInvalidContractVersion(version);
        }
        return _calorieCoinTokenList[version];
    }

    function getLatestCalorieCoin() external view returns(CalorieCoin) {
        if(_calorieCoinTokenVersion <= 0) {
            revert ErrContractNotDeployed(_calorieCoinTokenVersion);
        }
        return _calorieCoinTokenList[_calorieCoinTokenVersion];
    }

    function getLatestCalorieCoinVersion() external view returns(uint256) {
        if(_calorieCoinTokenVersion <= 0) {
            revert ErrContractNotDeployed(_calorieCoinTokenVersion);
        }
        return _calorieCoinTokenVersion;
    }

    error ErrContractNotDeployed(uint256 version);
    error ErrInvalidContractVersion(uint256 version);
}