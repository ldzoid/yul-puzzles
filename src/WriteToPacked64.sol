// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteToPacked64 {
    uint64 public someValue1 = 7;
    uint64 public writeHere = 1; // position 64-128
    uint64 public someValue2 = 7;
    uint64 public someValue3 = 7;

    function main(uint256 v) external {
        assembly {
            // your code here
            // change the value of `writeHere` storage variable to `v`
            // be careful not to alter the value of `someValue` variable

            let slot := sload(writeHere.slot)
            let top := shl(128, shr(128, slot))
            let bottom := shr(192, shl(192, slot))
            let val := shr(128, shl(192, v))

            let result := or(or(top, bottom), val)

            sstore(writeHere.slot, result)
        }
    }
}
