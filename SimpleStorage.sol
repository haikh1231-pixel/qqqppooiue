// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./contracts/EventExample.sol";
contract SimpleStorage {
    uint public storedData;

    function set(uint x) public {
        storedData = x;
    }

    function get() public view returns (uint) {
        return storedData;
    }
}