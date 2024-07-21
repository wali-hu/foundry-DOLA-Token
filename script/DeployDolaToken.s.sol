// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {DolaToken} from "../src/DolaToken.sol";
import {MockPriceFeed} from "../src/MockPriceFeed.sol";

contract DeployDolaToken is Script {
    function run() external {
        vm.startBroadcast();

        // Deploy the MockPriceFeed contract with an initial price
        MockPriceFeed mockPriceFeed = new MockPriceFeed(1000);

        // Deploy the DolaToken contract with the MockPriceFeed address
        DolaToken dolaToken = new DolaToken(
            address(0), // Placeholder for roiToken address
            address(0), // Placeholder for bdolaToken address
            address(mockPriceFeed), // roiPriceFeed address
            address(mockPriceFeed) // bdolaPriceFeed address
        );

        // Stop recording the gas costs
        vm.stopBroadcast();

        // Optionally, print the addresses to the console
        console.log("MockPriceFeed deployed to:", address(mockPriceFeed));
        console.log("DolaToken deployed to:", address(dolaToken));
    }
}
