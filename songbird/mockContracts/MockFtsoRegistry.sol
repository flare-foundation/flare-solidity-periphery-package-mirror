// SPDX-License-Identifier: MIT
pragma solidity >=0.7.6 <0.9;
pragma abicoder v2;

import "../contracts/ftso/interface/IIFtso.sol";
import "../contracts/genesis/interface/IFtsoRegistryGenesis.sol";
import { IFtsoRegistry } from "../contracts/userInterfaces/IFtsoRegistry.sol";

struct Price {
    uint256 price;
    uint256 timestamp;
}

contract MockFtsoRegistry is IFtsoRegistry {

    mapping (string => Price) public prices;

    mapping (string => uint256) public ftsoIndices;
    mapping (uint256 => string) public ftsoSymbols;
    uint256[] public supportedIndices;
    IIFtso[] public ftsos;

    function addFtso(IIFtso _ftsoContract) external returns(uint256) {
        uint256 index = ftsos.length;
        ftsos.push(_ftsoContract);
        ftsoIndices[_ftsoContract.symbol()] = index;
        ftsoSymbols[index] = _ftsoContract.symbol();
        return index;
    }

    function setSupportedIndices(uint256[] memory _supportedIndices, string[] memory _symbols) external {
        supportedIndices = _supportedIndices;
        for (uint256 i = 0; i < _supportedIndices.length; i++) {
            ftsoIndices[_symbols[i]] = _supportedIndices[i];
            ftsoSymbols[_supportedIndices[i]] = _symbols[i];
        }
    }

    function setPriceForSymbol(string memory _symbol, uint256 _price, uint256 _timestamp) public {
        prices[_symbol] = Price(_price, _timestamp);
    }

    function setPriceForIndex(uint256 _ftsoIndex, uint256 _price, uint256 _timestamp) public {
        string memory symbol = ftsoSymbols[_ftsoIndex];
        setPriceForSymbol(symbol, _price, _timestamp);
    }

    function getFtsos(uint256[] memory _indices) 
        external 
        view 
        override
        returns(IFtsoGenesis[] memory _ftsos)
    {}

    function getFtso(uint256 _ftsoIndex)
        external
        view
        override
        returns (IIFtso _activeFtsoAddress)
    {
        return ftsos[_ftsoIndex];
    }

    function getFtsoBySymbol(string memory _symbol)
        external
        view
        override
        returns (IIFtso _activeFtsoAddress)
    {
        uint256 index = ftsoIndices[_symbol];
        return ftsos[index];
    }

    function getSupportedIndices()
        external
        view
        override
        returns (uint256[] memory _supportedIndices)
    {
        return supportedIndices;
    }

    function getSupportedSymbols()
        external
        view
        override
        returns (string[] memory _supportedSymbols)
    {
        string[] memory symbols = new string[](supportedIndices.length);
        for (uint256 i = 0; i < supportedIndices.length; i++) {
            symbols[i] = ftsoSymbols[supportedIndices[i]];
        }
        return symbols;
    }

    function getSupportedFtsos()
        external
        view
        override
        returns (IIFtso[] memory _ftsos)
    {
        return ftsos;
    }

    function getFtsoIndex(string memory _symbol)
        external
        view
        override
        returns (uint256 _assetIndex)
    {}

    function getFtsoSymbol(uint256 _ftsoIndex)
        external
        view
        override
        returns (string memory _symbol)
    {}

    function getCurrentPrice(uint256 _ftsoIndex)
        external
        view
        override
        returns (uint256 _price, uint256 _timestamp)
    {
        string memory symbol = ftsoSymbols[_ftsoIndex];
        return this.getCurrentPrice(symbol);
    }

    function getCurrentPrice(string memory _symbol)
        external
        view
        override
        returns (uint256 _price, uint256 _timestamp)
    {
        Price memory price = prices[_symbol];
        return (price.price, price.timestamp);
    }

    function getSupportedIndicesAndFtsos()
        external
        view
        override
        returns (uint256[] memory _supportedIndices, IIFtso[] memory _ftsos)
    {}

    function getSupportedSymbolsAndFtsos()
        external
        view
        override
        returns (string[] memory _supportedSymbols, IIFtso[] memory _ftsos)
    {}

    function getSupportedIndicesAndSymbols()
        external
        view
        override
        returns (
            uint256[] memory _supportedIndices,
            string[] memory _supportedSymbols
        )
    {
        _supportedIndices = supportedIndices;
    }

    function getSupportedIndicesSymbolsAndFtsos()
        external
        view
        override
        returns (
            uint256[] memory _supportedIndices,
            string[] memory _supportedSymbols,
            IIFtso[] memory _ftsos
        )
    {}
}
