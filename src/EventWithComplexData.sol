// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract EventWithComplexData {
    // EMIT ME!!!
    event MyEvent(address indexed emitter, address[] players, uint256[] scores);

    function main(address emitter, address[] memory players, uint256[] memory scores) external {
        assembly {
            // your code here
            // emit the `MyEvent(address,address[],uint256[])` event
            // Hint: Use `log2` to emit the event with the hash as the topic0 and `emitter` as topic1, then the data

            let fmp := mload(0x40)

            let t0 := 0x06af3d8f9866c9f54dcf425d9da9f75849af90454a25bca9df5fb24d80683e6a
            let t1 := emitter

            let playersPtr := players
            let scoresPtr := scores

            let length1 := mload(playersPtr) // length 1
            let length2 := mload(scoresPtr) // length 2

            let offset1 := 0x40
            let offset2 := add(0x60, mul(length1, 0x20))

            mstore(fmp, offset1) // offset to len1
            mstore(add(fmp, 0x20), offset2) // offset to len2

            mstore(add(fmp, offset1), length1)
            mstore(add(fmp, offset2), length2)

            for {let i := 0} lt(i, length1) {i := add(i, 1)} { // array 1 copy
                let element := mload(add(playersPtr, mul(add(i, 1), 0x20)))
                let newLocation := add(fmp, add(offset1, mul(add(i, 1), 0x20)))
                mstore(newLocation, element)
            }

            for {let i := 0} lt(i, length2) {i := add(i, 1)} { // array 2 copy
                let element := mload(add(scoresPtr, mul(add(i, 1), 0x20)))
                let newLocation := add(fmp, add(offset2, mul(add(i, 1), 0x20)))
                mstore(newLocation, element)
            }

            let totalLength := add(mul(add(length1, length2), 0x20), 0x80)

            log2(fmp, totalLength, t0, t1)

        }
    }
}
