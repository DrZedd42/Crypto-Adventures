pragma solidity ^0.4.18;

import "items/createItem.sol"
import "zeppelin-solidity/contracts/ownship/Ownable.sol"

contract adventuresBase is ownable {
  //Characters
  struct Char{
      uint8 str;
      uint8 dex;
      uint8 const;
      uint8 intel;
      uint8 wis;
      uint8 charisma;
      unit256  race;
  }

  mapping(uint256 => Char) catToCharacter;
  mapping(address => Char[]) ownerToCharacters;
  mapping(Char => address) characterToOwner;

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

  // Items
  struct Item {
    // Shamelessly stolen from Etherbots
    // [0] part type (representing, i.e., "weapon") 1 = staff, 2 = sword, 3 = shield, 4 = hat
    // Will add more post hackathon
    // [1] part ID (representing, i.e., "Sword")
    // [2] part level (experience),
    // [3] rarity status, (representing, i.e., "gold")
    // 1 = broken, 2 = poor, 3 = average, 4 = sturdy, 5 = superior, 6 = ultra, 7 = divine
    // [4] elemental type, (i.e., "water")
    // 1 - magic, 2 - dark, 3 - fire, 4 - poison, 5 - plasma
    // [5] attack type (i.e., "slashing") 1 = piercing, 2 = slashing, 3 = blunt
    // [6-7] spare storage
    uint32[8] stats;

    // Timestamp when this item came into existance
    uint64 creationTime;
  }
  // Create an array of items
  Item[] items;
}
