// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

interface IApplication {
    struct Class {
        address teacher;
        string title;
        string description;
        uint256 limitApplyCount;
        uint startTime;
        uint endTime;
    }

    event NewClass(uint256 indexed classId, address indexed teacher);
    event ApplyClass(uint256 indexed classId, uint applyTime, address indexed applyer);

    // onlyOwner
    function createClass(
        address teacher,
        string memory title,
        string memory description,
        uint256 limitApplyCount,
        uint startTime,
        uint endTime
    ) external;

    // onlyOwner
    function updateClassTeacher(
        uint256 classId,
        address teacher
    ) external;

    // onlyOwner
    function updateClassInfo(
        uint256 classId,
        string memory title,
        string memory description,
        uint256 limitApplyCount,
        uint startTime,
        uint endTime
    ) external;

    // onlyMember
    function applyClass(
        uint256 classId
    ) external;

    // onlyOwner
    function dropMember(
        uint256 classId,
        address member
    ) external;

    function getClassInfo(
        uint256 classId
    ) external view returns(
        Class memory class
    );

    function getClassApplyCount(
        uint256 classId
    ) external view returns(
        uint256 applyCount
    );

    function isClassApply(
        uint256 classId
    ) external view returns(
        bool check
    );

    error ErrInvalidOwner(address owner);
    error ErrInvalidTeacher(address teacher);
    error ErrNotSubmitMember(address member);
    error ErrAlreadyApplyMember(address member);
    error ErrNotApplyMember(address member);
    error ErrClassApplyTimeout(address member, uint timestamp);
    error ErrClassApplyCountMaximum(uint256 currentApplyCount, uint256 limitApplyCount);
}