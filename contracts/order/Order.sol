// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

import "../token/CalorieCoin/Proxy.sol";
import "../token/CalorieCoin/CalorieCoin.sol";

import "./IOrder.sol";

contract Order is Ownable, IOrder {
    Proxy private _tokenProxy;

    uint256 private _categoryIndex;
    mapping(string=>bool) private _categoryCheckList;
    mapping(string=>mapping(uint256=>uint256)) _categoryItemIndex;
    
    uint256 private _itemIndex;
    mapping(string=>mapping(uint256=>Item)) private _itemList;
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
        }
    }

    function getLatestCategoryIndex() external view returns(uint256) 
    {
        return _categoryIndex;
    }

    // onlyOwner
    function newItem(
        string memory category,
        Item memory item
    )external override returns(uint256 itemId) {
        if(!_categoryCheckList[category]) {
            revert ErrInvalidCategory(category);
        }

        _itemIndex++;
        _itemList[category][_itemIndex] = item;
        _itemCheckList[_itemIndex] = true;
        
        emit NewItem(category, itemId);
        return _itemIndex;
    }

    // onlyOwner
    function updateItemInfo(
        string memory category,
        uint256 itemId,
        Item memory item
    )external 
     override
     onlyOwner 
    {
        if(!_categoryCheckList[category]) {
            revert ErrInvalidCategory(category);
        }

        if(!_itemCheckList[itemId]) {
            revert ErrNotExistItem(itemId);
        }

        _itemList[category][itemId] = item;
    }

    // onlyOwner
    function setOrderableAmount(
        string memory category,
        uint256 itemId,
        uint256 amount
    )external 
     override
     onlyOwner
    {   
        if(!_categoryCheckList[category]) {
            revert ErrInvalidCategory(category);
        }
        
         if(!_itemCheckList[itemId]) {
            revert ErrNotExistItem(itemId);
        }

        _limitOf[itemId] = amount;
    }

    function order(
        uint256 itemId,
        uint256 amount
    )external override {
        CalorieCoin caloriecoin = _tokenProxy.getLatestCalorieCoin();

        caloriecoin.transferFrom(msg.sender, owner(), amount);

        _balanceOf[msg.sender][itemId] += amount;

        emit Order(itemId, msg.sender, amount);
    }

    function useItem(
        uint256 itemId,
        uint256 amount
    )external override {

    }

    function getItemInfo(
        string memory category,
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

        return _itemList[category][itemId];
    }
}