## Foundry NFT

Talk about NFT

## What is an NFT?

- NFT(Non-Fungible Token): ERC-721
  - `mapping (uint256 => address) private _owners //token ID to owner address`
    - each token is unique, each token ID represents a unique assets and belong to a owner
  - `function tokenURI(uint256 tokenId) public view virtual override returns (string memory)`
    - tokenURI point to states of the token which maybe store off chain
    - tokenURI is just a simple API call: `const tx = await dnd.setTokenURI(0, "http://ipfs.io/ipfs/<hash value>?filename=<filename>.json")`
    - tokenURI format:
    ```javascript
    {
        "name": "Name",
        "description": "Description",
        "image": "URI", // a separate URI that points to an image
        "attributes": []
    }
    ```
  - Metadata: describe the state of the token
    - on-chain metadata store VS off-chain metadata store
      - IPFS: decentralized off-chain storage
      - centralized api: will gose down and you lose your NFT characters
      - most nft market can't read off on-chain attributes or on-chain metadata because they are looking for tokenURI
- Render off-chain Image of NFT
  1. Get IPFS
  2. Add your Image and metadata file(tokenURI json file) pointing to the image to IPFS
  3. Grab that IPFS URI(IPFS link to tokenURI json file) and set it as your NFT tokenURI
  4. watch `https://blog.chain.link/build-deploy-and-sell-your-own-dynamic-nft/`
- deploy NFT with some on-chain attributes
- ERC-20
  - `mapping (address => uint256) private _balances`
- Semi-Fungible Token: ERC-1155
- go to `https://eips.ethereum.org/EIPS/eip-721`
- go to `https://github.com/nibbstack/erc721`

## Setup

- run:
  ```bash
  mkdir foundry-nft-f24
  cd foundry-nft-f24/
  code .
  forge init
  ```
