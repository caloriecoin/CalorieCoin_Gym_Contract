// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IOrder {
    enum OrderState {
        NONE,
        NEW,
        ORDERABLE,
        PAUSE,
        CANCEL
    }

    struct Item {
        string imageUrl;
        string name;
        string description;
        string category;
        string tags;
        uint256 price;
        bool recommanded;
    }

    // 신규 아이템 등록 이벤트
    event NewItem(bytes32 indexed itemId);

    // 아이템 정보 변경 이벤트
    event ChangeItem(bytes32 indexed itemId);

    // 주문 이벤트
    event Order(bytes32 indexed itemId, address indexed orderer, uint256 amount);

    // 아이템 사용 이벤트
    event UseItem(bytes32 indexed itemId, address indexed user, uint256 amount);
    
    // 신규 아이템 등록 (owner)
    function submitNewItem(
        bytes32 itemId,
        Item memory item
    )external;

    // 아이템 정보 수정 (owner)
    function updateItemInfo(
        bytes32 itemId,
        Item memory item
    )external;

    // 아이템 별 주문 가능 수량 수정 (owner)
    function setOrderableAmount(
        bytes32 itemId,
        uint256 amount
    )external;

    // 주문 
    function order(
        bytes32 itemId,
        address tokenContract,
        uint256 amount
    )external;

    // 아이템 사용
    function useItem(
        bytes32 itemId,
        uint256 amount
    )external;

    // 아이템 조회
    function getItemInfo(
        bytes32 itemId
    ) external
      view
      returns (
          Item memory item
      );
}

contract Lock {
    uint public unlockTime;
    address payable public owner;

    event Withdrawal(uint amount, uint when);

    constructor(uint _unlockTime) payable {
        require(
            block.timestamp < _unlockTime,
            "Unlock time should be in the future"
        );

        unlockTime = _unlockTime;
        owner = payable(msg.sender);
    }

    function withdraw() public {
        // Uncomment this line, and the import of "hardhat/console.sol", to print a log in your terminal
        // console.log("Unlock time is %o and block timestamp is %o", unlockTime, block.timestamp);

        require(block.timestamp >= unlockTime, "You can't withdraw yet");
        require(msg.sender == owner, "You aren't the owner");

        emit Withdrawal(address(this).balance, block.timestamp);

        owner.transfer(address(this).balance);
    }
}
