// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract DeployNBytes {
    function main(uint256 size) external returns (address) {
        assembly {
            // your code here
            // create a contract that is size bytes long
            // hint: you will need to generalize the init code of DeployOneByte
            // hint: use mstore8 to target a single byte
            // hint: because we only care about the size, you can simply return that region
            //       of memory and not care about what is inside it

            let fmp := mload(0x40)

            let initCode := 0x6000600c60003960006000f3 // 12 bytes
                            
            mstore(fmp, shl(160, initCode))

            mstore8(add(fmp, 1), size) // 2nd byte which says the size of runtime code to copy
            mstore8(add(fmp, 8), size) // 9th byte which says size to return

            let c := create(0, fmp, add(12, size))
            mstore(fmp, c)
            return(fmp, 0x20)
       }
    }
}
