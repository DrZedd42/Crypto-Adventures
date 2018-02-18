pragma solidity ^0.4.18;

import "./base.sol";

contract KittyInterface {

  function getKitty(uint256 _id) external view returns (
                                                        bool isGestating,
                                                        bool isReady,
                                                        uint256 cooldownIndex,
                                                        uint256 nextActionAt,
                                                        uint256 siringWithId,
                                                        uint256 birthTime,
                                                        uint256 matronId,
                                                        uint256 sireId,
                                                        uint256 generation,
                                                        uint256 genes
                                                        );
}

contract KittyBase {
  address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
  KittyInterface kittyContract = KittyInterface(ckAddress);

  function setKittyContractAddress(address _address) external {
    kittyContract = KittyInterface(_address);
  }

  function getKittyDna(uint _kittyId) public returns (uint256) {
    uint kittyDna;
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    return kittyDna;
  }
  //Add Kitty Oracle
}
