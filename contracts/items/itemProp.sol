pragma solidity ^0.4.18;

import "createItem.sol";

contract Item {

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

  Item[] items;

}
