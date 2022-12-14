// SPDX-License-Identifier: MIT

pragma solidity ^0.8.6;

import { IFtso } from "@flarenetwork/flare-periphery-contracts/flare/contracts/userInterfaces/IFtso.sol";
import { IPriceSubmitter } from "@flarenetwork/flare-periphery-contracts/flare/contracts/userInterfaces/IPriceSubmitter.sol";
import { IFtsoRegistry } from "@flarenetwork/flare-periphery-contracts/flare/contracts/userInterfaces/IFtsoRegistry.sol";

contract SimpleFtsoExample is IERC20Metadata {

    function getPriceSubmitter() public virtual view returns(IPriceSubmitter) {
        return IPriceSubmitter(0x1000000000000000000000000000000000000003);
    }

    function getTokenPriceWei() public view returns(uint256 _price, uint256 _timestamp) {
        IFtsoRegistry ftsoRegistry = IFtsoRegistry(address(getPriceSubmitter().getFtsoRegistry()));
        (uint256 _price, uint256 _timestamp) = ftsoRegistry.getCurrentPrice(foreignTokenSymbol);
    }

}
