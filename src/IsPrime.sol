// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract IsPrime {
    function main(uint256 x) external pure returns (bool) {
        assembly {
            // your code here
            // return true if x is a prime number, else false
            // 1. check if the number is a multiple of 2 or 3
            // 2. loop from 5 to x / 2 to see if it is divisible
            // 3. increment the loop by 2 to skip the even numbers

            let fmp := mload(0x40)

            if eq(x, 1) {
                return(fmp, 32)
            }

            if or(eq(mod(x, 2), 0), eq(mod(x, 3), 0)) { // if its divisible by 2 or 3 return false
                return(fmp, 32)
            }

            for {let i := 5} lt(i, div(x, 2)) {i := add(i, 2)} { // loop from 5 to x/2
                if eq(mod(x, i), 0) {
                    return(fmp, 32)
                }
            }

            mstore(fmp, 1)
            return(fmp, 32)
        }
    }
}
