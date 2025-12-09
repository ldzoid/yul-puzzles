// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract PaymentSplitter {

    function main(address[] calldata recipients) external payable {
        assembly {
            // your code here
            // send the entire contract balance to the recipients
            // each recipient gets balance / recipients.length

            let fmp := mload(0x40)

            let length := recipients.length   
            let each := div(selfbalance(), length)

            

            for {let i := 0} lt(i, length) {i := add(i, 1)} {
                let recipient := calldataload(add(0x44, mul(i, 0x20)))
                let c := call(gas(), recipient, each, 0, 0, 0, 0)
            }
        }
    }
}