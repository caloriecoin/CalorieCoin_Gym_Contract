// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IAttendance {
    event Attendance(address indexed checker, address indexed user, uint256 reward, uint256 timestamp);

    // onlyOwner
    function setRewardOffset(
        uint256 amount
    )external;

    function getRewardOffset() external 
        view 
        returns(uint256);

    function submitChecker(address _checker) external;

    function attendance(
        address checker
    )external;

    error ErrInvalidOwner(address owner);
    error ErrInvalidChecker(address checker);
    error ErrNotMembershipSubmit(address target);
    error ErrAlreadyAttendance(address target);
}