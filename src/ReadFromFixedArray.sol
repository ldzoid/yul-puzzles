// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReadFromFixedArray {
    uint256[5] readMe; // stored in slots 0, 1, 2, 3, 4

    function setValue(uint256[5] calldata x) external {
        readMe = x;
    }

    function main(uint256 index) external view returns (uint256) {
        assembly {
            // your code here
            // read the value at the `index` in the fixed array `readMe`
            // and return it
            // Assume `index` is <= to the length of readMe
            // Hint: https://www.rareskills.io/post/solidity-dynamic

            let fmp := mload(0x40)

            mstore(fmp, sload(index))

            return(fmp, 0x20)
        }
    }
}
