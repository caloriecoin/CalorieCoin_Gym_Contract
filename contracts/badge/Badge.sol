// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Badge is ERC721, Ownable {
    uint256 private _nextTokenId;
    
    string private _baseUri;
    string private _description;
    
    constructor(
        address creater,
        string memory name, 
        string memory symbol,
        string memory baseUri,
        string memory description
    )
        ERC721(name, symbol)
        Ownable(creater)
    {
        _nextTokenId = 0;

        _baseUri = baseUri;
        _description = description;
    }

    function _baseURI() internal view override returns (string memory) {
        return _baseUri;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        _requireOwned(tokenId);

        return _baseURI();
    }

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
    }

    function getInfo() external view returns (
        string memory,
        string memory,
        string memory,
        string memory
    ) {
        return (name(), symbol(), _baseUri, _description);
    }
}