// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnArrayOfUint256 {
    function main(uint256 a, uint256 b, uint256 c) external pure returns (uint256[] memory) {
        assembly {
            // your code here
            // return an array of [a,b,c]

            let fmp := mload(0x40)
            mstore(fmp, 0x20)
            mstore(add(fmp, 0x20), 0x03)
            mstore(add(fmp, 0x40), a)
            mstore(add(fmp, 0x60), b)
            mstore(add(fmp, 0x80), c)
            
            return(fmp, 0xc0)
        }
    }
}
