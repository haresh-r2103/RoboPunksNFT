// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract RoboPunksNFT is ERC721, Ownable {
    uint256 public mintPrice;
    uint256 public totSupply;
    uint256 public maxSupply;
    uint256 public maxPerWallet;
    bool public isPublicMintEnabled;
    string internal baseTokenUri;
    address payable public withdrawWallet;
    mapping(address => uint256) public walletMints;

    constructor() payable ERC721('RoboPunks', 'RP') {
        mintPrice = 0.02 ether;
        totSupply = 0;
        maxSupply = 1000;
        maxPerWallet = 3;
        withdrawWallet = payable(msg.sender); // default to owner
    }

    // Enable/disable public mint
    function setIsPublicMintEnabled(bool isEnabled) external onlyOwner {
        isPublicMintEnabled = isEnabled;
    }

    // Set base URI for metadata
    function setBaseTokenUri(string calldata baseTokenUri_) external onlyOwner {
        baseTokenUri = baseTokenUri_;
    }

    // Optional: update withdraw wallet
    function setWithdrawWallet(address payable _wallet) external onlyOwner {
        withdrawWallet = _wallet;
    }

    // Return token URI for OpenSea / metadata
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
    require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
    return string(abi.encodePacked(baseTokenUri, Strings.toString(tokenId)));
}

    // Withdraw funds from contract
    function withdraw() external onlyOwner {
        (bool success, ) = withdrawWallet.call{ value: address(this).balance }('');
        require(success, "Withdraw failed!");
    }

    // Mint NFTs
    function mint(uint256 quantity_) public payable {
        require(isPublicMintEnabled, "Minting not enabled");
        require(msg.value == quantity_ * mintPrice, "Wrong ETH value sent");
        require(totSupply + quantity_ <= maxSupply, "Sold out");
        require(walletMints[msg.sender] + quantity_ <= maxPerWallet, "Exceeds max per wallet");

        for (uint256 i = 0; i < quantity_; i++) {
            totSupply++;
            walletMints[msg.sender]++;
            _safeMint(msg.sender, totSupply);
        }
    }
}
