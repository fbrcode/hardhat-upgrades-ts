# Upgradable Contracts

## Init

- `git init`
- `yarn init -y`

## Concepts

### Delegatecall

Reference: <https://solidity-by-example.org/delegatecall/>

**delegatecall** is a low level function similar to **call**.

When contract **A** executes **delegatecall** to contract **B**, **B**'s code is executed

with contract **A**'s storage, **msg.sender** and **msg.value**.

```sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// NOTE: Deploy this contract first
contract B {
  // NOTE: storage layout must be the same as contract A
  uint256 public num;
  address public sender;
  uint256 public value;

  function setVars(uint256 _num) public payable {
    num = _num;
    sender = msg.sender;
    value = msg.value;
  }
}

contract A {
  uint256 public num;
  address public sender;
  uint256 public value;

  function setVars(address _contract, uint256 _num) public payable {
    // A's storage is set, B is not modified.
    (bool success, bytes memory data) = _contract.delegatecall(
      abi.encodeWithSignature('setVars(uint256)', _num)
    );
  }
}

```

## Instructions

1. Upgrade contract Box --to--> BoxV2
2. Proxy contract --point_to--> Box
3. Then Proxy contract will --point_to--> BoxV2

### Check list

1. Deploy a Proxy manually
2. Hardhat-deploy built-in proxies (code example ✅) <https://github.com/wighawag/hardhat-deploy#deploying-and-upgrading-proxies>
3. Openzeppelin Upgrades Plugin: <https://docs.openzeppelin.com/upgrades-plugins/1.x/>
