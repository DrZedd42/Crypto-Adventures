pragma solidity ^0.4.18;

import "./createItem.sol";
import "../node_modules/zeppelin-solidity/contracts/ownership/Ownable.sol";
import "./getKitty.sol";

contract AdventuresBase is Ownable {
    event NewChar(uint charId,
                  string name,
                  uint8 str,
                  uint8 dex,
                  uint8 const,
                  uint8 intel,
                  uint8 wis,
                  uint8 charisma,
                  uint8 race,
                  bool turn,
                  uint64 creationTime);

    event NewItem(uint itemId,
                  string name,
                  uint8 itemType,
                  uint8 itemQuality,
                  uint8 effectQuality,
                  uint16 ofType,
                  uint16 effect,
                  // Timestamp when this item was created
                  uint64 creationTime);
    //Characters
    struct Char {
        string name;
        uint8 str;
        uint8 dex;
        uint8 const;
        uint8 intel;
        uint8 wis;
        uint8 charisma;
        uint8 race;
        bool turn;
        // Timestamp when this Char was created
        uint64 creationTime;
    }

    // Items
    struct Item {
        string name;
        uint8 itemType;
        uint8 itemQuality;
        uint8 effectQuality;
        uint16 ofType;
        uint16 effect;
        // Timestamp when this item was created
        uint64 creationTime;
    }

  // Create array of Playable Characters
  Char[] public chars; 
  // Create an array of items
  Item[] Items;

  uint32 armorCount = 1;
  uint32 weaponCount = 2;
  uint32 effectCount = 1; 

  // Mapping cats to Playable Characters to Owners
  mapping(uint => uint) catToCharacter;
  mapping(address => uint) ownerCharacterCount;
  mapping(uint => address) characterToOwner;
  // Mapping Items to playable Characters
  mapping(uint => Item[]) public characterToItems;
  mapping(uint => uint) public itemToCharacter;

  uint8[] public itemQuality = [5, 10, 11, 12, 13, 14, 15];
  uint8[] public effectQuality = [5, 10, 11, 12, 13, 14, 15];

  //generates a character from a Cryptokitty
  function _genCharacter() internal {

      //require(msg.sender == kittyToOwner[_kittyId]);
      //TODO check address owns cat
      //check cat doesn't already have a character
      uint256 dna = 0;
      /* assert(catToCharacter[dna] == 0); */

      //Generate Character Stats
      /* Char c = genStats(dna); */
      /* catToCharacter[dna] = c; */
      /* ownerToCharacters[msg.sender].push(c); */
      /* characterToOwner[c] = msg.sender; */

      //Edmund Cleaning
      // Some above this need cat id and 
      uint id = chars.push(Char()) - 1;//Add intial values
      // catToCharacter[uint] = oracle get cat id value
      ownerCharacterCount[msg.sender]++;
      // NewChar(genStats(dna));
  }

  function genStats(uint256 dna) public returns(Char) {
    uint256 tmp = dna;

    string charName = "nameOfCat";//Will implement later
    //2**42-1
    uint256 garbageNum = 4398046511103;

    uint str = (dna & garbageNum) % 6 - 2;
    tmp = tmp >> 42;
    uint dex = (dna & garbageNum) % 6 - 2;
    tmp = tmp >> 42;
    uint const = (dna & garbageNum) % 6 - 2;
    tmp = tmp >> 42;
    uint intel = (dna & garbageNum) % 6 - 2;
    tmp = tmp >> 42;
    uint wis = (dna & garbageNum) % 6 - 2;
    tmp = tmp >> 42;
    uint charisma = (dna & garbageNum) % 6 - 2;
    //tmp = tmp >> 42;
    return Char(charId, charName,10 + str, 10 + dex, 10 + const, 10 + intel, 10 + wis, 10 + charisma, 0, false, now);
  }

  /* Cleaning Kevin's bit shifting
  function kevinMagic(uint8 atr, uint256 dna, uint256 garbageNum, uint256 tmp) {
      atr = (dna & garbageNum) % 6 - 2;
      tmp = tmp >> 42;
  }*/
  function genItem(Char character) private {
    uint256 id = keccak256(genRand256());

    uint itemType = id & 1;
    id = id >> 1;
    uint ofType;
    if (itemType) {
      ofType = (id & 13) % weaponCount;
    } else {
      ofType = (id & 13) % armorCount;
    }
    id = id >> 13;
    uint q = itemQuality[(id & 3) % 7];
    id = id >> 3;
    uint effect = (id & 12) % effectCount;
    id = id >> 12;
    uint effectQ = effectQuality[(id & 3) % 7];

    Item i = Item(itemType, ofType, q, effect, effectQ, now);

    characterToItems[charId].push(i);
    itemToCharacter[i] = character;
  }

  function genRand256() public returns(string) {
      string storage s = "";
      for (int x = 0; x < 32; x++) {
        s += Char((now & 255)%256);
        //tune up
    }
      return s;
  }

}
