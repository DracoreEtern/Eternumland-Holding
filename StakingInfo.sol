// SPDX-License-Identifier: MIT LICENSE

//Dracore Version

pragma solidity 0.8.4;
import "./INFTStaking.sol";
contract StakingInfo {
   
    INFTStaking public stakingContract;

    constructor(address _stakingContractAddress) {
        stakingContract = INFTStaking(_stakingContractAddress);
    }

    function getStakedTokenIDs(address owner) public view returns (uint256[] memory) {
        return stakingContract.tokensOfOwner(owner);
    }

    function earn (address owner) public view returns (uint256[] memory, uint256[] memory, uint256) {
        uint256[] memory tokenIds = getStakedTokenIDs(owner);
        uint256[] memory stakingDays = new uint256[](tokenIds.length);
        uint256 tot;

        for (uint i = 0; i < tokenIds.length; i++) {
            (, uint48 timestamp,) = stakingContract.vault(tokenIds[i]);
            require(timestamp > 0, "NFT not staked");
            uint256 stakingDurationInSeconds = block.timestamp - timestamp;
            stakingDays[i] = stakingDurationInSeconds; // Convert seconds to days
            tot += stakingDays[i];
        }

        return (tokenIds, stakingDays, tot);
    }
}
