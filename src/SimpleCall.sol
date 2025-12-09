// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract SimpleCall {

    function main(address t) external payable {
        assembly {
            // your code here
            // call "t.foo()"
            // hint: "foo()" has function selector 0xc2985578

            let fmp := mload(0x40)

            mstore(fmp, shl(224, 0xc2985578))

            let c := call(gas(), t, 0, fmp, 0x04, 0, 0)
       }
    }
}