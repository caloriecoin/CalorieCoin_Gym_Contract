// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/access/Ownable.sol";

import "./Badge.sol";

contract BadgeFactory is Ownable {
    uint256 internal _badgeCount;
    mapping(uint256=>Badge) internal _badgeList;
    
    constructor()
        Ownable(msg.sender)
    {}

    function createBadge(
        string memory name, 
        string memory symbol,
        string memory baseUri,
        string memory description
    ) external onlyOwner {
        _badgeCount++;
        _badgeList[_badgeCount] = new Badge(name, symbol, baseUri, description);
    }

    function getLatestBadgeId() external view returns(uint256) {
        return _badgeCount;
    }

    function getBadge(uint256 badgeId) external view returns(Badge) {
        return _badgeList[badgeId];
    }

    function getBadgeInfo(uint256 badgeId) external view 
    returns(
        string memory,
        string memory,
        string memory,
        string memory
    )
    {
        return _badgeList[badgeId].getInfo();
    }
}