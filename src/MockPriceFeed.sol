// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./AggregatorV3Interface.sol";

contract MockPriceFeed is AggregatorV3Interface {
    int256 private currentPrice;

    constructor(int256 _initialPrice) {
        currentPrice = _initialPrice;
    }

    function decimals() public view override returns (uint8) {
        return 18;
    }

    function description() public view override returns (string memory) {
        return "Mock Price Feed";
    }

    function version() public view override returns (uint256) {
        return 1;
    }

    function latestRoundData()
        external
        view
        override
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        )
    {
        return (0, currentPrice, block.timestamp, block.timestamp, 0);
    }

    function getRoundData(
        uint80 _roundId
    )
        public
        view
        override
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        )
    {
        // For simplicity, returning the same data as latestRoundData
        return (0, currentPrice, block.timestamp, block.timestamp, 0);
    }
}
