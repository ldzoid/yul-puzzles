// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract KeccakFirstCalldata {
    function main(uint256, uint256, uint256) external pure returns (bytes32) {
        assembly {
            // your code here
            // return the keccak hash of the FRIST argument in the calldata
            // Hint: use keccak256(offset, size)
            // Hint: don't forget to account for the offset
            // read this article for hints: https://www.rareskills.io/post/abi-encoding

            let fmp := mload(0x40)

            calldatacopy(fmp, 0x04, 0x20) // @n copy the first argument to memory

            mstore(fmp, keccak256(fmp, 0x20))

            return(fmp, 0x20)
        }
    }
}
