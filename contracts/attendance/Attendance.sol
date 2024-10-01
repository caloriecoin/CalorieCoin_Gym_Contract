// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/access/Ownable.sol";

import "../util/DateTime.sol";

import "../token/CalorieCoin/Proxy.sol";
import "../token/CalorieCoin/CalorieCoin.sol";
import "../membership/IMembership.sol";

import "./IAttendance.sol";

contract Attendance is Ownable, IAttendance {
    using StringConverter for uint256;
    using DateTimeLib for uint256;
    using StringUtils for string;

    uint256 private _rewardOffset;

    mapping(address=>uint256) private _latestUserAttendanceList;
    mapping(address=>mapping(string=>bool)) private _checkAttendance;

    mapping(address=>uint256) private _attendanceList;
    mapping(address=>bool) private _checkerList;

    Proxy private _tokenProxyContract;
    IMembership private _membership;

    constructor(
        Proxy tokenProxyContract,
        IMembership membership
    ) 
        Ownable(msg.sender) 
    {
        _checkerList[msg.sender] = true;
        
        _tokenProxyContract = tokenProxyContract;
        _membership = membership;
    }

    function submitChecker(address _checker) virtual override external onlyOwner {
        _checkerList[_checker] = true;
    }

    function setRewardOffset(uint256 amount) virtual override external {
        _rewardOffset = amount;
    }

    function getRewardOffset() virtual override external view returns(uint256) {
        return _rewardOffset;
    }

    function currentTime() external view returns(string memory) {
        (uint256 year, uint256 month, uint256 day) = block.timestamp.timestampToDate();

        string memory key = year.uintToString();
        return key.strConcat(month.uintToString(), day.uintToString());
    }

    function attendance(address target) virtual override external {
        if (!_checkerList[msg.sender]) {
            revert ErrInvalidChecker(msg.sender);
        }

        // if(!_membership.isMember(target)) {
        //     revert ErrNotMembershipSubmit(target);
        // }

        (uint256 year, uint256 month, uint256 day) = block.timestamp.timestampToDate();

        string memory key = year.uintToString();
        string memory attendanceDay = key.strConcat(month.uintToString(), day.uintToString());

        if(_checkAttendance[target][attendanceDay]) {
            revert ErrAlreadyAttendance(target);
        }

        _checkAttendance[target][attendanceDay] = true;

        // send rewards
        CalorieCoin caloriecoin = _tokenProxyContract.getLatestCalorieCoin();
        caloriecoin.transferFrom(msg.sender, target, _rewardOffset);
    
        emit Attendance(msg.sender, target, _rewardOffset, block.timestamp);
    }
}