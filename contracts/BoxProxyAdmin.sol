// SPDX-License-Identifier: MIT

// 1: Pragma statements
pragma solidity ^0.8.7;

// 2: Import statements
import '@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol';

// 3: Interfaces

// 4: Libraries

// 5: Errors

// 6: Contracts

/// @title Study on upgradable contracts (Proxy -> Implementation)
/// @author Fabio Bressler
/// @notice Proxy Contact
contract BoxProxyAdmin is ProxyAdmin {
    // 6.a: Type declarations
    // 6.b: State variables
    // 6.c: Events
    // 6.d: Modifiers
    // 6.e: Functions
    // 6.e.1: Constructor
    constructor(
        address /* owner */
    ) ProxyAdmin() {}

    // 6.e.2: Receive
    // 6.e.3: Fallback
    // 6.e.4: External
    // 6.e.5: Public
    // 6.e.6: Internal
    // 6.e.7: Private
    // 6.e.8: View / Pure
}
