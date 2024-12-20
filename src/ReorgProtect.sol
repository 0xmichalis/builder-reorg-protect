// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

error UnexpectedCoinbase();

contract ReorgProtect {
    function sendToCoinbase(address validator) public payable {
        if (block.coinbase != validator) {
            revert UnexpectedCoinbase();
        }
        block.coinbase.call{value: msg.value}("");
    }
}
