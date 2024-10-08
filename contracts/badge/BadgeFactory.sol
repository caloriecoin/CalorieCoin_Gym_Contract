// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

import "./Badge.sol";

contract BadgeFactory is Ownable {
    uint256 internal _badgeCount;
    mapping(uint256=>Badge) internal _badgeList;

    event BadgeCreated(string indexed name, string indexed symbol, string baseUri, string description);
    
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
        _badgeList[_badgeCount] = new Badge(msg.sender, name, symbol, baseUri, description);

        emit BadgeCreated(name, symbol, baseUri, description);
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