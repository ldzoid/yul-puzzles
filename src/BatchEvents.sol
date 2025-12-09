// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract BatchEvents {
    // EMIT ME!!!
    event MyEvent(address indexed emitter, bytes32 indexed id, uint256 num);

    function main(address[] memory emitters, bytes32[] memory ids, uint256[] memory nums) external {
        assembly {
            // your code here
            // emit the `MyEvent(address,bytes32,uint256)` event
            // Assuming all arrays (emitters, ids, and nums) are of equal length.
            // iterate over the set of parameters and emit events based on the array length.

            let fmp := mload(0x40)

            let length := mload(emitters)
            let t0 := 0x044d482819499c9d5fde1245ce63873b1259fc52fc78651ccdcdf7392637d374

            for {let i := 0} lt(i, length) {i := add(i, 1)} {
                let t1 := mload(add(emitters, mul(add(i, 1), 0x20)))
                let t2 := mload(add(ids, mul(add(i, 1), 0x20)))
                let num := mload(add(nums, mul(add(i, 1), 0x20)))

                mstore(fmp, num)
                log3(fmp, 0x20, t0, t1, t2)
            }
        }
    }
}
