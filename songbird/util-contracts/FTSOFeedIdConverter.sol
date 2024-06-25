// SPDX-License-Identifier: MIT
pragma solidity >=0.7.6 <0.9;

// TODO: Check if there are any breaking changes in solidity versions
library FTSOFeedIdConverter {
    function FeedCategoryCrypto() internal pure returns (uint8) {
        return 1;
    }

    function FeedCategoryForex() internal pure returns (uint8) {
        return 2;
    }

    function FeedCategoryCommodity() internal pure returns (uint8) {
        return 3;
    }

    function FeedCategoryStock() internal pure returns (uint8) {
        return 4;
    }

    /**
     * Returns the feed id for given category and name.
     * @param _category Feed category.
     * @param _name Feed name.
     * @return Feed id.
     */
    function getFeedId(
        uint8 _category,
        string memory _name
    ) internal pure returns (bytes21) {
        bytes memory nameBytes = bytes(_name);
        require(nameBytes.length <= 20, "name too long");
        return bytes21(bytes.concat(bytes1(_category), nameBytes));
    }

    function getCryptoFeedId(
        string memory _name
    ) internal pure returns (bytes21) {
        return
            bytes21(bytes.concat(bytes1(FeedCategoryCrypto()), bytes(_name)));
    }

    function getForexFeedId(
        string memory _name
    ) internal pure returns (bytes21) {
        return bytes21(bytes.concat(bytes1(FeedCategoryForex()), bytes(_name)));
    }

    function getCommodityFeedId(
        string memory _name
    ) internal pure returns (bytes21) {
        return
            bytes21(
                bytes.concat(bytes1(FeedCategoryCommodity()), bytes(_name))
            );
    }

    function getStockFeedId(
        string memory _name
    ) internal pure returns (bytes21) {
        return bytes21(bytes.concat(bytes1(FeedCategoryStock()), bytes(_name)));
    }

    /**
     * Returns the feed category and name for given feed id.
     * @param _feedId Feed id.
     * @return _category Feed category.
     * @return _name Feed name.
     */
    function getFeedCategoryAndName(
        bytes21 _feedId
    ) internal pure returns (uint8 _category, string memory _name) {
        _category = uint8(_feedId[0]);
        uint256 length = 20;
        while (length > 0) {
            if (_feedId[length] != 0x00) {
                break;
            }
            length--;
        }
        bytes memory nameBytes = new bytes(length);
        for (uint256 i = 0; i < length; i++) {
            nameBytes[i] = _feedId[i + 1];
        }
        _name = string(nameBytes);
    }
}
