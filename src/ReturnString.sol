// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnString {
    function main() external pure returns (string memory) {
        assembly {
            // your code here
            // return the exact string: `Hello, RareSkills`

            let fmp := mload(0x40)

            mstore(fmp, 0x20)
            mstore(add(fmp, 0x20), 0x11)
            mstore(add(fmp, 0x40), "Hello, RareSkills") // len 17

            return(fmp, 0x60)
        }
    }
}
