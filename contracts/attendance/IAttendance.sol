// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

interface IAttendance {
    event Attendance(address indexed checker, address indexed user, uint256 blockNumber);

    // onlyOwner
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