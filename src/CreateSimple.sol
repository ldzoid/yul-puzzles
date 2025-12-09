// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract CreateSimple {
    function main(bytes memory deploymentBytecode) external returns (address addr) {
        assembly {
            // your code here
            // create a contract using the deploymentBytecode
            // return the address of the contract
            // hint: use the `create` opcode
            // hint: the bytecode is already in memory

            let fmp := mload(0x40)

            let size := mload(deploymentBytecode)

            let c := create(0, add(deploymentBytecode, 0x20), size)

            mstore(fmp, c)
            return(fmp, 0x20)

        }
    }
}
