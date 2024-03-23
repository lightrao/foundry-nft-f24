// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract basicNft is ERC721 {
    uint256 private s_tokenCounter; // token ID

    constructor() ERC721("Dogie", "DOG") {
        s_tokenCounter = 0;
    }

    function mintNft() public {}

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        // return
        //     "ipfs://bafybeibc5sgo2plmjkq2tzmhrn54bk3crhnc23zd2msg4ea7a4pxrkgfna/1378";
    }
}
