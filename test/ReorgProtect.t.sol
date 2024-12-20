// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import {Test, console} from "forge-std/Test.sol";
import {ReorgProtect} from "../src/ReorgProtect.sol";

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
        vm.snapshotGasLastCall("sendToCoinbase");

        assertEq(coinbase.balance, 1 ether);
    }

    function testSendToWrongCoinbaseReverts() public {
        address wrongCoinbase = address(0x5678);

        vm.expectRevert(abi.encodeWithSignature("UnexpectedCoinbase()"));
        reorgProtect.sendToCoinbase{value: 1 ether}(wrongCoinbase);
    }
}
