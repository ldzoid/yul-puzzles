// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteToDynamicArray {
    uint256[] writeHere;

    function main(uint256[] memory x) external {
        assembly {
            // your code here
            // store the values in the DYNAMIC array `x` in the storage variable `writeHere`
            // Hint: https://www.rareskills.io/post/solidity-dynamic

            let fmp := mload(0x40)

            let length := mload(x)
            let location := keccak256(fmp, 0x20)

            sstore(0, length)

            for {let i := 0} lt(i, length) {i := add(i, 1)} {
                let element := mload(add(x, mul(0x20, add(i, 1))))
                let slot := add(location, i)
                sstore(slot, element)
                
            }
        }
    }

    function getter() external view returns (uint256[] memory) {
        return writeHere;
    }
}
