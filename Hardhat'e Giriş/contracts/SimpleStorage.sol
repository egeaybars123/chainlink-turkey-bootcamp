//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorage {
    string private message;
    address public owner;

    event MessageChanged(string newMessage);

    constructor() {
        message = "Chainlink Turkey Bootcamp";
        owner = msg.sender;
    }

    //gas harcanmıyor
    function getMessage() public view returns (string memory) {
        return message;
    }

    function setMessage(string memory newMessage) public onlyOwner {
        require(bytes(newMessage).length > 0, "Empty string not allowed");

        message = newMessage;
        emit MessageChanged(newMessage);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not an owner");
        _;
    }
}