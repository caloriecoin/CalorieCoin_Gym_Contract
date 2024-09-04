// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/access/Ownable.sol";

import "../token/CalorieCoin/Proxy.sol";
import "../token/CalorieCoin/CalorieCoin.sol";
import "../membership/IMembership.sol";

import "./IAttendance.sol";

contract Attendance is Ownable, IAttendance {
    mapping(address=>uint256) internal _attendanceList;
    mapping(address=>bool) internal _checkerList;

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