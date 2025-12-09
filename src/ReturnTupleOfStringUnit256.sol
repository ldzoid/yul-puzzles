// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnTupleOfStringUnit256 {
    function main() external pure returns (string memory, uint256) {
        assembly {
            // your code here
            // return the tuple of (string and uint256): ("RareSkills", 420)

            let fmp := mload(0x40)

            mstore(fmp, 0x40)
            mstore(add(fmp, 0x20), 420)
            mstore(add(fmp, 0x40), 10)
            mstore(add(fmp, 0x60), "RareSkills")

            return(fmp, 0x80)
        }
    }
}
