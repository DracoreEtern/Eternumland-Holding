// SPDX-License-Identifier: MIT LICENSE

//Dracore Version

pragma solidity 0.8.4;

interface INFTStaking {
    function tokensOfOwner(address account) external view returns (uint256[] memory);
    function vault(uint256 tokenId) external view returns (uint24, uint48, address);
}
