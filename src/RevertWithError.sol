// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract RevertWithError {
    function main() external pure {
        assembly {
            // revert the function with an error of type `Error(string)`
            // use "RevertRevert" as error message
            // Hint: The error type is a predefined four bytes. See https://www.rareskills.io/post/try-catch-solidity

            let fmp := mload(0x40)
            mstore(fmp, 0x08c379a000000000000000000000000000000000000000000000000000000000) // @n selector
            mstore(add(fmp, 0x04), 0x20) // @n offset
            mstore(add(fmp, 0x24), 0x0c) // @n string length
            mstore(add(fmp, 0x44), "RevertRevert")

            revert(fmp, 0x64)
        }
    }
}