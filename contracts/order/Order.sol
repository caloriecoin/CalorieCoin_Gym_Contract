// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

import "../token/CalorieCoin/Proxy.sol";
import "../token/CalorieCoin/CalorieCoin.sol";

import "./IOrder.sol";

contract Order is Ownable, IOrder {
    Proxy private _tokenProxy;

    uint256 private _categoryIndex;
    mapping(uint256=>string) private _categoryList;
    mapping(string=>uint256) private _categoryListIndex;
    mapping(string=>bool) private _categoryCheckList;
    mapping(string=>mapping(uint256=>uint256)) _categoryItemIndex;
    
    uint256 private _itemIndex;
    mapping(uint256=>Item) private _itemList;
    mapping(uint256=>bool) private _itemCheckList;

    mapping(uint256=>uint256) private _limitOf;
    mapping(address=>mapping(uint256=>uint256)) private _balanceOf;

    constructor(
        Proxy tokenProxy
    ) Ownable(msg.sender) {
        _tokenProxy = tokenProxy;
    }
  
    function newCategory(
        string memory category
    )external
     override
     onlyOwner
    {
        if(!_categoryCheckList[category])
        {
            _categoryCheckList[category] = true;
            _categoryIndex++;

            _categoryList[_categoryIndex] = category;
        }
    }

    function getLatestCategoryIndex() external view returns(uint256) 
    {
        return _categoryIndex;
    }

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
    )external override returns(uint256 itemId) {
        if(!_categoryCheckList[category]) {
            revert ErrInvalidCategory(category);
        }

        _itemIndex++;
        _categoryListIndex[category]++;

        _categoryItemIndex[category][_categoryListIndex[category]] = _itemIndex;
        _itemList[_itemIndex] = Item(name, description, imageUrl, tags, price, recommanded, nutritionFacts);

        _categoryCheckList[category] = true;
        _itemCheckList[_itemIndex] = true;
        
        emit NewItem(category, itemId);
        return _itemIndex;
    }

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
    )external 
     override
     onlyOwner 
    {
        if(!_itemCheckList[itemId]) {
            revert ErrNotExistItem(itemId);
        }

        _itemList[itemId] = Item(name, description, imageUrl, tags, price, recommanded, nutritionFacts);
    }

    // onlyOwner
    function setOrderableAmount(
        uint256 itemId,
        uint256 amount
    )external 
     override
     onlyOwner
    {   
        if(!_itemCheckList[itemId]) {
            revert ErrNotExistItem(itemId);
        }

        _limitOf[itemId] = amount;
    }

    function order(
        uint256 itemId,
        uint256 amount
    )external override {
        if(!_itemCheckList[itemId]) {
            revert ErrNotExistItem(itemId);
        }

        CalorieCoin caloriecoin = _tokenProxy.getLatestCalorieCoin();

        caloriecoin.transferFrom(msg.sender, owner(), _itemList[itemId].price * amount);

        _balanceOf[msg.sender][itemId] += amount;

        emit Order(itemId, msg.sender, amount);
    }

    function useItem(
        uint256 itemId,
        uint256 amount
    )external override {
        if(!_itemCheckList[itemId]) {
            revert ErrNotExistItem(itemId);
        }

        _balanceOf[msg.sender][itemId] -= amount;

        emit UseItem(itemId, msg.sender, amount);
    }

    function getItemInfo(
        uint256 itemId
    ) external
      override
      view
    returns (
        Item memory item
    ) {
        if(!_itemCheckList[itemId]) {
            revert ErrNotExistItem(itemId);
        }

        return _itemList[itemId];
    }

    function getLatestItemIndex(
    ) external
      override
      view
    returns (
        uint256
    ) {
        return _itemIndex;
    }

    function getCategory(
        uint256 categoryId
    ) external
      override
      view
    returns (
        string memory categoryName
    ) {
        return _categoryList[categoryId];
    }
}