// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {DeployMoodNft} from "../../script/DeployMoodNft.s.sol";
import {MoodNft} from "../../src/MoodNft.sol";

contract DeployMoodNftTest is Test {
    DeployMoodNft public deployer;

    function setUp() public {
        deployer = new DeployMoodNft();
    }

    function testConvertSvgToUri() public view {
        // bash: base64 -i example.svg
        // add prefix
        // note: characters in example.svg file must in one line
        string
            memory expectedUri = "data:image/svg+xml;base64,PHN2ZyBoZWlnaHQ9IjMwIiB3aWR0aD0iMjAwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjx0ZXh0IHg9IjUiIHk9IjE1IiBmaWxsPSJyZWQiPkkgbG92ZSBTVkchPC90ZXh0Pjwvc3ZnPg==";
        string
            memory svg = '<svg height="30" width="200" xmlns="http://www.w3.org/2000/svg"><text x="5" y="15" fill="red">I love SVG!</text></svg>';

        string memory actualUri = deployer.svgToImageURI(svg);
        console.log(actualUri);
        console.log(svg);
        assert(
            keccak256(abi.encodePacked(actualUri)) ==
                keccak256(abi.encodePacked(expectedUri))
        );
    }
}
