// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract AnonymonusEventWithComplexData {
    enum Gender {
        Male,
        Female,
        Trans
    }

    struct Person {
        string name;
        uint256 age;
        Gender gender;
    }

    // EMIT ME!!!
    event MyEvent(address indexed emitter, bytes32 indexed id, Person person);

    function main(address emitter, bytes32 id, Person memory person) external {
        assembly {
            // your code here
            // emit the `MyEvent(address,bytes32,(string,uint256,uint8))` event.
            // Anonymous events don't have the event signature (topic0) included.
            // Hint: how the `Person` struct is encoded in mem:
            //          - struct offset
            //          - string length offset
            //          - age
            //          - gender
            //          - name length
            //          - name
            let fmp := mload(0x40)
            let personPtr := person

            mstore(fmp, 0x20) // @n offset to a struct
            mstore(add(fmp, 0x20), 0x60) // @n offset to a string within

            mstore(add(fmp, 0x40), mload(add(personPtr, 0x20))) // @n age
            mstore(add(fmp, 0x60), mload(add(personPtr, 0x40))) // @n gender
            mstore(add(fmp, 0x80), mload(add(personPtr, 0x60))) // @n string length
            mstore(add(fmp, 0xa0), mload(add(personPtr, 0x80))) // @n string

            log3(fmp, mul(6, 0x20), 0, emitter, id)
        }
    }
}
