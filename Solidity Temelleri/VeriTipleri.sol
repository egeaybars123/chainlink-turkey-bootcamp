// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Integers {
    int public sayi_int;
    uint public sayi_256;
    uint8 public sayi_8;

    //int veri tipleri eksi sayılar da alabilir.
    function test_int(int input) public {
        sayi_int = input;
    }

    function int_islem() public view returns (int sonuc, int sonuc1) {
        sonuc = sayi_int + -1;
        sonuc1 = sayi_int / -2;
    }
    
    function test_uint(uint input) public {
        sayi_256 = input;
    }

    //255'ten büyük sayıları kabul etmez.
    function test_uint8(uint8 input) public {
        sayi_8 = input;
    }
}

contract Booleans {
    //iki değer alabilir: true ya da false.
    //varsayılan değer: false. 
    bool durum;

    function buyuktur(uint sayi) public {
        if (sayi > 5) {
            durum = true;
        }
        else {
            durum = false;
        }
    }
}

contract Strings {
    string public metin = "Chainlink";
    bytes32 public metin_bytes;

    function metniDegistir(string memory input) public {
        metin = input;
    }
    function metniDonustur() public {
        metin_bytes = bytes32(bytes(metin));
    }
}

contract AddressesBytes32 {
    address public kontratSahibi;
    bytes32 public deger;

    constructor() {
        kontratSahibi = msg.sender;
    }
    
    //0x436861696e6c696e6b205475726b657920426f6f7463616d7000000000000000
    //Chainlink Turkey Bootcamp
    function cevirme(bytes32 input) public {
        deger = input;
    }
}