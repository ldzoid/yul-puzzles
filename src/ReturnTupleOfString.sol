// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnTupleOfString {
    function main() external pure returns (string memory, string memory) {
        assembly {
            // your code here
            // return the tuple of string: ("Hello", "RareSkills")

            let fmp := mload(0x40)

            let off1 := 0x40
            let off2 := 0x80

            mstore(fmp, off1)
            mstore(add(fmp, 0x20), off2)
            mstore(add(fmp, 0x40), 5)
            mstore(add(fmp, 0x60), "Hello")
            mstore(add(fmp, 0x80), 10)
            mstore(add(fmp, 0xa0), "RareSkills")

            return(fmp, 0xc0)
        }
    }
}
