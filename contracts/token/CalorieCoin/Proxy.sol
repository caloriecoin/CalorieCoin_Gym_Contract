// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "./CalorieCoin.sol";

contract Proxy {
    address internal _owner;
    CalorieCoin internal _currentCalorieCoinToken;
    
    uint256 internal _calorieCoinTokenVersion;
    mapping(uint256=>CalorieCoin) _calorieCoinTokenList;

    constructor() {
        _owner = msg.sender;
    }

    function updateCalorieCoin(CalorieCoin calorieCoin) external {
        if(_owner != msg.sender) {
            revert ErrInvalidOwner(msg.sender);
        }

        _calorieCoinTokenList[_calorieCoinTokenVersion] = calorieCoin;
        _calorieCoinTokenVersion++;
    } 

    function getCalorieCoin(uint256 index) external view returns(CalorieCoin) {
        return _calorieCoinTokenList[index];
    }

    function getLatestCalorieCoin() external view returns(CalorieCoin) {
        return _calorieCoinTokenList[_calorieCoinTokenVersion];
    }

    function getLatestCalorieCoinVersion() external view returns(uint256) {
        return _calorieCoinTokenVersion;
    }

    error ErrInvalidOwner(address owner);
}