// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import "./IAttendance.sol";
import "../membership/IMembership.sol";

contract Attendance is Ownable, IAttendance {
    mapping(address=>uint256) internal _attendanceList;
    mapping(address=>bool) internal _checkerList;

    ERC20 internal _tokenContract;

    IMembership internal _membership;

    constructor(ERC20 tokenContract) 
        Ownable(msg.sender) 
    {
        _checkerList[msg.sender] = true;
        _tokenContract = tokenContract;
    }

    function submitChecker() virtual override external onlyOwner {
        _checkerList[msg.sender] = true;
    }

    function setRewardOffset(uint256 amount) virtual override external {

    }

    function attendance(address target) virtual override external {
        if (_checkerList[msg.sender] == false) {
            revert ErrInvalidChecker(msg.sender);
        }

        if(!_membership.isMember(target)) {
            revert ErrNotMembershipSubmit(target);
        }

        _attendanceList[target] = block.number;

        // send rewards or badge
    
        emit Attendance(msg.sender, target, block.number);
    }
}