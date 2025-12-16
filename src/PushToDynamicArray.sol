// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract PushToDynamicArray {
    uint256[] pushToMe = [23, 4, 19, 3, 44, 88];

    function main(uint256 newValue) external {
        assembly {
            // your code here
            // push the newValue to the dynamic array `pushToMe`
            // Hint: https://www.rareskills.io/post/solidity-dynamic

            let fmp := mload(0x40)
            let lengthSlot := pushToMe.slot
            let length := sload(lengthSlot)

            sstore(lengthSlot, add(length, 1))

            mstore(fmp, lengthSlot)
            let arraySlot := keccak256(fmp, 0x20)

            let slotToWrite := add(arraySlot, length)

            sstore(slotToWrite, newValue)
        }
    }

    function getter() external view returns (uint256[] memory) {
        return pushToMe;
    }
}
