// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

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
        uint256 paymentAmount
    ) external 
      override 
      onlyOwner 
    {
        if(_membership[newMember]) {
            revert ErrAlreadySubmitMember(newMember);
        }

        CalorieCoin calorieCoin = _tokenProxyContract.getLatestCalorieCoin();

        calorieCoin.transferFrom(newMember, owner(), paymentAmount);

        _membershipExpiredTime[newMember] = membershipExpiredTime;
        _membership[newMember] = true;

        emit NewMembership(newMember, membershipExpiredTime);
    }
    
    function updateMembershipExpiredTimeWithPayment(
        address updateMember,
        uint membershipExpiredTime,
        uint256 paymentAmount
    ) external 
      override 
      onlyOwner 
    {
        if(!_membership[updateMember]) {
            revert ErrNotSubmitMember(updateMember);
        }

        CalorieCoin calorieCoin = _tokenProxyContract.getLatestCalorieCoin();

        calorieCoin.transferFrom(updateMember, owner(), paymentAmount);

        _membershipExpiredTime[updateMember] = membershipExpiredTime;

        emit UpdateMembership(updateMember, membershipExpiredTime);
    }

    function refundMembership(
        address refundMember,
        uint256 amount
    ) external override onlyOwner {
        if(!_membership[refundMember]) {
            revert ErrNotSubmitMember(refundMember);
        }

        CalorieCoin calorieCoin = _tokenProxyContract.getLatestCalorieCoin();

        calorieCoin.transferFrom(msg.sender, refundMember, amount);

        _membership[refundMember] = false;

        emit RefundMembership(refundMember);
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