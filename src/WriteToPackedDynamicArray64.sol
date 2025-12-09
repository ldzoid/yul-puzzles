// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteToPackedDynamicArray64 {
    uint64[] public writeHere;

    function main(uint64 v1, uint64 v2, uint64 v3, uint64 v4, uint64 v5) external {
        assembly {
            // your code here
            // write the code to store v1, v2, v3, v4, and v5 in the `writeHere` array in sequential order.
            // Hint: `writeHere` is a dynamic array, so you will need to access its length and use `mstore` or `sstore`
            // appropriately to push new values into the array.

            let v2shifted := shl(64, v2)
            let v3shifted := shl(128, v3)
            let v4shifted := shl(192, v4)

            let slot0 := or(v1, or(v2shifted, or(v3shifted, v4shifted)))

            let fmp := mload(0x40)
            
            sstore(0, 5) // @n store length

            let arrayStart := keccak256(fmp, 0x20)
            sstore(arrayStart, slot0)
            sstore(add(arrayStart, 1), v5)
        }
    }
}
