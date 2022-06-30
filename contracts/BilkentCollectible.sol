// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract SimpleCollectible is ERC721URIStorage {

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    mapping (uint256 => uint256) public tokenIDexpirationDate;
    constructor () ERC721("Bilkent", "BLKNT"){ }

    function createCollectible(string memory tokenURI) public returns (uint256) {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);
        
        tokenIDexpirationDate[newItemId] = block.timestamp + 30;

        return newItemId;
    }

    function isValid(uint256 tokenID) public view returns (string memory) {
        if (block.timestamp > tokenIDexpirationDate[tokenID]) {
            return ("Inactive");
        }
        else {
            return ("Still active");
        }
    } 
}