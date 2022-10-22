// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Fonksiyonlar {

    uint256 sayi;

    //Kontrat yayımlanınca internal fonksiyon butonu gözükmez.
    //Sebebi ise internal fonksiyonların sadece kontrat içindeki 
    //fonksiyonlar tarafından çağrılabilir. 
    function arttir() internal {
        sayi++;
    }

    function azalt() internal {
        sayi--;
    }

    function testArttir() public {
        arttir();
    }

    function testAzalt() public {
        azalt();
    }

    //Kontrat yayımlandığında public gibi çağrılma butonu vardır.
    //Fakat public'den farkı testExternal() fonksiyonunda görülebilir.
    function fonksiyon_external() external {
        sayi = 150;
    }

    function testExternal() public {
        //fonksiyon_external(); ifadesi derleme hatası verir.
        //Sebep: external fonksiyonlar kontratın içindeki diğer fonksiyonlar
        //tarafından çağrılamazlar. 

        //Fakat şu durumda external fonksiyonlar çağrılabilir:
        this.fonksiyon_external();
    }

    function testPrivate() private {
        sayi = 200;
    }

    function sayiGor() public view returns (uint256){
        return sayi;
    }
}

contract PrivateFunctions is Fonksiyonlar {

}