// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnSimpleStruct {
    // STRUCT
    struct Point {
        uint256 x;
        uint256 y;
    }

    function main(uint256 x, uint256 y) external pure returns (Point memory) { // @n encoded inline without offset because it only contains static data
        assembly {
            // your code here
            // return the struct: `Point{x,y}`

            let fmp := mload(0x40)

            mstore(fmp, x)
            mstore(add(fmp, 0x20), y)

            return(fmp, 0x40)
        }
    }
}
