// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/access/Ownable.sol";

import "../membership/IMembership.sol";
import "./IApplication.sol";

contract Application is IApplication, Ownable {
    IMembership internal _membershipContract;

    mapping(uint256=>address) internal _teacherList;

    uint256 internal _latestClassId;
    mapping(uint256=>Class) internal _classList;
    mapping(uint256=>uint256) internal _classApplyMemberCount;

    mapping(uint256=>mapping(address=>bool)) internal _classApplyCheckList;

    constructor(IMembership membershipContract) 
        Ownable(msg.sender) 
    {
        _membershipContract = membershipContract;
    }

    // onlyOwner
    function createClass(
        address teacher,
        string memory title,
        string memory description,
        uint256 limitApplyCount,
        uint startTime,
        uint endTime
    ) external override onlyOwner {
        _latestClassId++;
        _classList[_latestClassId] = Class(teacher, title, description, limitApplyCount, startTime, endTime);

        emit NewClass(_latestClassId, teacher);
    }

    // onlyOwner
    function updateClassTeacher(
        uint256 classId,
        address teacher
    ) external override onlyOwner {
        _classList[classId] = Class(teacher, _classList[classId].title, _classList[classId].description, _classList[classId].limitApplyCount, _classList[classId].startTime, _classList[classId].endTime);
    }

    // onlyOwner
    function updateClassInfo(
        uint256 classId,
        string memory title,
        string memory description,
        uint256 limitApplyCount,
        uint startTime,
        uint endTime
    ) external override onlyOwner {
        _classList[classId] = Class(_classList[classId].teacher, title, description, limitApplyCount, startTime, endTime);
    }

    // onlyMember
    function applyClass(
        uint256 classId
    ) external override {
        if(!_membershipContract.isMember(msg.sender)) {
            revert ErrNotSubmitMember(msg.sender);
        }

        if(_classApplyCheckList[classId][msg.sender]) {
            revert ErrAlreadyApplyMember(msg.sender);
        }

        if(_classList[classId].endTime > block.timestamp) {
            revert ErrClassApplyTimeout(msg.sender, block.timestamp);
        }

        if(_classList[classId].limitApplyCount < _classApplyMemberCount[classId] + 1) {
            revert ErrClassApplyCountMaximum(_classApplyMemberCount[classId], _classList[classId].limitApplyCount);
        }

        _classApplyCheckList[classId][msg.sender] = true;
        _classApplyMemberCount[classId]++;

        emit ApplyClass(classId, block.timestamp, msg.sender);
    }

    // onlyOwner
    function dropMember(
        uint256 classId,
        address member
    ) external override onlyOwner {
        if(!_membershipContract.isMember(member)) {
            revert ErrNotSubmitMember(member);
        }

        if(!_classApplyCheckList[classId][member]) {
            revert ErrNotApplyMember(member);
        }

        _classApplyCheckList[classId][msg.sender] = false;
        _classApplyMemberCount[classId]--;
    }

    function getClassInfo(
        uint256 classId
    ) external override view returns(
        Class memory class
    ) {
        return _classList[classId];
    }

    function getClassApplyCount(
        uint256 classId
    ) external override view returns(
        uint256 applyCount
    ) {
        return _classApplyMemberCount[classId];
    }

    function isClassApply(
        uint256 classId
    ) external override view returns(
        bool check
    ) {
        return _classApplyCheckList[classId][msg.sender];
    }
}