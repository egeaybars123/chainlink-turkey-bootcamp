// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract PriceConsumerV3 {

    AggregatorV3Interface internal fiyatAkisi;
    mapping(address => uint) public dolarBagisi;

    /**
     * Ağ: Goerli
     * Aggregator: ETH/USD
     * Proxy adresi: 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
     */

    //0xc3a3877197223e222F90E3248dEE2360cAB56D6C
    constructor() {
        fiyatAkisi = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
    }


    function bagisYap() external payable {
        require(msg.value >= 0.0001 ether);
        uint fiyat = uint(sonFiyatiAl());
        uint bagisDolar = fiyat * msg.value;
        dolarBagisi[msg.sender] = bagisDolar;
    }


    /**
     * Doğrulanmış son ETH/USD fiyatını döndürür.
     * Daha fazla detay için: data.chain.link
     */
     
    function sonFiyatiAl() public view returns (int) {
        (
            /*uint80 roundID*/,
            int fiyat,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = fiyatAkisi.latestRoundData();
        return fiyat;
    }

    //Fiyat çıktısının kaç ondalık sayıdan oluştuğunu döndürüyor.
    function ondalikAl() public view returns (uint8 decimals) {
        decimals = fiyatAkisi.decimals();
    }

    function dolarBagisiGor(address bagisci) public view returns(uint dolar) {
        dolar = dolarBagisi[bagisci] / 10**(ondalikAl() + 16); //Ondalıktan sonraki iki basamakla ilgileniyoruz.Bu yüzden 16 yazdık, 18 değil.
    } 
}