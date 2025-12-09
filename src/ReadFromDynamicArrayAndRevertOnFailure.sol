// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReadFromDynamicArrayAndRevertOnFailure {
    uint256[] readMe;

    function setValue(uint256[] calldata x) external {
        readMe = x;
    }

    function main(int256 index) external view returns (uint256) {
        assembly {
            // your code here
            // read the value at the `index` in the dynamic array `readMe`
            // and return it
            // Revert with Solidity panic on failure, use error code 0x32 (out-of-bounds or negative index)
            // Hint: https://www.rareskills.io/post/solidity-dynamic

            let fmp := mload(0x40)
            let lengthSlot := readMe.slot
            let length := sload(lengthSlot)

            if gt(index, sub(length, 1)) {
                // panic revert
                mstore(fmp, shl(224, 0x4e487b71)) // @n Panic(uint256) sig
                mstore(add(fmp, 4), 0x32)

                revert(fmp, 0x24)
            }

            let arraySlot := keccak256(fmp, 0x20)
            let element := sload(add(arraySlot, index))
            mstore(fmp, element)
            return(fmp, 0x20)
        }
    }
}
