// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

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

contract Address {
    address public kontratSahibi;

    constructor() {
        kontratSahibi = msg.sender;
    }
}

contract Enum {

    enum Okul {Ilkogretim, Lise, Universite, Mezun} //0,1,2,3
    struct Ogrenci {
        string isim;
        Okul ogrenim;
    }

    Ogrenci public ogrenci;

    function ogrenciDegistir(string memory isim, Okul okul) public {
        ogrenci.isim = isim;
        ogrenci.ogrenim = okul;
    }

    function ogrenciMezunEt() public {
        ogrenci.ogrenim = Okul.Mezun;
    }
}

contract Array {
    address[] adresListesi; //dynamic: eklenecek adres sayısında kısıtlama yok.
    address[2] statikListe; //statik: eklenebilecek maksimum adres sayısı belirtiliyor.

    function dinamikEkle(address adres) public {
        adresListesi.push(adres);
    }

    //statik array'lerde push fonksiyon bulunmuyor.
    function statikEkle(address adres, uint index) public {
        statikListe[index] = adres;
    }

    function dinamikUzunlukGoster() public view returns(uint) {
        return adresListesi.length;
    }

    function statikUzunlukGoster() public view returns(uint) {
        return statikListe.length;
    }

    function dinamikGoster() public view returns(address[] memory) {
        return adresListesi;
    }

    function statikGoster() public view returns(address[2] memory) {
        return statikListe;
    }
}

contract Mapping {
    mapping(address => uint256) public bakiye;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function bakiyeEkle(uint256 miktar, address adres) public sadeceKontratSahibi {
        bakiye[adres] += miktar;
    }

    modifier sadeceKontratSahibi {
        require(msg.sender == owner);
        _;
    }
}