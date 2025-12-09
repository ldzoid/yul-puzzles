// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnTwoBools {
    function main(bool a, bool b) external pure returns (bool, bool) {
        assembly {
            // your code here
            // return the tuple (a,b)

            let fmp := mload(0x40)

            mstore(fmp, a)
            mstore(add(fmp, 0x20), b)

            return(fmp, 0x40)
        }
    }
}
