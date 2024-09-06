// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IOrder {
    struct Item {
        string name;
        string description;
        string imageUrl;
        string tags;
        uint256 price;
        bool recommanded;
    }

    event NewItem(string indexed category, uint256 indexed itemId);
    event UpdateItemInfo(uint256 indexed itemId);
    event UseItem(uint256 indexed itemId, address indexed user, uint256 amount);
    event Order(uint256 indexed itemId, address indexed orderer, uint256 amount);
    
    // onlyOwner
    function newCategory(
        string memory category
    )external;

    function getLatestCategoryIndex() 
        external returns(uint256);

    // onlyOwner
    function newItem(
        string memory category,
        Item memory item
    )external returns(uint256 itemId);

    // onlyOwner
    function updateItemInfo(
        string memory category,
        uint256 itemId,
        Item memory item
    )external;

    // onlyOwner
    function setOrderableAmount(
        string memory category,
        uint256 itemId,
        uint256 amount
    )external;

    function order(
        uint256 itemId,
        uint256 amount
    )external;

    function useItem(
        uint256 itemId,
        uint256 amount
    )external;

    function getItemInfo(
        string memory category,
        uint256 itemId
    ) external
      view
    returns (
        Item memory item
    );

    error ErrInvalidCategory(string category);
    error ErrNotExistItem(uint256 itemId);
}