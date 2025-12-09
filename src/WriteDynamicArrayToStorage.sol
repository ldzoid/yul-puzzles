// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteDynamicArrayToStorage {
    uint256[] public writeHere;

    function main(uint256[] calldata x) external {
        assembly {
            // your code here
            // write the dynamic calldata array `x` to storage variable `writeHere`

            let fmp := mload(0x40)
            let length := calldataload(0x24)
            let arraySlot := keccak256(fmp, 0x20)
            sstore(writeHere.slot, length)

            for {let i := 0} lt(i, length) {i := add(i, 1)} {
                let element := calldataload(add(0x44, mul(0x20, i)))
                sstore(add(arraySlot, i), element)
            }
        }
    }
}
