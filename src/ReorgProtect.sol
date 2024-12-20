// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

error UnexpectedCoinbase();

contract ReorgProtect {
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
        }
    }
}
