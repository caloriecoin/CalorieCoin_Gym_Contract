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
        string nutritionFacts;
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
        string memory name,
        string memory description,
        string memory imageUrl,
        string memory tags,
        uint256 price,
        bool recommanded,
        string memory nutritionFacts
    )external returns(uint256 itemId);

    // onlyOwner
    function updateItemInfo(
        uint256 itemId,
        string memory name,
        string memory description,
        string memory imageUrl,
        string memory tags,
        uint256 price,
        bool recommanded,
        string memory nutritionFacts
    )external;

    // onlyOwner
    function setOrderableAmount(
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
        uint256 itemId
    ) external
      view
    returns (
        Item memory item
    );

    function getLatestItemIndex(
    ) external
      view
    returns (
        uint256
    );

    function getCategory(
        uint256 categoryId
    ) external
      view
    returns (
        string memory categoryName
    );

    error ErrInvalidCategory(string category);
    error ErrNotExistItem(uint256 itemId);
}