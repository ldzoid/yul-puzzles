// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract MaxOfArray {
    function main(uint256[] memory arr) external pure returns (uint256) {
        assembly {
            // your code here
            // return the maximum value in the array
            // revert if array is empty

            let fmp := mload(0x40)
            let length := mload(arr)

            if eq(length, 0) {
                revert(0, 0)
            }

            let max := 0

            for {let i := 1} lt(i, add(length, 1)) {i := add(i, 1)} {
                let position := add(arr, mul(0x20, i))
                let element := mload(position)

                if gt(element, max) {
                    max := element
                }
            }

            mstore(fmp, max)
            return(fmp, 0x20)
        }
    }
}
