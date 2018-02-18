pragma solidity ^0.4.18;

contract Character{

    struct Char{
        uint8 str;
        uint8 dex;
        uint8 const;
        uint8 intel;
        uint8 wis;
        uint8 charisma;
        unit256  race;
    }

    Char[] public chars;

    mapping(uint => uint) catToCharacter;
    mapping(address => Char[]) ownerToCharacters;
    mapping(uint => address) characterToOwner;

    function genCharacter(uint256 dna) public {

        //TODO check address owns cat
        //check cat doesn't already have a character
        assert(catToCharacter[dna] == 0);

        uint256 tmp = dna;

        //2**42-1
        uint256 garbageNum = 4398046511103;

        uint8 str = (dna & garbageNum) % 6 - 2;
        tmp = tmp >> 42;
        uint8 dex = (dna & garbageNum) % 6 - 2;
        tmp = tmp >> 42;
        uint8 const = (dna & garbageNum) % 6 - 2;
        tmp = tmp >> 42;
        uint8 intel = (dna & garbageNum) % 6 - 2;
        tmp = tmp >> 42;
        uint8 wis = (dna & garbageNum) % 6 - 2;
        tmp = tmp >> 42;
        uint8 charisma = (dna & garbageNum) % 6 - 2;
        //tmp = tmp >> 42;
        Char c = Char(10 + str, 10 + dex, 10 + const, 10 + intel, 10 + wis, 10 + charisma, 0);

        catToCharacter[dna] = c;
        ownerToCharacters[msg.sender].append(c);
        characterToOwner[c] = msg.sender;
    }
}
