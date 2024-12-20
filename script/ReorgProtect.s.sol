// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {ReorgProtect} from "../src/ReorgProtect.sol";

contract ReorgProtectScript is Script {
    ReorgProtect public reorgProtect;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        reorgProtect = new ReorgProtect();

        vm.stopBroadcast();
    }
}
