// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract RPGItem is ERC721URIStorage, Ownable {
    uint256 private _nextTokenId;
    AggregatorV3Interface internal priceFeed;
    uint256 public constant ITEM_USD_PRICE = 5 * 10**18;

    constructor(address initialOwner) ERC721("ReliquiasRPG", "RPGITM") Ownable(initialOwner) {
        priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    }

    function getLatestEthPrice() public view returns (uint256) {
        (
            /* uint80 roundID */,
            int price,
            /* uint startedAt */,
            /* uint timeStamp */,
            /* uint80 answeredInRound */
        ) = priceFeed.latestRoundData();
        return uint256(price) * 10**10;
    }

    function getMintingCost() public view returns (uint256) {
        uint256 ethPrice = getLatestEthPrice();
        return (ITEM_USD_PRICE * 10**18) / ethPrice;
    }

    function mintItem(string memory uri) public payable {
        uint256 cost = getMintingCost();
        require(msg.value >= cost, "Erro: ETH insuficiente para pagar os $5 dolares do item.");

        uint256 tokenId = _nextTokenId++;
        _mint(msg.sender, tokenId);
        _setTokenURI(tokenId, uri);
    }

    function withdraw() public onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
}
