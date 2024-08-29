// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

interface IReservation {
    event Reservation(address indexed customer, uint256 indexed classId, uint256 blockNumber);

    function setRewardOffset(
        uint256 amount
    )external;

    function submitChecker() external;

    function attendance(
        address checker
    )external;

    error ErrInvalidOwner(address owner);
    error ErrInvalidChecker(address checker);
    error ErrNotMembershipSubmit(address target);
}