// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract SimpleCallWithValue {

    function main(address t) external payable {
        assembly {
            // your code here
            // call "t.foo()" while sending msg.value
            // hint: "foo()" has function selector 0xc2985578
            // hint: callvalue() returns the value of the current call

            let fmp := mload(0x40)

            mstore(fmp, shl(224, 0xc2985578))

            let c := call(gas(), t, callvalue(), fmp, 0x04, 0, 0)
       }
    }
}