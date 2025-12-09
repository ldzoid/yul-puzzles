// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract Approve {
    // emit these
    function main(address token, uint256 amount) external {
        assembly {
            // your code here
            // approve "token" to spend "amount"
            // hint: approve has function selector 0x095ea7b3 and signature "approve(address,uint256)"

            let fmp := mload(0x40)
            mstore(fmp, shl(224, 0x095ea7b3))
            mstore(add(fmp, 0x04), token)
            mstore(add(fmp, 0x24), amount)

            let c := call(gas(), token, 0, fmp, 0x44, 0, 0)
       }
    }
}

