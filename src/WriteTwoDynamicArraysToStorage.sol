// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteTwoDynamicArraysToStorage {
    uint256[] public writeHere1;
    uint256[] public writeHere2;

    function main(uint256[] calldata x, uint256[] calldata y) external {
        assembly {
            // your code here
            // write the dynamic calldata array `x` to storage variable `writeHere1` and
            // dynamic calldata array `y` to storage variable `writeHere2`

            let fmp := mload(0x40)

            let offset1 := calldataload(0x04)
            let offset2 := calldataload(0x24)

            let length1 := calldataload(add(0x04, offset1))
            let length2 := calldataload(add(0x04, offset2))

            sstore(writeHere1.slot, length1)
            sstore(writeHere2.slot, length2)

            let start1 := add(0x24, offset1)
            let start2 := add(0x24, offset2)

            let array1 := keccak256(fmp, 0x20)
            mstore(fmp, 1)
            let array2 := keccak256(fmp, 0x20)

            for {let i := 0} lt(i, length1) {i := add(i, 1)} {
                let element := calldataload(add(start1, mul(i, 0x20)))
                sstore(add(array1, i), element)
            }

            for {let i := 0} lt(i, length2) {i := add(i, 1)} {
                let element := calldataload(add(start2, mul(i, 0x20)))
                sstore(add(array2, i), element)
            }
        }
    }
}
