// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Badge is ERC721, Ownable {
    uint256 private _nextTokenId;

    constructor()
        ERC721("TestBadge", "Test")
        Ownable(msg.sender)
    {}

    function _baseURI() internal pure override returns (string memory) {
        return "https://example.com/badge.svg";
    }

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
    }
}