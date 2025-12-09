// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract FizzBuzz {
    function main(uint256 num) external pure returns (string memory) {
        assembly {
            // your code here
            // if `num` is divisible by 3 return the word "fizz",
            // if divisible by 5 with the word "buzz",
            // if divisible by both 3 and 5 return the word "fizzbuzz",
            // else return an empty string "".

            // Assume `num` is greater than 0.

            let fmp := mload(0x40)

            let div3 := iszero(mod(num, 3))
            let div5 := iszero(mod(num, 5))
            let both := eq(mul(div3, div5), 1)

            if both {
                mstore(fmp, 0x20)
                mstore(add(fmp, 0x20), 8)
                mstore(add(fmp, 0x40), "fizzbuzz")
                return(fmp, 0x60)
            }

            if div3 {
                mstore(fmp, 0x20)
                mstore(add(fmp, 0x20), 4)
                mstore(add(fmp, 0x40), "fizz")      
                return(fmp, 0x60)
            }

            if div5 {
                mstore(fmp, 0x20)
                mstore(add(fmp, 0x20), 4)
                mstore(add(fmp, 0x40), "buzz")      
                return(fmp, 0x60)
            }

            mstore(fmp, 0x20)
            mstore(add(fmp, 0x20), 0)
            return(fmp, 0x40)
        }
    }
}
