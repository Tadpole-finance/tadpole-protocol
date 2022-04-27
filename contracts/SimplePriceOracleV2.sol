pragma solidity ^0.5.16;

import "./PriceOracle.sol";
import "./CErc20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/ownership/Ownable.sol";
import "@chainlink/contracts/src/v0.5/interfaces/AggregatorV3Interface.sol";

contract SimplePriceOracleV2 is Ownable, PriceOracle {
    mapping (address => uint)    public prices;
    mapping (address => address) public chainlinkFeed;

    event PricePosted(address asset, uint previousPriceMantissa, uint requestedPriceMantissa, uint newPriceMantissa);

    constructor() public {
        // USDT
        prices[0x55d398326f99059fF775485246999027B3197955] = 1000000000000000000;

        // BUSD
        prices[0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56] = 1000000000000000000;
    }

    function getUnderlyingPrice(CToken cToken) public view returns (uint) {
        if (compareStrings(cToken.symbol(), "cETH")) {
            return 1e18;

        } else if (chainlinkFeed[underlyingAddress(cToken)] != address(0)) {
            return getChainlinkPrice(chainlinkFeed[underlyingAddress(cToken)]);

        } else {
            return prices[address(CErc20(address(cToken)).underlying())];
        }
    }

    function getChainlinkPrice(address chainlinkFeedAddress) public view returns(uint) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(chainlinkFeedAddress);
        (
            /*uint80 roundID*/,
            int256 price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        uint8 decimals = priceFeed.decimals();
        uint priceMantissa = uint(price);
        if ( decimals < 18 ) {
            priceMantissa = priceMantissa * 10**(18 - uint(decimals));
        }
        return priceMantissa;
    }

    function setChainlinkFeed(CToken cToken, address chainlinkFeedAddress) external onlyOwner {
        chainlinkFeed[underlyingAddress(cToken)] = chainlinkFeedAddress;
    }

    function setUnderlyingPrice(CToken cToken, uint underlyingPriceMantissa) public onlyOwner {
        address asset = underlyingAddress(cToken);
        setDirectPrice(asset, underlyingPriceMantissa);
    }

    function setUnderlyingPriceBatch(CToken[] memory cTokens, uint[] memory newPrices) public onlyOwner {
        for ( uint i = 0; i < cTokens.length; i++ ) {
            address asset = underlyingAddress(cTokens[i]);
            setDirectPrice(asset, newPrices[i]);
        }
    }

    function setDirectPrice(address asset, uint price) public onlyOwner {
        emit PricePosted(asset, prices[asset], price, price);
        prices[asset] = price;
    }

    // v1 price oracle interface for use as backing of proxy
    function assetPrices(address asset) external view returns (uint) {
        if (chainlinkFeed[asset] != address(0)) {
            return getChainlinkPrice(chainlinkFeed[asset]);
        }
        return prices[asset];
    }

    function underlyingAddress(CToken cToken) internal view returns (address) {
        return address(CErc20(address(cToken)).underlying());
    }

    function compareStrings(string memory a, string memory b) internal pure returns (bool) {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
    }

}
