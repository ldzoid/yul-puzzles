// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract RevertWithSelectorPlusArgs {
    error RevertData(uint256); // selector: 0xae412287

    function main(uint256 x) external pure {
        assembly {
            // your code here
            // revert custom error with x parameter
            // Hint: concatenate selector and x by storing them
            // adjacent to each other in memory

            let fmp := mload(0x40)
            mstore(fmp, shl(224, 0xae412287)) // @n selector left padded to one word
            mstore(add(fmp, 4), x)

            revert(fmp, 0x24)
        }
    }
}