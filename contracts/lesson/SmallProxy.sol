// SPDX-License-Identifier: MIT
// EIP 1967 :: https://eips.ethereum.org/EIPS/eip-1967
pragma solidity ^0.8.7;

import '@openzeppelin/contracts/proxy/Proxy.sol';

contract SmallProxy is Proxy {
    // This is the keccak-256 hash of "eip1967.proxy.implementation" subtracted by 1
    bytes32 private constant _IMPLEMENTATION_SLOT =
        0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;

    function setImplementation(address newImplementation) public {
        assembly {
            sstore(_IMPLEMENTATION_SLOT, newImplementation)
        }
    }

    function _implementation() internal view override returns (address implementationAddress) {
        assembly {
            implementationAddress := sload(_IMPLEMENTATION_SLOT)
        }
    }

    // helper function to get the function selector from the function siganature
    function getDataToTransact(uint256 numberToUpdate) public pure returns (bytes memory) {
        return abi.encodeWithSignature('setValue(uint256)', numberToUpdate);
    }

    // reading directly from storage the first position slot
    function readStorage() public view returns (uint256 valueAtStorageSlotZero) {
        assembly {
            valueAtStorageSlotZero := sload(0)
        }
    }
}

// SmallProxy --delegate--> ImplementationA... then save the storage in the SmallProxy address

// We are calling SmallProxy with the data to use the setValue function selector from ImplementationA

// implementation that with be associated with the proxy contract
contract ImplementationA {
    uint256 public value;

    function setValue(uint256 newValue) public {
        value = newValue;
    }
}

// SmallProxy --delegate--> ImplementationB... then save the storage in the SmallProxy address

contract ImplementationB {
    uint256 public value;

    function setValue(uint256 newValue) public {
        value = newValue + 2; // adds 2 to the value passed in
    }

    // this is an example of a function that will never be called from the proxy...
    // ...since the siganture is the same and the fallback / delegatecall won't be triggered
    function setImplementation(address someAddress) public {}
}
