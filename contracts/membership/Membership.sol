// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/access/Ownable.sol";

import "../token/CalorieCoin/Proxy.sol";
import "../token/CalorieCoin/CalorieCoin.sol";

import "./IMembership.sol";

contract Membership is Ownable, IMembership {
    Proxy internal _tokenProxyContract;

    mapping(address=>uint256) _membershipBlockNumber;
    mapping(address=>bool) _membership;

    constructor(Proxy tokenProxyContract)
        Ownable(msg.sender)
    {
        _tokenProxyContract = tokenProxyContract;
    }

    function newMembership(
        address newMember,
        uint256 membershipEndBlockNumber,
        uint256 tokenAmount,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external override onlyOwner {
        if(_membership[newMember]) {
            revert ErrAlreadySubmitMember(newMember);
        }

        CalorieCoin calorieCoin = _tokenProxyContract.getLatestCalorieCoin();

        calorieCoin.permit(newMember, owner(), tokenAmount, deadline, v, r, s);
        calorieCoin.transferFrom(newMember, owner(), tokenAmount);

        _membershipBlockNumber[newMember] = membershipEndBlockNumber;
    }
    
    function updateMembership(
        address updateMember,
        uint256 membershipEndBlockNumber,
        uint256 tokenAmount,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external override onlyOwner {
        if(!_membership[updateMember]) {
            revert ErrNotSubmitMember(updateMember);
        }

        CalorieCoin calorieCoin = _tokenProxyContract.getLatestCalorieCoin();

        calorieCoin.permit(updateMember, owner(), tokenAmount, deadline, v, r, s);
        calorieCoin.transferFrom(updateMember, owner(), tokenAmount);

        _membershipBlockNumber[updateMember] = membershipEndBlockNumber;
    }

   function getMembershipBlockNumber(
        address member
    ) external view override returns(uint256) {
        return _membershipBlockNumber[member];
    }

    function isMember(
        address member
    ) external view override returns(bool) {
        return _membership[member];
    }
}