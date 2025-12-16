// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract BasicBank {
    // emit these
    event Deposit(address indexed depositor, uint256 amount);
    event Withdraw(address indexed withdrawer, uint256 amount);

    error InsufficientBalance();

    mapping(address => uint256) public balances; // base slot 0

    function deposit() external payable {
        bytes32 depositSelector = Deposit.selector;
        assembly {
            // emit Deposit(msg.sender, msg.value)
            // increment the balance of the msg.sender by msg.value

            let fmp := mload(0x40)
            mstore(fmp, caller())
            let targetSlot := keccak256(fmp, 0x40)

            let currentBalance := sload(targetSlot)
            let newBalance := add(currentBalance, callvalue())
            sstore(targetSlot, newBalance)

            // log event
            let t0 := depositSelector
            let t1 := caller()
            mstore(fmp, callvalue())
            log2(fmp, 0x20, t0, t1)

        }
    }

    function withdraw(uint256 amount) external returns (uint256 bal) {
        bytes32 withdrawSelector = Withdraw.selector;
        bytes4 insufficientBalanceSelector = InsufficientBalance.selector;
        assembly {
            // emit Withdraw(msg.sender, amount)
            // if the balance is less than amount, revert InsufficientBalance()
            // decrement the balance of the msg.sender by amount
            // send the amount to the msg.sender

            let fmp := mload(0x40)
            mstore(fmp, caller())
            let targetSlot := keccak256(fmp, 0x40)

            let currentBalance := sload(targetSlot)
            
            if gt(amount, currentBalance) {
                mstore(fmp, insufficientBalanceSelector)
                revert(fmp, 0x04)
            }

            let newBalance := sub(currentBalance, amount)
            sstore(targetSlot, newBalance)

            let c := call(gas(), caller(), amount, 0, 0, 0, 0)

            // log event
            let t0 := withdrawSelector
            let t1 := caller()
            mstore(fmp, amount)
            log2(fmp, 0x20, t0, t1)
        }
    }
}

