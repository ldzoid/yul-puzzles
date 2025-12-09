// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract PopFromDynamicArray {
    uint256[] popFromMe = [23, 4, 19, 3, 44, 88];

    function main() external {
        assembly {
            // your code here
            // pop the last element from the dynamic array `popFromMe`
            // dont forget to clean the popped element's slot.
            // Hint: https://www.rareskills.io/post/solidity-dynamic

            let fmp := mload(0x40)
            let lengthSlot := popFromMe.slot
            let length := sload(lengthSlot)
            let newLength := sub(length, 1)
            let arraySlot := keccak256(fmp, 0x20)

            let slotToModify := add(arraySlot, sub(length, 1))

            sstore(slotToModify, 0)
            sstore(lengthSlot, newLength)

        }
    }

    function getter() external view returns (uint256[] memory) {
        return popFromMe;
    }

    function lastElementSlotValue(bytes32 s) external view returns (uint256 r) {
        assembly {
            r := sload(s)
        }
    }
}
