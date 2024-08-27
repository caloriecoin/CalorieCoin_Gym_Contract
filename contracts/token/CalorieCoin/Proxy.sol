// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/access/Ownable.sol";

import "./CalorieCoin.sol";

contract Proxy is Ownable {
    CalorieCoin internal _currentCalorieCoinToken;
    
    uint256 internal _calorieCoinTokenVersion;
    mapping(uint256=>CalorieCoin) _calorieCoinTokenList;

    constructor()
        Ownable(msg.sender)
    {}

    function updateCalorieCoin(CalorieCoin calorieCoin) external onlyOwner {
        _calorieCoinTokenList[_calorieCoinTokenVersion] = calorieCoin;
        _calorieCoinTokenVersion++;
    } 

    function getCalorieCoin(uint256 version) external view returns(CalorieCoin) {
        return _calorieCoinTokenList[version-1];
    }

    function getLatestCalorieCoin() external view returns(CalorieCoin) {
        return _calorieCoinTokenList[_calorieCoinTokenVersion-1];
    }

    function getLatestCalorieCoinVersion() external view returns(uint256) {
        return _calorieCoinTokenVersion;
    }
}