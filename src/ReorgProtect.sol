// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ReorgProtect {
    error UnexpectedCoinbase();
    error ETHTransferFailed();

    function sendToCoinbase(address validator) public payable {
        assembly {
            // Compare block.coinbase with validator address
            let cb := coinbase()

            if iszero(eq(cb, validator)) {
                // Revert with UnexpectedCoinbase
                let selector := 0xf16ab8f7
                mstore(0x0, selector)
                revert(0x1c, 0x04)
            }

            // Perform low-level call to send value to block.coinbase
            let success := call(gas(), cb, callvalue(), 0, 0, 0, 0)

            // Check if call was successful
            if iszero(success) {
                // Revert with ETHTransferFailed
                let selector := 0xb12d13eb
                mstore(0x0, selector)
                revert(0x1c, 0x04)
            }
        }
    }
}
