// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/access/Ownable.sol";

import "../token/CalorieCoin/Proxy.sol";
import "../token/CalorieCoin/CalorieCoin.sol";

import "./IMembership.sol";

contract Membership is Ownable, IMembership {
    Proxy internal _tokenProxyContract;

    mapping(address=>uint) _membershipExpiredTime;
    mapping(address=>bool) _membership;

    constructor(
        Proxy tokenProxyContract
    ) Ownable(msg.sender)
    {
        _tokenProxyContract = tokenProxyContract;
    }

    function newMembership(
        address newMember,
        uint membershipExpiredTime
    ) external override onlyOwner {
        if(_membership[newMember]) {
            revert ErrAlreadySubmitMember(newMember);
        }

        _membershipExpiredTime[newMember] = membershipExpiredTime;

        _membership[newMember] = true;

        emit NewMembership(newMember, membershipExpiredTime);
    }
    
    function updateMembershipExpiredTime(
        address updateMember,
        uint membershipExpiredTime
    ) external override onlyOwner {
        if(!_membership[updateMember]) {
            revert ErrNotSubmitMember(updateMember);
        }

        _membershipExpiredTime[updateMember] = membershipExpiredTime;

        emit UpdateMembership(updateMember, membershipExpiredTime);
    }

    function newMembershipWithPayment(
        address newMember,
        uint membershipExpiredTime,
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

        calorieCoin.permit(newMember, address(this), tokenAmount, deadline, v, r, s);
        calorieCoin.transferFrom(newMember, owner(), tokenAmount);

        _membershipExpiredTime[newMember] = membershipExpiredTime;

        _membership[newMember] = true;

        emit NewMembership(newMember, membershipExpiredTime);
    }

    function updateMembershipExpiredTimeWithPayment(
        address updateMember,
        uint membershipExpiredTime,
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

        calorieCoin.permit(updateMember, address(this), tokenAmount, deadline, v, r, s);
        calorieCoin.transferFrom(updateMember, owner(), tokenAmount);

        _membershipExpiredTime[updateMember] = membershipExpiredTime;

        emit UpdateMembership(updateMember, membershipExpiredTime);
    }

    function removeMembership(
        address member
    ) external override onlyOwner {
        if(!_membership[member]) {
            revert ErrNotSubmitMember(member);
        }

        _membership[member] = false;
    }

   function getExpiredTime(
        address member
    ) external view override returns(uint) {
        return _membershipExpiredTime[member];
    }

    function isMember(
        address member
    ) external view override returns(bool) {
        return _membership[member];
    }

    function isExpired(
        address member
    ) external view override returns(bool) {
        if(_membership[member])
        {
            return block.timestamp <= _membershipExpiredTime[member];
        }

        return false;
    }
}