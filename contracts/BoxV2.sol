// SPDX-License-Identifier: MIT

// 1: Pragma statements
pragma solidity ^0.8.7;

// 2: Import statements

// 3: Interfaces

// 4: Libraries

// 5: Errors

// 6: Contracts

/// @title Study on upgradable contracts (Proxy -> Implementation)
/// @author Fabio Bressler
/// @notice Implementation (Logic) Contact V2
contract BoxV2 {
    // 6.a: Type declarations
    // 6.b: State variables

    uint256 internal value;

    // 6.c: Events
    event ValueChanged(uint256 indexed newValue);

    // 6.d: Modifiers
    // 6.e: Functions
    // 6.e.1: Constructor
    // 6.e.2: Receive
    // 6.e.3: Fallback
    // 6.e.4: External
    // 6.e.5: Public

    /// @notice Implements a setValue function on the implementation contract
    /// @dev Simple example to observe how a delegatecall is triggered from a proxy contract
    /// @param newValue Sets a new value to the storage variable
    function store(uint256 newValue) public {
        value = newValue;
        emit ValueChanged(newValue);
    }

    /// @notice Implements a increment function on the implementation contract
    /// @dev Increment by 1 the value storage variable
    function increment() public {
        value++;
        emit ValueChanged(value);
    }

    // 6.e.6: Internal
    // 6.e.7: Private
    // 6.e.8: View / Pure

    /// @notice Gets the value from the storage variable
    function retrieve() public view returns (uint256) {
        return value;
    }

    /// @notice Gets the version of the implementation contract
    function version() public pure returns (uint256) {
        return 2;
    }
}
