// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReadFromDoubleMapping {
    mapping(address user => mapping(address token => uint256)) public balances;

    function setValue(address user, address token, uint256 value) external {
        balances[user][token] = value;
    }

    function main(address user, address token) external view returns (uint256) {
        assembly {
            // your code here
            // read and return the `token` balance of `user` in the double mapping `balances`
            // Hint: https://www.rareskills.io/post/solidity-dynamic

            let fmp := mload(0x40)

            mstore(fmp, user)
            let slot1 := keccak256(fmp, 0x40)

            mstore(fmp, token)
            mstore(add(fmp, 0x20), slot1)
            let slot2 := keccak256(fmp, 0x40)

            let element := sload(slot2)
            mstore(fmp, element)
            return(fmp, 0x20)
        }
    }
}
