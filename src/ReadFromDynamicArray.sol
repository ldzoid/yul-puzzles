// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReadFromDynamicArray {
    uint256[] readMe; // @n slot 0 stores length

    function setValue(uint256[] calldata x) external {
        readMe = x;
    }

    function main(uint256 index) external view returns (uint256) {
        assembly {
            // your code here
            // read the value at the `index` in the dynamic array `readMe`
            // and return it
            // Assume `index` is <= to the length of readMe
            // Hint: https://www.rareskills.io/post/solidity-dynamic

            let fmp := mload(0x40)

            let slot := keccak256(fmp, 0x20)

            let location := add(slot, index)

            let element := sload(location)

            mstore(fmp, element)

            return(fmp, 0x20)
        }
    }
}
