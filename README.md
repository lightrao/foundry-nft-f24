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

## Foundry Setup

- run:
  ```bash
  mkdir foundry-nft-f24
  cd foundry-nft-f24/
  code .
  forge init
  forge install OpenZeppelin/openzeppelin-contracts --no-commit
  ```
- add `remappings` into `foundry.toml`
- create `BasicNft.sol` file
  - about `tokenURI`: an endpoint(used by some API call) hosted some where(on chain or on ipfs etc.) that's going to return metadata(JSON file) for the NFT
    - The metadata extension is OPTIONAL for ERC-721 smart contracts, This allows your smart contract to be interrogated for its name and for details about the assets which your NFTs represent.
      ```solidity
      /// @notice A distinct Uniform Resource Identifier (URI) for a given asset.
      /// @dev Throws if `_tokenId` is not a valid NFT. URIs are defined in RFC
      ///  3986. The URI may point to a JSON file that conforms to the "ERC721
      ///  Metadata JSON Schema".
      function tokenURI(uint256 _tokenId) external view returns (string);
      ```
      This is the “ERC721 Metadata JSON Schema” referenced above, which defines what NFT looks like:
      ```javascript
      {
        "title": "Asset Metadata",
        "type": "object",
        "properties": {
            "name": {
                "type": "string",
                "description": "Identifies the asset to which this NFT represents"
            },
            "description": {
                "type": "string",
                "description": "Describes the asset to which this NFT represents"
            },
            "image": {
                "type": "string",
                "description": "A URI pointing to a resource with mime type image representing the asset to which this NFT represents."
            }
        }
      }
      ```
  - Pudgy Penguin Example
    - go to `https://opensea.io/assets/ethereum/0xbd3531da5cf5857e7cfaa92426877b022e612cf8/1378`
    - view Details, click Contract Address: `https://etherscan.io/address/0xbd3531da5cf5857e7cfaa92426877b022e612cf8`
    - click `tokenURI` function and input `tokenId` is 1378, we get: `string :  ipfs://bafybeibc5sgo2plmjkq2tzmhrn54bk3crhnc23zd2msg4ea7a4pxrkgfna/1378`
    - replace the `ipfs://` part of your link with the gateway URL `https://ipfs.io/ipfs/`
    - go to `https://ipfs.io/ipfs/bafybeibc5sgo2plmjkq2tzmhrn54bk3crhnc23zd2msg4ea7a4pxrkgfna/1378`
    - we get :
    ```javascript
    {
      "attributes": [
        {
          "trait_type": "Background",
          "value": "Yellow"
        },
        {
          "trait_type": "Skin",
          "value": "Maroon"
        },
        {
          "trait_type": "Body",
          "value": "Silver Medal"
        },
        {
          "trait_type": "Face",
          "value": "Circle Glasses"
        },
        {
          "trait_type": "Head",
          "value": "Beanie Orange"
        }
      ],
      "description": "A collection 8888 Cute Chubby Pudgy Penquins sliding around on the freezing ETH blockchain.",
      "image": "ipfs://QmNf1UsmdGaMbpatQ6toXSkzDpizaGmC9zfunCyoz1enD5/penguin/1378.png",
      "name": "Pudgy Penguin #1378"
    }
    ```
    - go to `https://ipfs.io/ipfs/QmNf1UsmdGaMbpatQ6toXSkzDpizaGmC9zfunCyoz1enD5/penguin/1378.png` to watch image

## IPFS

- add some png image into `img` folder
