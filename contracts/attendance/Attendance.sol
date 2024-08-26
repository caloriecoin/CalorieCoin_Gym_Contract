// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./IAttendance.sol";

contract Attendance is IAttendance {
    address internal _owner;
    
    mapping(address=>uint256) internal _attendanceList;
    mapping(address=>bool) internal _checkerList;

    ERC20 internal _tokenContract;

    constructor(ERC20 tokenContract) {
        _checkerList[msg.sender] = true;
        _tokenContract = tokenContract;
    }

    function submitChecker() virtual override external {
        if (msg.sender != _owner) {
            revert ErrInvalidOwner(msg.sender);
        }

        _checkerList[msg.sender] = true;
    }

    function setRewardOffset(uint256 amount) virtual override external {

    }

    function attendance(address target) virtual override external {
        if (_checkerList[msg.sender] == false) {
            revert ErrInvalidChecker(msg.sender);
        }

        _attendanceList[target] = block.number;

        // send rewards or badge
    
        emit Attendance(msg.sender, target, block.number);
    }
}