// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnBytes {
    function main(address a, uint256 b) external pure returns (bytes memory) {
        assembly {
            // your code here
            // encode a and b `abi.encode(a,b)` and return it.

            let fmp := mload(0x40)

            mstore(fmp, 0x20) // @n offset to bytes length
            mstore(add(fmp, 0x20), 0x40) // @n bytes length
            mstore(add(fmp, 0x40), a)
            mstore(add(fmp, 0x60), b)

            return(fmp, 0x80)
        }
    }
}
