// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BilkentIEEE is Ownable, VRFConsumerBaseV2 {
    VRFCoordinatorV2Interface COORDINATOR;
    uint64 subscriptionId;

    //Goerli test ağı için:
    address private vrfCoordinator = 0x2Ca8E0C643bDe4C2E08ab1fA0da3401AdAD7734D;
    bytes32 private keyHash = 0x79d3d8832d904592c0bf9818b621522c988bb8b0c05cdc3b15aea1b6e8db0c15;

    uint16 private requestConfirmations = 3;

    uint256 public sonRastgeleSayi;
    uint32 private callbackGasLimit = 150000;
    uint32 private numWords = 1;

    address[] public katilimcilar;
    address public kazanan;
    mapping(address => bool) public katilimDurumu;

    constructor(uint64 _subscriptionId) VRFConsumerBaseV2(vrfCoordinator) {
        COORDINATOR = VRFCoordinatorV2Interface(vrfCoordinator);
        subscriptionId = _subscriptionId;
    }

    function requestRandomWords() external onlyOwner {
        COORDINATOR.requestRandomWords(
        keyHash,
        subscriptionId,
        requestConfirmations,
        callbackGasLimit,
        numWords
        );  
    }

    function SubscriptionIdDegistir(uint64 _newId) external onlyOwner {
        subscriptionId = _newId;
    }

    function fulfillRandomWords(
        uint256, /* requestID */
        uint256[] memory randomWords
    ) internal override {
        sonRastgeleSayi = randomWords[0];
        KazananiBelirle();
    }

    function KazananiBelirle() internal {
        uint256 randomSayi = sonRastgeleSayi % katilimcilar.length;
        kazanan = katilimcilar[randomSayi];
    }

    //mapping kullanmalıyız çünkü bir adres birden fazla kez kendisini listeye ekleyebilir.
    function cekiliseKatil() external {
        require(!katilimDurumu[msg.sender], "Adres zaten cekilise katilmistir");
        katilimDurumu[msg.sender] = true;
        katilimcilar.push(msg.sender);
    }
}