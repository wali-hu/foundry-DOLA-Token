// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {BDOLAToken} from "../src/BDOLAToken.sol";
import {DolaToken} from "../src/DolaToken.sol";
import {ROIToken} from "../src/BDOLAToken.sol";
import {MockPriceFeed} from "../src/MockPriceFeed.sol";
import {WrappedToken} from "../src/WrappedToken.sol";

contract TestContracts is Test {
    ROIToken roiToken;
    BDOLAToken bdolaToken;
    MockPriceFeed mockRoiPriceFeed;
    MockPriceFeed mockBdolaPriceFeed;
    DolaToken dolaToken;
    WrappedToken wrappedToken;

    function setUp() public {
        roiToken = new ROIToken();
        bdolaToken = new BDOLAToken();
        mockRoiPriceFeed = new MockPriceFeed(1e18);
        mockBdolaPriceFeed = new MockPriceFeed(1e18);
        dolaToken = new DolaToken(
            address(roiToken),
            address(bdolaToken),
            address(mockRoiPriceFeed),
            address(mockBdolaPriceFeed)
        );
        wrappedToken = new WrappedToken(address(roiToken));
    }

    function testWrapToken() public {
        uint256 wrapAmount = 1e18;
        roiToken.approve(address(wrappedToken), wrapAmount);
        wrappedToken.wrap(wrapAmount);
        assertEq(wrappedToken.balanceOf(address(this)), wrapAmount);
    }

    function testUnwrapToken() public {
        uint256 wrapAmount = 1e18;
        roiToken.approve(address(wrappedToken), wrapAmount);
        wrappedToken.wrap(wrapAmount);
        wrappedToken.unwrap(wrapAmount);
        assertEq(wrappedToken.balanceOf(address(this)), 0);
    }
}
