// SPDX-License-Identifier: MIT
pragma solidity >=0.7.6 <0.9;

interface IFTSOFeedVerifier {
    struct Feed {
        uint32 votingRoundId;
        bytes21 id;
        int32 value;
        uint16 turnoutBIPS;
        int8 decimals;
    }

    struct FeedWithProof {
        bytes32[] proof;
        Feed body;
    }

    function get_ftso_protocol_feed_id() external view returns (uint256);

    function verifyPrice(
        FeedWithProof calldata _feed_data
    ) external view returns (bool);
}
