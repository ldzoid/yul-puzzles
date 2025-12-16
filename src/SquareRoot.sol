// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract SquareRoot {
    function main(uint256 x) external pure returns (uint256) {
        assembly {
            // your code here
            // return the square root of x rounded down
            // e.g. root(4) = 2 root(5) = 2 root(6) = 2, ..., root(8) = 2, root(9) = 3
            // hint: https://www.youtube.com/watch?v=CnMBo5nG_zk (Babilonian method)
            // hint: use x / 2 as initial guess
            // hint: be careful of overflow
            // hint: use a switch statement to handle 0, 1, and the general case
            // hint: use break to exit the loop if the new guess is the same as the old guess

            let fmp := mload(0x40)

            switch x
            case 0 {
                mstore(fmp, 0)
                return(fmp, 0x20)
            }
            case 1 {
                mstore(fmp, 1)
                return(fmp, 0x20)
            }

            let guess := div(x, 2)
            for {} true {} {
                let other := div(x, guess) // x/n
                let newGuess := div(add(guess, other), 2) // average
                if iszero(lt(newGuess, guess)) {
                    mstore(fmp, guess)
                    return(fmp, 0x20)
                }
                guess := newGuess
            }
        }
    }
}