// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {Test, console} from "forge-std/Test.sol";
import {ReorgProtect} from "../src/ReorgProtect.sol";

// Mock contract without receive function
contract NoReceiveContract {
// Empty contract - deliberately has no receive function
}

contract ReorgProtectTest is Test {
    ReorgProtect public reorgProtect;

    // A fake coinbase address for testing
    address coinbase = address(0x1234);

    function setUp() public {
        // Deploy
        reorgProtect = new ReorgProtect();

        // Fund test account
        vm.deal(address(this), 1 ether);

        // Simulate new block
        vm.roll(1);
        vm.coinbase(coinbase);
    }

    function testSendToCorrectCoinbase() public {
        reorgProtect.sendToCoinbase{value: 1 ether}(coinbase);

        assertEq(coinbase.balance, 1 ether);
    }

    function testSendToWrongCoinbaseReverts() public {
        address wrongCoinbase = address(0x5678);

        vm.expectRevert(abi.encodeWithSelector(ReorgProtect.UnexpectedCoinbase.selector));
        reorgProtect.sendToCoinbase{value: 1 ether}(wrongCoinbase);
    }

    function testSendToContractWithoutReceiveFails() public {
        NoReceiveContract noReceiveContract = new NoReceiveContract();
        // Set the coinbase to our NoReceiveContract address
        vm.coinbase(address(noReceiveContract));

        // Try to send ETH to the contract - should revert with ETHTransferFailed
        vm.expectRevert(abi.encodeWithSelector(ReorgProtect.ETHTransferFailed.selector));
        reorgProtect.sendToCoinbase{value: 1 ether}(address(noReceiveContract));
    }
}
