// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

interface IMembership {
    event NewMembership(address newMember);
    event UpdateMembership(address indexed updateMember, uint256 blockNumber);

    function newMembership(
        address newMember,
        uint256 membershipEndBlockNumber,
        uint256 tokenAmount,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;
    
    function updateMembership(
        address updateMember,
        uint256 membershipEndBlockNumber,
        uint256 tokenAmount,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    function pauseMembership(
        address member
    ) external;

    function getMembershipBlockNumber(
        address member
    ) external view returns(uint256);

    function isMember(
        address member
    ) external view returns(bool);
    

    error ErrInvalidOwner(address owner);
    error ErrAlreadySubmitMember(address member);
    error ErrNotSubmitMember(address member);
}