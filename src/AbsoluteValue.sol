// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract AbsoluteValue{

  function main(int256 x) external pure returns (uint256) {
      assembly {
          // your code here
          // return the absolute value of x
          // hint: use signed comparisons
          // hint: https://www.rareskills.io/post/signed-int-solidity

          let fmp := mload(0x40)

          if slt(x, 0) { // if negative, return 2's complement
            let r := add(not(x), 1)
            mstore(fmp, r)
            return(fmp, 0x20)
          }

          mstore(fmp, x)
          return(fmp, 0x20)
          
      }
  }
}
