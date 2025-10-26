// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "./abc.sol";
/// @title XYZ - Simple Counter Contract
/// @notice Anyone can increment or decrement the counter
contract XYZ {
    int256 private counter;

    event CounterChanged(int256 newValue);

    constructor(int256 startValue) {
        counter = startValue;
    }

    /// @notice Increment the counter by 1
    function increment() external {
        counter += 1;
        emit CounterChanged(counter);
    }

    /// @notice Decrement the counter by 1
    function decrement() external {
        counter -= 1;
        emit CounterChanged(counter);
    }

    /// @notice Get current counter value
    function getCounter() external view returns (int256) {
        return counter;
    }
}
