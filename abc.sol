// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/// @title ABC - Simple Message Storage Contract
/// @notice Allows the owner to set and get a message.
contract ABC {
    string private message;
    address public owner;

    event MessageUpdated(string oldMessage, string newMessage);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor(string memory initialMessage) {
        owner = msg.sender;
        message = initialMessage;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    /// @notice Updates the stored message (only owner)
    function updateMessage(string calldata newMessage) external onlyOwner {
        emit MessageUpdated(message, newMessage);
        message = newMessage;
    }

    /// @notice Returns the current stored message
    function getMessage() external view returns (string memory) {
        return message;
    }

    /// @notice Transfer ownership to another address
    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "Zero address not allowed");
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }
}
