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
- add some png image into `img` folder
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
    - we get metadata JSON object which not the `schema` itself but an instance of data that conforms to that `schema`:
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
    - go to `https://ipfs.io/ipfs/QmNf1UsmdGaMbpatQ6toXSkzDpizaGmC9zfunCyoz1enD5/penguin/1378.png` to watch image(through centralized gateway)

## IPFS

- how IPFS work
  - our `files` are hashed by IPFS and get a unique `hash value`(unique Content Identifier (CID))
  - our `files` are pinned to our IPFS Node
  - our IPFS Node is connected to the network composed by other IPFS Nodes
  - our `files` is located in the IPFS network by the `hash value`
  - our `files` can have copies pinned to other IPFS Node
- IPFS is just a decentralized storage
- IPFS Node optionally choose which data they want to pin and they can't do any excution

## Hosting on IPFS

- install IPFS
  - IPFS Desktop: `https://docs.ipfs.tech/install/ipfs-desktop/#ubuntu`
  - IPFS Companion Browser Extention
  - IPFS kubo: `https://docs.ipfs.tech/how-to/kubo-basic-cli/#install-kubo`
- import `pug.png` file with Extention, we get CID `QmSsYRx3LpDAb1GZQm7zZ1AuHZjfbPkD6J7s9r41xu1mf8`
- in browser view `ipfs://QmSsYRx3LpDAb1GZQm7zZ1AuHZjfbPkD6J7s9r41xu1mf8`, we can see the picture of `pug.png`
  - IPFS gateway can also access file on IPFS Node: `https://ipfs.io/ipfs/QmSsYRx3LpDAb1GZQm7zZ1AuHZjfbPkD6J7s9r41xu1mf8`
- we can use `ipfs://QmSsYRx3LpDAb1GZQm7zZ1AuHZjfbPkD6J7s9r41xu1mf8` as image URI for our NFT

## Using IPFS

- just use `ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json` as tokenURI, we get metadata:

```javascript
{
    "name": "PUG",
    "description": "An adorable PUG pup!",
    "image": "https://ipfs.io/ipfs/QmSsYRx3LpDAb1GZQm7zZ1AuHZjfbPkD6J7s9r41xu1mf8?filename=pug.png",
    "attributes": [
        {
            "trait_type": "cuteness",
            "value": 100
        }
    ]
}
```

- note: we should first upload image file and then upload metadata to IPFS
- improve `BasicNft.sol`

## Basic NFT: Deploy Script

- create `DeployBasicNft.s.sol`
- run:
  ```bash
  fogre compile
  ```

## Basic NFT: Tests

- create `BasicNftTest.t.sol`
- run:
  ```bash
  forge test
  ```

## Basic NFT: Interactions

- run:
  ```bash
  forge install Cyfrin/foundry-devops --no-commit
  ```
  - see `https://github.com/Cyfrin/foundry-devops`
- create `Interactions.s.sol`

## Basic NFT: Testnet Demo

- run:
  ```bash
  sudo apt install make -y
  make --version
  ```
- create `Makefile`
- edit `foundry.toml`
- run:

  ```bash
  make deploy ARGS="--network sepolia"
  ```

- run:
  ```bash
  make mint ARGS="--network sepolia"
  ```
- from Metamask `Import NFT` import the Nft contract address which is just deployed
  - fill out `Address`, `Token ID` correctly

## The issue with IPFS & HTTPS TokenURI(Metadata) NFTs

- Ranking of "NFT Metadata Decentralization": SVG > IPFS >> HTTPS
- `pindata.cloud` can pin your data

## What is an SVG?

- see `https://www.w3schools.com/graphics/svg_intro.asp`
- create `example.svg`
- run:
  ```bash
  cd img
  base64 -i example.svg
  ```
- add some svg file to img folder
- create `svgBase64Encode.txt` file

## SVG NFT: Introduction

- note layout of code:

  ```solidity
  // Layout of Contract:
  // version
  // imports
  // errors
  // interfaces, libraries, contracts
  // Type declarations
  // State variables
  // Events
  // Modifiers
  // Functions

  // Layout of Functions:
  // constructor
  // receive function (if exists)
  // fallback function (if exists)
  // external
  // public
  // internal
  // private
  // view & pure functions
  ```

- create `MoodNft.sol`

## SVG NFT: Encoding the NFT

- use base64 encode svg file and add prefix so that it become embedded URL(image URI) for browser
  - see `svgBase64Encode.txt` file
  - note: token URI(NFT state) include image URI(NFT view)
- encode json object to store token URI(a json object) on chain
  - using openzeppelin Base64
  - first make json object(NFT state aka token metadata) and then convert it into json token URI
- improve `tokenURI` function which using base64 encode
- create `MoodNftURITest.t.sol` file
- run:
  ```bash
  forge test --match-test testViewTokenURI -vv
  ```

## SVG NFT: Flipping the mood

- create `flipMood` funciton in MoodNft contract

## SVG NFT: Deploy Script

- create `DeployMoodNft.s.sol`
- create `DeployMoodNftTest.t.sol`
- run:`forge test --match-test testConvertSvgToUri`
