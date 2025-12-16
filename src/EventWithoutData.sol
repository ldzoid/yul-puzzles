// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract EventWithoutData {
    // EMIT ME!!!
    event MyEvent();

    function main() external {
        assembly {
            // your code here
            // emit the `MyEvent()` event
            // use `log1` to emit the event with one topic, which is the event's signature hash
            // Hint: Calculate the event signature hash using `keccak256("MyEvent()")`
            // The event hash serves as `topic0` in the log

            let fmp := mload(0x40)

            mstore(fmp, "MyEvent()") // 9 bytes
            let fullHash := keccak256(fmp, 9)
            
            mstore(fmp, fullHash)
            log1(0, 0, fullHash)
        }
    }
}
