pragma solidity ^0.4.18;

import "./createItem.sol";
import "../node_modules/zeppelin-solidity/contracts/ownership/Ownable.sol";
import "./getKitty.sol";

contract AdventuresBase is Ownable {
  //Characters
  struct Char {
      uint8 str;
      uint8 dex;
      uint8 const;
      uint8 intel;
      uint8 wis;
      uint8 charisma;
      uint8 race;
      bool turn;
      uint64 creationTime;
  }

  // Items
  struct Item {

      uint8 itemType;
      uint8 itemQuality;
      uint8 effectQuality;
      uint16 ofType;
      uint16 effect;
      // Timestamp when this item was created
      uint64 creationTime;
  }

  // Create array of Playable Characters
  Char[] public Chars; 
  // Create an array of items
  Item[] Items;

  uint32 armorCount = 1;
  uint32 weaponCount = 2;
  uint32 effectCount = 1; 

  // Mapping cats to Playable Characters to Owners
  mapping(uint => uint) catToCharacter;
  mapping(address => Char[]) ownerToCharacters;
  mapping(uint => address) characterToOwner;
  // Mapping Items to playable Characters
  mapping(uint => Item[]) public characterToItems;
  mapping(uint => uint) public itemToCharacter;

  uint8[] public itemQuality = [5, 10, 11, 12, 13, 14, 15];
  uint8[] public effectQuality = [5, 10, 11, 12, 13, 14, 15];

  //generates a character from a Cryptokitty
  function genCharacter() public {

      //require(msg.sender == kittyToOwner[_kittyId]);
      //TODO check address owns cat
      //check cat doesn't already have a character
      uint256 dna = 0;
      assert(catToCharacter[dna] == 0);

      //Generate Character Stats
      Char storage c = genStats(dna);
      catToCharacter[dna] = c;
      ownerToCharacters[msg.sender].append(c);
      characterToOwner[c] = msg.sender;
  }

  function genStats(uint256 dna) private returns(Char) {
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
    return Char(10 + str, 10 + dex, 10 + const, 10 + intel, 10 + wis, 10 + charisma, 0, now);
  }

  /* Cleaning Kevin's bit shifting
  function kevinMagic(uint8 atr, uint256 dna, uint256 garbageNum, uint256 tmp) {
      atr = (dna & garbageNum) % 6 - 2;
      tmp = tmp >> 42;
  }*/
  function genItem(Char character) public {
    uint256 id = keccak256(genRand256());

    uint8 itemType = id & 1;
    id = id >> 1;
    uint16 ofType;
    if (itemType) {
      ofType = (id & 13) % weaponCount;
    } else {
      ofType = (id & 13) % armorCount;
    }
    id = id >> 13;
    uint8 q = itemQuality[(id & 3) % 7];
    id = id >> 3;
    uint16 effect = (id & 12) % effectCount;
    id = id >> 12;
    uint8 effectQ = effectQuality[(id & 3) % 7];

    Item storage i = Item(itemType, ofType, q, effect, effectQ, now);

    characterToItems[character].append(i);
    itemToCharacter[i] = character;
  }

  function genRand256() public returns(string) {
      string storage s = "";
      for (int x = 0; x < 32; x++) {
        s += char((now & 255)%256);
        //tune up
    }
      return s;
  }

}
