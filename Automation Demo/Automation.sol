// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/AutomationCompatible.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

contract Cekilis is AutomationCompatibleInterface, VRFConsumerBaseV2 {

    VRFCoordinatorV2Interface COORDINATOR;

    uint public counter;
    uint public immutable interval;
    uint public lastTimeStamp;

    //Goerli test ağı (VRF):
    uint64 constant subscriptionId = 71;
    address constant vrfCoordinator = 0x2Ca8E0C643bDe4C2E08ab1fA0da3401AdAD7734D;
    bytes32 constant keyHash = 0x79d3d8832d904592c0bf9818b621522c988bb8b0c05cdc3b15aea1b6e8db0c15;
    uint16 constant requestConfirmations = 3;
    uint32 constant callbackGasLimit = 150000;
    uint32 constant numWords = 1;

    struct CekilisBilgileri {
        uint256 rastgeleSayi;
        address[] katilimcilar;
        mapping(address => bool) durum;
    }
    
    mapping(uint256 => CekilisBilgileri) public cekilisRound;

    constructor(uint updateInterval) VRFConsumerBaseV2(vrfCoordinator) {
        COORDINATOR = VRFCoordinatorV2Interface(vrfCoordinator);
        interval = updateInterval;
        lastTimeStamp = block.timestamp;

        counter = 1;
    }

    function requestRandomWords() internal {
        COORDINATOR.requestRandomWords(
        keyHash,
        subscriptionId,
        requestConfirmations,
        callbackGasLimit,
        numWords
        );  
    }

    function fulfillRandomWords(
        uint256, /* requestID */
        uint256[] memory randomWords
    ) internal override {
        cekilisRound[counter - 1].rastgeleSayi = randomWords[0]; 
    }

    function checkUpkeep(bytes calldata /* checkData */) external view override returns (bool upkeepNeeded, bytes memory performData) {
        upkeepNeeded = (block.timestamp - lastTimeStamp) > interval;
        performData = "";
        
    }

    function performUpkeep(bytes calldata /* performData */) external override {
        //Güvenlik için if ifadesi ile bir daha kontrol ediyoruz.
        if ((block.timestamp - lastTimeStamp) > interval ) {
            lastTimeStamp = block.timestamp;
            counter = counter + 1;
            requestRandomWords();
        }
    }

    function yarismayaKatil() external {
        require(!cekilisRound[counter].durum[msg.sender], "Mevcut raunt icin katilim saglanmistir");
        cekilisRound[counter].durum[msg.sender] = true;
        address[] storage liste = cekilisRound[counter].katilimcilar;
        liste.push(msg.sender);
    }
}