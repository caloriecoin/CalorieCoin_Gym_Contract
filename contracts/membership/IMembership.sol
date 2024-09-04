// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

interface IMembership {
    event NewMembership(address indexed newMember, uint membershipExpiredTime);
    event UpdateMembership(address indexed updateMember, uint membershipExpiredTime);

    function newMembership(
        address newMember,
        uint membershipExpiredTime
    ) external;
    
    function updateMembershipExpiredTime(
        address updateMember,
        uint membershipExpiredTime
    ) external;

    function newMembershipWithPayment(
        address newMember,
        uint membershipExpiredTime,
        uint256 tokenAmount,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;
    
    function updateMembershipExpiredTimeWithPayment(
        address updateMember,
        uint membershipExpiredTime,
        uint256 tokenAmount,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    function removeMembership(
        address member
    ) external;

    function getExpiredTime(
        address member
    ) external view returns(uint);

    function isMember(
        address member
    ) external view returns(bool);
    
    function isExpired(
        address member
    ) external view returns(bool);

    error ErrInvalidOwner(address owner);
    error ErrAlreadySubmitMember(address member);
    error ErrNotSubmitMember(address member);
}