// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract KeccakSecondCalldata {
    function main(uint256, uint256, uint256) external pure returns (bytes32) {
        assembly {
            // your code here
            // return the keccak hash of the SECOND argument in the calldata
            // Hint: use keccak256(offset, size)
            // solve KeccakFirstCalldata before this problem

            let fmp := mload(0x40)

            mstore(fmp, calldataload(0x24))
            mstore(fmp, keccak256(fmp, 0x20))
            return(fmp, 0x20)
        }
    }
}
