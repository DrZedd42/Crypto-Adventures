pragma solidity ^0.4.18;

import "items/createItem.sol";
import "zeppelin-solidity/contracts/ownship/Ownable.sol";

contract AdventuresBase is ownable {
  //Characters
  struct Char {
      uint8 str;
      uint8 dex;
      uint8 const;
      uint8 intel;
      uint8 wis;
      uint8 charisma;
      unit256  race;
  }

  // Items
  struct Item {
    
    uint8 itemType;
    uint16 type;
    uint8 quality;
    uint16 effect;
    uint8 effectQuality;

    //timestampt when this item was created
    uint64 creationTime;
  }
  mapping(Char => Item[]) public CharacterToItems;
  mapping(Item => Char) public itemToCharacer;

  mapping(uint256 => Char) public catToCharacter;
  mapping(address => Char[]) public ownerToCharacters;
  mapping(Char => address) public characterToOwner;

  uint8[] public ItemQuality = [5, 10, 11, 12, 13, 14, 15];
  uint8[] public effectQuality = [5, 10, 11, 12, 13, 14, 15];

  //generates a character from a Cryptokitty
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

  function genItem(Char character) public {
     uint256 id = keccak256(genRand256());


  }

  function genRand256() public returns(string) {
    string s = "";
    for (int x = 0; x < 32; x++) {
      s += char((now & 255)%256);
      //tune up
    }
      return s;
  }

}
